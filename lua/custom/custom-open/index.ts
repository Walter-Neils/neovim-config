import { useNUI } from "../../plugins/nui";

const VIM_OPEN = vim.ui.open;

type VIMOpenHandler = {
  pattern: string,
  name: string,
  command: string
};

function open(this: void, target: string): {
  wait: (this: unknown) => void
} {
  const targets: VIMOpenHandler[] = [{
    pattern: '.*',
    name: 'Firefox',
    command: 'firefox %OPEN_TARGET%'
  }].filter(pmatch => {
    const result = vim.regex(pmatch.pattern).match_str(target);
    console.log(`${result}`);
    return result;
  });

  if (targets.length < 1) {
    return VIM_OPEN(target);
  }

  const NUI = useNUI();
  const menu = NUI.Menu({
    position: '50%',
    size: {
      width: 33,
      height: 5
    },
    border: {
      style: 'single',
      text: {
        top: 'Select Handler Program'
      }
    }
  }, {
    lines: targets.map((target) => NUI.Menu.item(target.name, { target })),
    on_submit: (_item) => {
      const item: typeof _item & { target: VIMOpenHandler } = _item as unknown as any;
      const command = item.target.command.replaceAll("%OPEN_TARGET%", target);
      os.execute(command);
    }
  });
  menu.mount();
  return undefined!;
}

export function initCustomOpen(this: void) {
  vim.ui.open = open;
}
