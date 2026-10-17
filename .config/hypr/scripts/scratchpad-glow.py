#!/usr/bin/python3
# White glow around an open scratchpad (special workspace), shown even when the
# pad is empty. Draws a click-through layer-shell overlay over the outer gap:
# solid next to the pad, fading out toward the screen edge.
#
# Listens on Hyprland's event socket and re-checks `hyprctl monitors -j` on each
# activespecial event, so it follows every monitor independently.
# Uses system python (/usr/bin/python3) for gi + gtk-layer-shell.

import json
import os
import socket
import subprocess
import threading

import cairo
import gi

gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import GLib, Gtk, GtkLayerShell  # noqa: E402

GAP = 60  # must match gaps_out of the scratchpad workspace rules in rules.lua
MAX_ALPHA = 0.85  # opacity right next to the pad


class Glow(Gtk.Window):
    def __init__(self, gdk_monitor):
        super().__init__()
        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_monitor(self, gdk_monitor)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_namespace(self, "scratchpad-glow")
        GtkLayerShell.set_keyboard_mode(self, GtkLayerShell.KeyboardMode.NONE)
        for edge in (GtkLayerShell.Edge.TOP, GtkLayerShell.Edge.BOTTOM,
                     GtkLayerShell.Edge.LEFT, GtkLayerShell.Edge.RIGHT):
            GtkLayerShell.set_anchor(self, edge, True)
        # exclusive zone 0: stay inside the area waybar leaves, like the pad does

        screen = self.get_screen()
        self.set_visual(screen.get_rgba_visual())
        self.set_app_paintable(True)
        self.connect("draw", self.on_draw)
        # empty input region = pointer passes straight through. Set on the widget,
        # not the GdkWindow: GtkWindow resets the GdkWindow's input shape itself.
        self.input_shape_combine_region(cairo.Region())
        # Stays mapped all the time and just repaints: hide()/show() remaps the
        # layer, and Hyprland left remapped layers at alpha 0.
        self.active = False
        self.show_all()

    def set_active(self, active):
        if active != self.active:
            self.active = active
            self.queue_draw()

    def on_draw(self, _widget, cr):
        w = self.get_allocated_width()
        h = self.get_allocated_height()
        cr.set_operator(cairo.OPERATOR_CLEAR)
        cr.paint()
        if not self.active:
            return False
        cr.set_operator(cairo.OPERATOR_OVER)
        cr.set_line_width(1)
        # nested 1px outlines: i=0 hugs the pad, i=GAP-1 is the screen edge
        for i in range(GAP):
            alpha = MAX_ALPHA * (1 - i / GAP) ** 2
            inset = GAP - i - 0.5
            cr.set_source_rgba(1, 1, 1, alpha)
            cr.rectangle(inset, inset, w - 2 * inset, h - 2 * inset)
            cr.stroke()
        return False


class App:
    def __init__(self):
        display = Gtk.Window().get_display()
        self.glows = {}  # (x, y) of monitor -> Glow
        for n in range(display.get_n_monitors()):
            mon = display.get_monitor(n)
            geo = mon.get_geometry()
            self.glows[(geo.x, geo.y)] = Glow(mon)
        self.refresh()

    def refresh(self):
        try:
            mons = json.loads(subprocess.run(["hyprctl", "monitors", "-j"],
                                             capture_output=True, text=True).stdout)
        except (json.JSONDecodeError, OSError):
            return False
        for m in mons:
            glow = self.glows.get((m["x"], m["y"]))
            if glow is None:
                continue
            glow.set_active(bool(m["specialWorkspace"]["name"]))
        return False


def listen(app):
    sock_path = os.path.join(os.environ["XDG_RUNTIME_DIR"], "hypr",
                             os.environ["HYPRLAND_INSTANCE_SIGNATURE"], ".socket2.sock")
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(sock_path)
    for line in s.makefile("r"):
        if line.startswith(("activespecial>>", "monitoradded", "monitorremoved")):
            GLib.idle_add(app.refresh)
    GLib.idle_add(Gtk.main_quit)  # Hyprland went away


if __name__ == "__main__":
    app = App()
    threading.Thread(target=listen, args=(app,), daemon=True).start()
    Gtk.main()
