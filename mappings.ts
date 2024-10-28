import { isRunningInsideTmux, selectCustomTmuxScope } from "./lua/custom/tmux";
import { getGlobalConfiguration } from "./lua/helpers/configuration";
import { applyKeyMapping } from "./lua/helpers/keymap";
import { oneOffFunction } from "./lua/helpers/one-off";
import { getActionsPreview } from "./lua/plugins/actions-preview";
import { getCSharp } from "./lua/plugins/csharp";
import { getDap, getDapUI, manageBreakpoint } from "./lua/plugins/nvim-dap-ui";

vim.g.mapleader = " "; // Use space key as leader

vim.cmd("map w <Nop>");
vim.cmd("map W <Nop>");

const MOVEMENT_DIRECTION_KEYS = {
  left: {
    key: 'h',
    command: "<Left>"
  },
  right: {
    key: 'l',
    command: "<Right>"
  },
  up: {
    key: 'k',
    command: "<Up>"
  },
  down: {
    key: 'j',
    command: "<Down>"
  }
};

// ----- CURSOR MOVEMENT BINDINGS ----- //
for (const direction in MOVEMENT_DIRECTION_KEYS) {
  const key = MOVEMENT_DIRECTION_KEYS[direction as keyof typeof MOVEMENT_DIRECTION_KEYS];
  applyKeyMapping({
    mode: 'i',
    inputStroke: `<C-${key.key}>`,
    outputStroke: key.command,
    options: {
      desc: `move ${direction}`
    }
  });
}

// ----- WINDOW MOVEMENT BINDINGS ----- //
for (const direction in MOVEMENT_DIRECTION_KEYS) {
  const key = MOVEMENT_DIRECTION_KEYS[direction as keyof typeof MOVEMENT_DIRECTION_KEYS];
  applyKeyMapping({
    mode: 'n',
    inputStroke: `<C-${key.key}>`,
    outputStroke: `<C-w>${key.key}`,
    options: {
      desc: `switch window ${direction}`
    }
  });
}

const config = getGlobalConfiguration();

function getPackage<TConfig = unknown>(key: string) {
  const target = config.packages[key];
  if (target === undefined) {
    return [false, undefined] as const;
  }
  else {
    return [target.enabled, target.config as (TConfig | undefined)] as const;
  }
}

{
  const [enabled] = getPackage('barBar');
  if (enabled) {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>x',
      outputStroke: '<cmd>BufferClose<CR>',
      options: {
        desc: 'Close current buffer'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<Tab>',
      outputStroke: '<cmd>BufferNext<CR>',
      options: {
        desc: 'Switch buffer'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: `<A-h>`,
      outputStroke: `<cmd>:BufferPrevious <CR>`,
      options: {
        desc: `previous buffer`
      }
    });

    applyKeyMapping({
      mode: 'n',
      inputStroke: `<A-l>`,
      outputStroke: `<cmd>:BufferNext <CR>`,
      options: {
        desc: `next buffer`
      }
    });
  } else {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>x',
      outputStroke: '<cmd>:bd<CR>:bnext<CR>',
      options: {
        desc: 'Close current buffer'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: `<A-h>`,
      outputStroke: `<cmd>:bprev <CR>`,
      options: {
        desc: `previous buffer`
      }
    });

    applyKeyMapping({
      mode: 'n',
      inputStroke: `<A-l>`,
      outputStroke: `<cmd>:bnext <CR>`,
      options: {
        desc: `next buffer`
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<Tab>',
      outputStroke: "<cmd>:bnext<CR>",
      options: {
        desc: 'Switch next buffer'
      }
    });
  }
}

// Open splits
applyKeyMapping({
  mode: 'n',
  inputStroke: '<leader>s',
  outputStroke: '<cmd>:vsplit<CR>',
  options: {
    desc: 'vertical split'
  }
});

// Open splits
applyKeyMapping({
  mode: 'n',
  inputStroke: '<leader>h',
  outputStroke: '<cmd>:split<CR>',
  options: {
    desc: 'horizontal split'
  }
});

