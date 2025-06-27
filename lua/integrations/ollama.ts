import { getGlobalConfiguration } from "../helpers/configuration";
import { getOpenPorts } from "../helpers/network/getOpenPort";
import { setImmediate, setTimeout } from "../shims/mainLoopCallbacks";

const ollamaCopilotExecutable = "ollama-copilot";
const ollamaExecutable = "ollama";
export function isOllamaIntegrationAllowed(): ({
  success: true
} | {
  success: false,
  reason?: string
}) {
  if (!(getGlobalConfiguration().integrations["ollama"]?.enabled ?? false)) {
    return {
      success: false,
      reason: 'Ollama integration is not enabled in configuration'
    };
  }
  // Locate the ollama-copilot executable and make sure it's available
  if (vim.fn.executable(ollamaCopilotExecutable) == 0) {
    return {
      success: false,
      reason: `Could not find ${ollamaCopilotExecutable}.`
    };
  }

  if (vim.fn.executable(ollamaExecutable) == 0) {
    return {
      success: false,
      reason: `Could not find ${ollamaExecutable}.`
    };
  }

  {
    // Ensure ollama is running
    const output = vim.fn.system(["pidof", "ollama"]);

    if (output === "") {
      return {
        success: false,
        reason: `ollama is not running`
      };
    }
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
      setTimeout(() => {
        vim.notify(`Ollama integration is enabled, but ${result.reason}.`, vim.log.levels.ERROR);
      }, 2500);
    }
    else {
      const args: string[] = [];
      const config = { ...getOllamaConfig() };
      if ('port' in config || config.disableAutoPortAlloc === true) {
        vim.notify(`Because port is manually specified in ollama integration configuration, a port cannot be automatically allocated. This may lead to conflicts between multiple instances of Neovim`, vim.log.levels.WARN);
        (vim.g as any).copilot_proxy = `http://localhost:11435`; // Default ollama port
        (vim.g as any).copilot_proxy_strict_ssl = false;
      }
      else {
        const [port, portSsl, proxyPort, proxyPortSsl] = getOpenPorts({ count: 4 });
        config.port = `:${port}`;
        config["port-ssl"] = `:${portSsl}`;
        config["proxy-port"] = `:${proxyPort}`;
        config["proxy-port-ssl"] = `:${proxyPortSsl}`;
        (vim.g as any).copilot_proxy = `http://localhost:${proxyPortSsl}`;
        (vim.g as any).copilot_proxy_strict_ssl = false;
      }
      for (const key in config) {
        const value = config[key];
        args.push(`--${key}`);
        if (typeof value !== 'boolean') {
          args.push(value.toString());
        }
      }

      const command = `${ollamaCopilotExecutable} ${args.join(" ")}`;

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
