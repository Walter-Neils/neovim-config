import { getGlobalConfiguration } from "../helpers/configuration";

const targetExecutable = "ollama-copilot";
export function isOllamaIntegrationAllowed(): ({
  success: true
} | {
  success: false,
  reason?: string
}) {
  // Locate the ollama-copilot executable and make sure it's available
  if (vim.fn.executable(targetExecutable) == 0) {
    vim.notify(`Ollama integration is enabled, but ${targetExecutable} could not be found.`, vim.log.levels.ERROR);
    return {
      success: false,
      reason: `Could not find ${targetExecutable}.`
    };
  }

  return {
    success: true
  }
}

function getOllamaConfig() {
  type Config = {
    [key: string]: string | boolean | number
  };
  const remoteConfig = getGlobalConfiguration().integrations.ollama?.config ?? {};
  return remoteConfig as Config;
}

export function ollamaIntegration() {
  if (getGlobalConfiguration().integrations.ollama?.enabled) {
    const result = isOllamaIntegrationAllowed();
    if (!result.success) {
      vim.notify(`Ollama integration is enabled, but ${result.reason}.`, vim.log.levels.ERROR);
    }
    else {
      const args: string[] = [];
      const config = getOllamaConfig();
      for (const key in config) {
        const value = config[key];
        args.push(`--${key}`);
        if (typeof value !== 'boolean') {
          args.push(value.toString());
        }
      }
      const command = `${targetExecutable} ${args.join(" ")}`;

      const ioHandler = (_id: number, data: string, name: 'stdin' | 'stdout' | 'stderr') => {
      };

      vim.fn.jobstart(command, {
        on_stdout: ioHandler,
        on_stderr: ioHandler,
        on_stdin: ioHandler,
        on_exit: (id: number, code: number, signal: string) => {
          vim.notify(`Ollama exited with code ${code} and signal ${signal}`, vim.log.levels.ERROR);
        }
      });
    }
  }
}
