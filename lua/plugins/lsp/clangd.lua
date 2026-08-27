local lspconfig = require("lspconfig")
return {
  cmd = {
    "clangd",
    "--background-index",
    "--query-driver=" .. vim.fn.expand("~/.platformio/packages/**/bin/*gcc*,~/.platformio/packages/**/bin/*g++*"),
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  -- root_dir = lspconfig.util.root_pattern("compile_commands.json", "platformio.ini", ".git"),
}
