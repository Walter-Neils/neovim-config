import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'github/copilot.vim',
  event: 'VeryLazy',
  config: () => {
    const vim = getCopilotExtendedVimAPI();
    vim.g.copilot_no_tab_map = true;
  }
};
export { plugin as default };

export function getCopilotExtendedVimAPI(this: void) {
  return vim as VimAPI & {
    g: {
      copilot_proxy: string,
      copilot_proxy_strict_ssl: boolean,
      copilot_no_tab_map: boolean
    }
  };
}
