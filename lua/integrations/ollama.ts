import { getCopilotExtendedVimAPI } from "../plugins/copilot";
import { CONFIGURATION } from "../toggles";

export function setupOllamaCopilot(this: void) {
  const vim = getCopilotExtendedVimAPI();
  if (!CONFIGURATION.ollama.enabled || !CONFIGURATION.useCopilot) {
    return;
  }
  vim.g.copilot_proxy = "http://localhost:11435";
  vim.g.copilot_proxy_strict_ssl = false;
  if (vim.fn.executable("go")) {
    vim.notify("Cannot configure copilot ollama proxy: the `go` binary is not installed", vim.log.levels.ERROR);
    return;
  }
  vim.fn.system(["go", "install", "github.com/bernardo-bruning/ollama-copilot@latest"]);
  if (vim.v.shell_error !== 0) {
    vim.notify("An error occurred while installing `ollama-copilot@latest`.", vim.log.levels.ERROR);
    return;
  }
  const username = os.getenv("USER");
  if (username === undefined) {
    vim.notify("$USER var is unset", vim.log.levels.ERROR);
    return;
  }
  const ollamaPath = `/home/${username}/go/bin/ollama-copilot`;
  if (!vim.fn.executable(ollamaPath)) {
    vim.notify("Unable to locate ollama-copilot binary");
    return;
  }

  const handle = vim.loop.spawn(ollamaPath, {
    detached: true
  }, (code, signal) => {
    vim.notify(`ollama exited: signal(${signal}) code(${code})`);
    handle.close();
  });
}
