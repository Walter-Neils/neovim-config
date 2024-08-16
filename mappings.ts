import { applyKeyMapping } from "./lua/helpers/keymap";
import { getActionsPreview } from "./lua/plugins/actions-preview";
import { getDapUI } from "./lua/plugins/nvim-dap-ui";
import { CONFIGURATION } from "./lua/toggles";

vim.g.mapleader = " "; // Use space key as leader

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

// Buffer switching
if (!CONFIGURATION.useBarBar) {
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
else {
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

// Close buffer 
if (CONFIGURATION.useBarBar) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>x',
    outputStroke: '<cmd>BufferClose<CR>',
    options: {
      desc: 'Close current buffer'
    }
  });
}
else {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>x',
    outputStroke: '<cmd>:bd<CR>:bnext<CR>',
    options: {
      desc: 'Close current buffer'
    }
  });
}

// nvim-tree
applyKeyMapping({
  mode: 'n',
  inputStroke: "<C-n>",
  outputStroke: "<cmd>NvimTreeToggle<CR>",
  options: {
    desc: "toggle file tree"
  }
});

// floatterm
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

applyKeyMapping({
  mode: 't',
  inputStroke: "<C-x>",
  outputStroke: "<C-\\><C-N>",
  options: {
    desc: "terminal escape terminal mode"
  }
});

// Telescope
if (CONFIGURATION.useTelescope) {
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

// CMP
// is managed in it's plugin config


// LSP Functionality
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
  inputStroke: ',',
  action: function(this: void) {
    vim.lsp.buf.signature_help();
    vim.lsp.buf.hover();
  },
  options: {
    desc: 'Show LSP signature & type info'
  }
})

// Comments
if (CONFIGURATION.useComments) {
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
}

if (CONFIGURATION.useTrouble) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>tdd',
    outputStroke: ':Trouble diagnostics toggle<CR>',
    options: {
      silent: true
    }
  });
}

if (CONFIGURATION.lspconfig.rename.enabled) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: CONFIGURATION.lspconfig.rename.bind,
    action: function(this: void) {
      vim.lsp.buf.rename();
    },
    options: {
      desc: 'rename'
    }
  });
}

if (CONFIGURATION.useGlance) {
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

if (CONFIGURATION.useNvimDapUI) {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>db',
    outputStroke: ':DapToggleBreakpoint<CR>',
    options: {
      desc: 'Toggle breakpoint'
    }
  });
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<leader>dr',
    outputStroke: ':DapContinue<CR>',
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
}

if (CONFIGURATION.useCopilot) {
  // TODO: Replace with custom remapper
  vim.keymap.set('i', '<C-J>', 'copilot#Accept("\<CR>")', {
    expr: true,
    replace_keycodes: false,
  });
}

if (CONFIGURATION.useActionsPreview) {
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
