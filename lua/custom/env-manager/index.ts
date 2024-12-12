import { NUITableColumnDef, useNUI } from "../../plugins/nui";

export function getEnvironment(): {
  [key: string]: string | undefined
} {
  return vim.api.nvim_call_function("environ", []) as any;
}

function createEnvironmentTableView() {
  const MAX_LEN = 75;
  const NUI = useNUI();
  const split = NUI.Split({
    position: 'bottom',
    size: 25
  });
  const columns: NUITableColumnDef[] = [
    {
      align: 'center',
      header: 'Key',
      accessor_key: 'key',
      cell: cell => {
        return NUI.Line([NUI.Text(tostring(cell.get_value()), 'DiagnosticInfo')]);
      }
    },
    {
      align: 'center',
      header: 'Value',
      accessor_key: 'value',
      accessor_fn: row => {
        const val: string = (row as { value: string }).value;
        if (val.length > MAX_LEN) {
          return val.substring(0, MAX_LEN - 3) + "...";
        }
        return val;
      },
      cell: cell => {
        return NUI.Line([NUI.Text(tostring(cell.get_value()), 'DiagnosticHint')]);
      }
    },
  ];
  const data: { key: string, value: string }[] = (() => {
    let result: { key: string, value: string }[] = [];
    const keys = (() => {
      const result: string[] = [];
      const env = getEnvironment();
      for (const key in env) {
        result.push(key);
      }
      result.sort();
      return result;
    })();
    for (const key of keys) {
      const value = vim.env[key];
      if (value === undefined) {
        continue;
      }
      result.push({
        key,
        value
      });
    }
    return result;
  })();
  const table = NUI.Table({
    bufnr: split.bufnr,
    columns: columns,
    data
  });
  table.render();
  split.mount();

  const destroy = () => {
    split.unmount();
  };

  split.map('n', 'q', () => {
    destroy();
  });

  const getCurrentContext = () => {
    const cell = table.get_cell();
    if (cell != undefined) {
      if (cell.column.accessor_key) {
        const targetKey = (cell.row.original as {
          [key: string]: string
        })['key']!;
        const dataEntryIndex = data.findIndex(x => x.key === targetKey);
        let dataEntry: { key: string, value: string };
        if (dataEntryIndex !== -1) {
          dataEntry = data[dataEntryIndex];
        }
        else {
          throw new Error(`Context attempted to get an environment record which does not exist`);
        }
        return {
          targetKey,
          cell,
          dataEntry
        };
      }
      else {
        return undefined;
      }
    }
    else {
      return undefined;
    }
  };

  split.map('n', 'dd', () => {
    const cell = table.get_cell();
    if (cell != undefined) {
      if (cell.column.accessor_key) {
        const targetKey = (cell.row.original as {
          [key: string]: string
        })[cell.column.accessor_key!];
        vim.env[targetKey] = undefined;
        const index = data.findIndex(x => x.key === targetKey);
        data.splice(index, 1);
        table.render();
        vim.notify(`Deleted environment variable '${targetKey}'`, vim.log.levels.INFO);
      }
    }
  });

  split.map('n', 'yy', () => {
    const context = getCurrentContext();
    if (context != undefined) {
      const cellValue = tostring(context.cell.get_value());
      vim.fn.setreg("x", cellValue);
    }
  });

  split.map('n', 'o', () => {
    const key = vim.fn.input("Key: ");
    if (key.length === 0) {
      return;
    }
    const value = vim.fn.input("Value: ");
    if (value.length === 0) {
      return;
    }
    if (data.findIndex(x => x.key === key) !== -1) {
      vim.notify(`Environment variable '${key}' already exists`, vim.log.levels.ERROR);
      return;
    }
    vim.env[key] = value;
    data.push({
      key, value
    });
    table.render();
    vim.notify(`Created environment variable '${key}'`, vim.log.levels.INFO);
  });

  split.map('n', 'r', () => {
    const context = getCurrentContext();
    if (context != undefined) {
      const oldKey = context.targetKey;
      // TODO: Switch all vim.fn.input calls over to NUI input boxes
      const newKey = vim.fn.input(`Rename environment variable '${oldKey}' to: `, oldKey);
      if (oldKey === newKey) {
        return;
      }
      if (data.findIndex(x => x.key === newKey) !== -1) {
        vim.notify(`Destination environment variable already exists`, vim.log.levels.ERROR);
        return;
      }
      context.dataEntry.key = newKey;
      vim.env[newKey] = vim.env[oldKey];
      vim.env[oldKey] = undefined;
      table.render();
      vim.notify(`Moved environment variable '${oldKey}' to '${newKey}'`, vim.log.levels.INFO);
    }
  });

  split.map('n', 'i', () => {
    const context = getCurrentContext();
    if (context != undefined) {
      const input = NUI.Input({
        position: '50%',
        size: {
          width: MAX_LEN
        },
        border: {
          style: 'single',
          text: {
            top: context.targetKey,
            top_align: 'center'
          }
        },
        win_options: {
          winhighlight: 'Normal:Normal'
        }
      }, {
        prompt: '',
        default_value: vim.env[context.targetKey]!,
        on_submit: value => {
          vim.env[context.targetKey] = value;
          context.dataEntry!.value = value;
          table.render();
        }
      });
      input.mount();
      input.map('n', 'q', () => {
        input.unmount();
      });
      // BUG: The following code is erroring out due to the floating buffer not being found.
      // Not sure how to fix, might need to upgrade NUI versions or something

      // input.on(NUI.event.event.BufLeave, () => {
      //   input.unmount();
      // });
    }
  });
}

export function initCustomEnvManager() {
  vim.api.nvim_create_user_command('EnvEdit', () => {
    createEnvironmentTableView();
  }, {
    nargs: 0
  });
}
