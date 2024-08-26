import { usePersistentValue } from "../persistent-data";

let configuration: GlobalConfiguration = undefined!;

const [getGlobalConfig, setGlobalConfig] = usePersistentValue('configuration.json', {});

function reloadConfiguration() {
  let config = getGlobalConfig();
  if (Object.keys(config).length < 1) {
    // Empty, apply default config
    configuration = CONFIGURATION_DEFAULTS;
    saveGlobalConfiguration();
    configuration = getGlobalConfig() as GlobalConfiguration;
  }
  else {
    configuration = config as GlobalConfiguration;
  }
}

function saveConfiguration() {
  setGlobalConfig(configuration);
}

type GlobalConfiguration = {
  packages: {
    [key: string]: {
      enabled: boolean,
      config?: unknown
    } | undefined
  },
  targetEnvironments: {
    [key: string]: {
      enabled: boolean
    } | undefined
  },
  shell: {
    target: 'tmux',
    isolationScope: 'global' | 'neovim-shared' | 'isolated',
  },
  integrations: {
    [key: string]: {
      enabled: boolean
      config?: unknown
    } | undefined
  }
}

export const CONFIGURATION_DEFAULTS: GlobalConfiguration = {
  packages: {
    lspLines: {
      enabled: false
    },
    cmp: {
      enabled: true
    },
    telescope: {
      enabled: true,
    },
    lspUI: {
      enabled: false
    },
    rustaceanvim: {
      enabled: true
    },
    lspSignature: {
      enabled: true
    },
    indentBlankline: {
      enabled: true
    },
    treeDevIcons: {
      enabled: true
    },
    luaLine: {
      enabled: true,
    },
    barBar: {
      enabled: true
    },
    comments: {
      enabled: true
    },
    marks: {
      enabled: true
    },
    trouble: {
      enabled: true
    },
    outline: {
      enabled: true
    },
    glance: {
      enabled: true
    },
    nvimDapUI: {
      enabled: true,
      config: {
        lldb: {
          port: 1828,
        }
      }
    },
    diffView: {
      enabled: true
    },
    lazyGit: {
      enabled: true
    },
    noice: {
      enabled: false
    },
    nvimNotify: {
      enabled: true
    },
    copilot: {
      enabled: false
    },
    actionsPreview: {
      enabled: true
    },
    fireNvim: {
      enabled: true,
    },
    ufo: {
      enabled: true
    },
    lspconfig: {
      enabled: true,
      config: {
        inlayHints: {
          enabled: true,
          displayMode: 'only-in-normal-mode'
        }
      }
    }
  },
  targetEnvironments: {
    typescript: {
      enabled: true
    }
  },
  shell: {
    target: 'tmux',
    isolationScope: 'isolated'
  },
  integrations: {
    ollama: {
      enabled: true,
    }
  }
};

export function getGlobalConfiguration() {
  if (configuration === undefined) {
    reloadConfiguration();
  }
  return configuration;
}

export function saveGlobalConfiguration() {
  saveConfiguration();
}