// Clear highlights on ESC
applyKeyMapping({
  mode: 'n',
  inputStroke: "<Esc>",
  outputStroke: "<cmd>noh<CR>",
  options: {
    desc: "general clear highlights"
  }
});

// nvim-tree
applyKeyMapping({
  mode: 'n',
  inputStroke: "<C-n>",
  outputStroke: "<cmd>NvimTreeToggle<CR>",
  options: {
    desc: "toggle file tree"
  }
});

{
  const [enabled] = getPackage('floatTerm');
  if (enabled) {
    for (const mode of ['n', 'i', 't'] as const) {
      applyKeyMapping({
        mode,
        inputStroke: "<A-i>",
        outputStroke: "<cmd>FloatermToggle __builtin_floating<CR>",
        options: {
          desc: "toggle floating terminal"
        }
      });
    }
    applyKeyMapping({
      mode: 't',
      inputStroke: "<A-h>",
      outputStroke: "<cmd>FloatermPrev<CR>",
      options: {
        desc: "terminal previous terminal"
      }
    });

    if (!isRunningInsideTmux()) {
      applyKeyMapping({
        mode: 'n',
        inputStroke: '<c-b>s',
        action: () => {
          selectCustomTmuxScope();
        },
        options: {
          desc: "Select custom tmux scope"
        }
      })
    }

    applyKeyMapping({
      mode: 't',
      inputStroke: "<A-l>",
      outputStroke: "<cmd>FloatermNext<CR>",
      options: {
        desc: "terminal next terminal"
      }
    });

    applyKeyMapping({
      mode: 't',
      inputStroke: "<A-n>",
      outputStroke: "<cmd>FloatermNew<CR>",
      options: {
        desc: "terminal new terminal"
      }
    });

    applyKeyMapping({
      mode: 't',
      inputStroke: "<A-k>",
      outputStroke: "<cmd>FloatermKill<CR>",
      options: {
        desc: "terminal new terminal"
      }
    });
  }
}



applyKeyMapping({
  mode: 't',
  inputStroke: "<C-x>",
  outputStroke: "<C-\\><C-N>",
  options: {
    desc: "terminal escape terminal mode"
  }
});

// Telescope

{
  const [enabled] = getPackage('telescope');
  if (enabled) {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>ff',
      outputStroke: '<cmd>Telescope find_files <CR>',
      options: {
        desc: 'Find files'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: "<leader>fw",
      outputStroke: '<cmd>Telescope live_grep <CR>',
      options: {
        desc: 'Live grep'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: "<leader>fb",
      outputStroke: '<cmd>Telescope buffers <CR>',
      options: {
        desc: 'Find buffers'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: "<leader>cm",
      outputStroke: '<cmd>Telescope git_commits <CR>',
      options: {
        desc: 'Git commits'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: "<leader>gt",
      outputStroke: '<cmd>Telescope git_status <CR>',
      options: {
        desc: 'Git status'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>fz',
      outputStroke: '<cmd>Telescope current_buffer_fuzzy_find <CR>',
      options: {
        desc: 'Find in current buffer'
      }
    });
  }
}

// CMP
// is managed in it's plugin config

{
  const [enabled] = getPackage('lspConfig');
  if (enabled) {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>fm',
      action: function(this: void) {
        vim.lsp.buf.format({ async: true });
      },
      options: {
        desc: 'LSP Formatting'
      }
    });

    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>,',
      action: function(this: void) {
        vim.lsp.buf.signature_help();
        vim.lsp.buf.hover();
      },
      options: {
        desc: 'Show LSP signature & type info'
      }
    });
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader><c-,>',
      action: function(this: void) {
        vim.diagnostic.open_float({ border: 'rounded' });
      },
      options: {
        desc: 'Show LSP signature & type info'
      }
    });
  }
}

// Comments
{
  const [enabled] = getPackage('comments');
  if (enabled) {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>/',
      action: function(this: void) {
        vim.cmd("norm gcc");
      },
      options: {
        desc: 'toggle comment'
      }
    });
    applyKeyMapping({
      mode: 'v',
      inputStroke: '<leader>/',
      action: function(this: void) {
        vim.cmd("norm gcc");
      },
      options: {
        desc: 'toggle comment'
      }
    });
  } else {
    oneOffFunction('warn-comments-disabled', () => {
      vim.notify(`Comments plugin is disabled`, vim.log.levels.WARN);
    });
  }
}

