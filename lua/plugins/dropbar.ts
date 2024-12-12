import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'Bekaboo/dropbar.nvim',
  dependencies: (() => {
    const result = [] as unknown as Array<string> & { build: string };
    result.build = 'make';
    result.push('nvim-telescope/telescope-fzf-native.nvim');
    return result;
  })()
};
export { plugin as default };
