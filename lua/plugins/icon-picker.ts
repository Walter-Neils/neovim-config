import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getIconPicker() {
  type IconPickerModule = {
    setup: (this: void, config: unknown) => void
  };

  return useExternalModule<IconPickerModule>("icon-picker");
}

const plugin: LazyPlugin = {
  1: 'ziontee113/icon-picker.nvim',
  event: "VeryLazy",
  config: () => {
    getIconPicker().setup({
      disable_legacy_commands: true
    });
  }
};
export { plugin as default };
