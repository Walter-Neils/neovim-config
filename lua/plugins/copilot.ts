import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { applyKeyMapping } from "../helpers/keymap";
import { useExternalModule } from "../helpers/module/useModule";
import { isOllamaIntegrationAllowed } from "../integrations/ollama";
import { setTimeout } from "../shims/mainLoopCallbacks";

type DeepPartial<T> = {
  [P in keyof T]?: DeepPartial<T[P]>;
};

type CopilotConfig = {
  panel: {
    enabled: boolean,
    auto_refresh: boolean,
    keymap: {
      jump_prev: string | boolean,
      jump_next: string | boolean,
      accept: string | boolean,
      refresh: string | boolean,
      open: string | boolean,
    },
    layout: {
      position: 'bottom' | 'top' | 'left' | 'right',
      ratio: number
    },
  },
  suggestion: {
    enabled: boolean,
    auto_trigger: boolean,
    hide_during_completion: boolean,
    debounce: number,
    keymap: {
      accept: string | boolean,
      accept_word: string | boolean,
      accept_line: string | boolean,
      next: string | boolean,
      prev: string | boolean,
      dismiss: string | boolean,
    }
  },
  filetypes: {
    [key: string]: boolean | undefined
  },
  copilot_node_command: string,
  server_opts_overrides: Record<string, unknown>
};

type CopilotModule = {
  setup: (this: void, config: DeepPartial<CopilotConfig>) => void,
};

export function getCopilot() {
  const copilot = useExternalModule<CopilotModule>('copilot');
  return copilot;
}

const plugin: LazyPlugin = {
  1: 'Walter-Neils/copilot.lua',
  //dir: '/tmp/copilot.lua',
  //dev: true,
  cmd: ["Copilot"],
  event: 'InsertEnter',
  config: () => {
    const lspConfig = {
      trace: 'verbose',
      settings: {
        advanced: {
          inlineSuggestionCount: 10,
        } as any
      }
    };

    if (getGlobalConfiguration().integrations["ollama"]?.enabled) {
      const result = isOllamaIntegrationAllowed();
      if (result.success) {
        //(vim.g as any).copilot_proxy = 'http://localhost:11435';
        //(vim.g as any).copilot_proxy_strict_ssl = false;
      }
      else {
        vim.notify(`Cannot enable ollama proxy: ${result.reason ?? '[NO REASON PROVIDED]'}`, vim.log.levels.ERROR);
      }

    }

    getCopilot().setup({
      panel: {
        enabled: false,
      },
      suggestion: {
        auto_trigger: true,
        keymap: {
          accept: '<M-CR>',
          accept_line: '<M-j>',
          accept_word: '<M-l>'
        }
      },
      server_opts_overrides: lspConfig
    });
  }
};
export { plugin as default };
