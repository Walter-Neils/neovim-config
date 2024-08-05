import { applyKeyMapping } from "./lua/helpers/keymap";
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
}
else {
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
applyKeyMapping({
  mode: 'n',
  inputStroke: '<leader>x',
  outputStroke: '<cmd>:bd<CR>:bnext<CR>',
  options: {
    desc: 'Close current buffer'
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
  },
  options: {
    desc: 'Toggle inlay hints'
  }
})

// BarBar
if (CONFIGURATION.useBarBar) {
  // None yet
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<Tab>',
    outputStroke: "<cmd>:bnext<CR>",
    options: {
      desc: 'Switch next buffer'
    }
  })
}
