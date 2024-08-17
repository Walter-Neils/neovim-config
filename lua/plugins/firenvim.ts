import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'glacambre/firenvim',
  build: ':call firenvim#install(0)'
};
export { plugin as default };
