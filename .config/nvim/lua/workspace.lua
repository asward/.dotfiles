-- WORKSPACE
local project_config = vim.fn.getcwd() .. "/.nvimrc.lua"
local config_result = nil

-- WORKSPACE
local project_config = vim.fn.getcwd() .. "/.nvimrc.lua"

local config_result = nil

if vim.fn.filereadable(project_config) == 1 then
  local chunk, err = loadfile(project_config)
  if chunk then
    config_result = chunk()
    if config_result then
      vim.notify('Config result keys: ' .. vim.inspect(vim.tbl_keys(config_result)))
    end
  else
    vim.notify('Error loading chunk: ' .. (err or 'unknown'))
  end
end

-- Mason Configuration
local function load_lsp(servers)
  vim.notify('Loading workspace LSPs')
  -- Check if Mason is available
  local mason_ok, mason = pcall(require, 'mason')
  if not mason_ok then
    vim.notify('Mason not found - please install mason.nvim', vim.log.levels.WARN)
    return false
  end

  local registry_ok, mason_registry = pcall(require, 'mason-registry')
  if not registry_ok then
    vim.notify('Mason registry not found', vim.log.levels.WARN)
    return false
  end

  -- Install missing servers
  for _, server in ipairs(servers) do
    if not mason_registry.is_installed(server) then
      vim.notify('Installing ' .. server .. '...', vim.log.levels.INFO)
      vim.cmd('MasonInstall ' .. server)
    end
  end
  
  return true
end

-- LSP Configuration
local function configure_lsp(lsp_configs)
    vim.notify('Configuring workspace LSPs')
  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_ok then
    vim.notify('lspconfig not found - please install nvim-lspconfig', vim.log.levels.WARN)
    return false
  end

  -- Common LSP capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- Add completion capabilities if nvim-cmp is available
  local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- Setup each LSP server from config map
  for server_name, config in pairs(lsp_configs) do
    local server_config = vim.tbl_deep_extend('force', {
      capabilities = capabilities,
    }, config)
    
    -- Convert root_dir_patterns to root_dir function if present
    if config.root_dir_patterns then
      server_config.root_dir = lspconfig.util.root_pattern(unpack(config.root_dir_patterns))
      server_config.root_dir_patterns = nil
    end
    
    lspconfig[server_name].setup(server_config)
  end
  
  return true
end

-- Check and use lsp_configs and lsp_servers
if config_result then
 if config_result.lsp_servers and next(config_result.lsp_servers) then
   load_lsp(config_result.lsp_servers)
 end

 if config_result.lsp_configs and next(config_result.lsp_configs) then
   configure_lsp(config_result.lsp_configs)
 end
end
