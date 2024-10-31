import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'rebelot/kanagawa.nvim',
  lazy: false,
  priority: 1000,
  opts: {
    theme: "wave",
    background: {
      dark: 'dragon',
      light: 'lotus'
    }
  }
};
export { plugin as default };