if (config.packages["trouble"]?.enabled) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>tdd',
    outputStroke: ':Trouble diagnostics toggle<CR>',
    options: {
      silent: true
    }
  });
}

if (true) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: "<F2>",
    action: function(this: void) {
      vim.lsp.buf.rename();
    },
    options: {
      desc: 'rename'
    }
  });
}

if (config.packages["glance"]?.enabled) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>glr',
    outputStroke: ':Glance references<CR>',
    options: {
      desc: 'Open references'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>gld',
    outputStroke: ':Glance definitions<CR>',
    options: {
      desc: 'Open definitions'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>gltd',
    outputStroke: ':Glance type_definitions<CR>',
    options: {
      desc: 'Open type definitions'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>gli',
    outputStroke: ':Glance implementations<CR>',
    options: {
      desc: 'Open implementations'
    }
  });
}

if (config.packages["nvimDapUI"]) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dbn',
    action: () => {
      getDap().toggle_breakpoint();
    },
    options: {
      desc: 'Toggle breakpoint'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dbm',
    action: () => {
      manageBreakpoint();
    },
    options: {
      desc: 'Toggle breakpoint'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dbc',
    action: () => {
      getDap().toggle_breakpoint(vim.fn.input("Condition: "));
    },
    options: {
      desc: 'Toggle breakpoint'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dr',
    action: () => {
      if (getGlobalConfiguration().packages.nvimTree?.enabled) {
        // For some reason, sequential calls to open the debug interface makes `nvim-tree` get larger each time.
        // Closing it when starting DAP fixes this.
        vim.cmd("NvimTreeClose");
      }
      if (vim.bo.filetype === 'cs' && getGlobalConfiguration().packages.cSharp?.enabled) {
        // C# is enabled, we're in a C# file.
        // Apply some unique tweaks to make the experience seamless
        if (getDap().status() === 'Running') {
          // If we're running, the debugger is already working, so we can just do the usual
          vim.cmd("DapContinue");
        }
        else {
          // This is the tweak
          getCSharp().debug_project();
        }
      }
      else {
        // Nothing special, let DAP do it's thing
        vim.cmd("DapContinue");
      }
    },
    options: {
      desc: 'Start or continue the debugger'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dt',
    action: function(this: void) {
      getDapUI().toggle();
    },
    options: {
      desc: 'Toggle debugger UI'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dsi',
    outputStroke: ':DapStepInto<CR>',
    options: {
      desc: 'Step into'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dso',
    outputStroke: ':DapStepOver<CR>',
    options: {
      desc: 'Step over'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dsO',
    outputStroke: ':DapStepOut<CR>',
    options: {
      desc: 'Step out'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dsc',
    action: () => {
      getDap().run_to_cursor();
    },
    options: {
      desc: 'Step to cursor'
    }
  })

  applyKeyMapping({
    mode: 'v',
    inputStroke: '<leader>e',
    action: () => {
      getDapUI().eval();
    },
    options: {
      desc: "Evaluate selected statement"
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>e',
    action: () => {
      getDapUI().eval();
    },
    options: {
      desc: "Evaluate selected statement"
    }
  });
}

if (config.packages["copilot"]?.enabled) {
  // TODO: Replace with custom remapper
  vim.keymap.set('i', '<C-J>', 'copilot#Accept("\<CR>")', {
    expr: true,
    replace_keycodes: false,
  });
}

if (config.packages["actionsPreview"]?.enabled) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '.',
    action: function(this: void) {
      getActionsPreview().code_actions();
    },
    options: {
      desc: "Show code actions"
    }
  })
}

if (config.packages["lazyGit"]?.enabled) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>lg',
    outputStroke: '<cmd>LazyGit<CR>',
    options: {
      desc: "Show code actions"
    }
  });
}

// Disable macro recording
vim.cmd("map q <Nop>");
