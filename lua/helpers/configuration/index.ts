import { isRunningUnderNixOS } from "../../custom/nixos";
import { usePersistentValue } from "../persistent-data";
import { parseArgs } from "../user_command/argparser";

let configuration: GlobalConfiguration = undefined!;

const [getGlobalConfig, setGlobalConfig] = usePersistentValue(
  "configuration.json",
  {},
);

function reloadConfiguration() {
  let config = getGlobalConfig();
  if (Object.keys(config).length < 1) {
    // Empty, apply default config
    configuration = CONFIGURATION_DEFAULTS;
    saveGlobalConfiguration();
    configuration = getGlobalConfig() as GlobalConfiguration;
  } else {
    configuration = config as GlobalConfiguration;
  }
}

function saveConfiguration() {
  setGlobalConfig(configuration);
}

type GlobalConfiguration = {
  packages: {
    [key: string]: {
      enabled: boolean;
      config?: unknown;
    } | undefined;
  };
  targetEnvironments: {
    [key: string]: {
      enabled: boolean;
    } | undefined;
  };
  shell: {
    target: "tmux";
    isolationScope: "global" | "neovim-shared" | "isolated";
  };
  integrations: {
    [key: string]: {
      enabled: boolean;
      config?: unknown;
    } | undefined;
  };
};

export const CONFIGURATION_DEFAULTS: GlobalConfiguration = {
  packages: {
    mason: {
      // Mason doesn't work correctly under NixOS
      enabled: !isRunningUnderNixOS(),
    },
    nvimTree: {
      enabled: true,
    },
    floatTerm: {
      enabled: true,
    },
    autoPairs: {
      enabled: true,
    },
    lspConfig: {
      enabled: true,
    },
    treeSitter: {
      enabled: true,
    },
    lspLines: {
      enabled: false,
    },
    cmp: {
      enabled: true,
    },
    telescope: {
      enabled: true,
    },
    lspUI: {
      enabled: false,
    },
    rustaceanvim: {
      enabled: true,
    },
    lspSignature: {
      enabled: true,
    },
    indentBlankline: {
      enabled: true,
    },
    treeDevIcons: {
      enabled: true,
    },
    luaLine: {
      enabled: true,
    },
    barBar: {
      enabled: true,
    },
    comments: {
      enabled: true,
    },
    marks: {
      enabled: true,
    },
    trouble: {
      enabled: true,
    },
    outline: {
      enabled: true,
    },
    glance: {
      enabled: true,
    },
    nvimDapUI: {
      enabled: true,
      config: {
        lldb: {
          port: 1828,
        },
      },
    },
    diffView: {
      enabled: true,
    },
    lazyGit: {
      enabled: true,
    },
    noice: {
      enabled: false,
    },
    nvimNotify: {
      enabled: true,
    },
    copilot: {
      enabled: false,
    },
    actionsPreview: {
      enabled: true,
    },
    fireNvim: {
      enabled: true,
    },
    ufo: {
      enabled: true,
    },
    lspconfig: {
      enabled: true,
      config: {
        inlayHints: {
          enabled: true,
          displayMode: "only-in-normal-mode",
        },
      },
    },
    markdownPreview: {
      enabled: true,
    },
    gitBrowse: {
      enabled: true,
    },
    obsidian: {
      enabled: true,
      config: {
        workspaces: [
          {
            name: "notes",
            path: "~/Documents/obsidian/notes",
          },
        ],
      },
    },
    undoTree: {
      enabled: true,
    },
  },
  targetEnvironments: {
    typescript: {
      enabled: true,
    },
    deno: {
      enabled: false,
    },
    "c/c++": {
      enabled: true,
    },
    "markdown": {
      enabled: true,
    },
  },
  shell: {
    target: "tmux",
    isolationScope: "isolated",
  },
  integrations: {
    ollama: {
      enabled: true,
    },
  },
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

vim.api.nvim_create_user_command("Configuration", (_args) => {
  const args = parseArgs<
    {
      mode: "delete";
      key: string;
    } | {
      mode: "list";
      key: string;
    } | {
      mode: "get";
      key: string;
    } | {
      mode: "set";
      type?: "string" | "number" | "boolean";
      key: string;
      value: string;
    }
  >(_args.fargs);
  if (args.mode === "delete") {
    let parts = args.key.split(".").reverse();
    const currentTarget = function () {
      return parts[parts.length - 1];
    };
    let current: any = getGlobalConfiguration();
    while (parts.length > 1) {
      let next = current[currentTarget()];
      if (next === undefined) {
        next = {};
        current[currentTarget()] = next;
        current = next;
      } else {
        current = next;
      }
      parts.pop();
    }
    current[currentTarget()] = undefined;
    saveGlobalConfiguration();
  } else if (args.mode === "list") {
    args.key ??= "";
    let parts = args.key.split(".").reverse();
    if (args.key === "") {
      parts = [];
    }
    const currentTarget = function () {
      return parts[parts.length - 1];
    };
    let current: any = getGlobalConfiguration();
    while (parts.length > 0) {
      current = current[currentTarget()];
      parts.pop();
    }
    if (typeof current === "undefined") {
      console.error(`Config path '${args.key}' is undefined`);
      return;
    } else if (typeof current === "object") {
      for (const key in current) {
        console.log(`'${key}': <${current[key]}> (${typeof current[key]})`);
      }
    } else {
      console.log(`${current}`);
    }
  } else if (args.mode === "get") {
    let parts = args.key.split(".").reverse();
    const currentTarget = function () {
      return parts[parts.length - 1];
    };
    let current: any = getGlobalConfiguration();
    while (parts.length > 1) {
      current = current[currentTarget()];
      parts.pop();
    }
    console.log(`${current[parts[0]]}`);
  } else if (args.mode === "set") {
    let parts = args.key.split(".").reverse();
    const currentTarget = function () {
      return parts[parts.length - 1];
    };
    let current: any = getGlobalConfiguration();
    while (parts.length > 1) {
      let next = current[currentTarget()];
      if (next === undefined) {
        next = {};
        current[currentTarget()] = next;
        current = next;
      } else {
        current = next;
      }

      parts.pop();
    }
    const currentType = args.type ?? typeof current[currentTarget()];
    if (currentType === "undefined") {
      console.error(
        "Cannot infer desired type from existing value: does not exist. ",
      );
      console.error("Supply --type 'string' | 'number' | 'boolean' argument");
      return;
    }
    if (currentType === "string") {
      current[currentTarget()] = args.value;
    } else if (currentType === "boolean") {
      current[currentTarget()] = args.value === "true";
    } else if (currentType === "number") {
      current[currentTarget()] = tonumber(args.value);
    } else {
      throw new Error(
        `Cannot convert target type to ${currentType}: unsupported`,
      );
    }
    saveGlobalConfiguration();
  } else {
    const target = (args as any).mode;
    if (target === undefined) {
      console.warn("Argument 'mode' is required, either get or set");
    } else {
      console.error(`Mode '${target}' is unsupported`);
    }
  }
}, {
  nargs: "*",
});
