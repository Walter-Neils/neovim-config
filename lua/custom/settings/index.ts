import { getGlobalConfiguration } from "../../helpers/configuration";
import { useNUI } from "../../plugins/nui";


function configurePlugin(this: void, pluginKey: string) {
  const nui = useNUI();
  const configuration = getGlobalConfiguration().packages[pluginKey];
  if (configuration === undefined) {
    throw new Error(`Failed to locate plugin ${pluginKey}`);
  }
  console.log('good');
}

function showSettingsMenu(this: void) {
  const nui = useNUI();
  const modules = Object.keys(getGlobalConfiguration().packages).map(x => ({ ...getGlobalConfiguration().packages[x]!, key: x })).map(x => nui.Menu.item(x.key, x));
  const menu = nui.Menu({
    position: '50%',
    size: {
      width: 33,
      height: 10
    },
    border: {
      style: 'single',
      text: {
        top: 'Configure Plugin'
      }
    },
  }, {
    on_submit: item => {
      if (item !== undefined) {
        configurePlugin((item as unknown as { key: string }).key);
      }
    },
    lines: modules,
  });
  menu.mount();
}

export function initCustomSettingsSystem(this: void) {
  vim.api.nvim_create_user_command('ShowSettings', () => {
    showSettingsMenu();
  }, {

  });
}
