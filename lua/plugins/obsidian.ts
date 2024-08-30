import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

type ObsidianConfig = {
  workspaces: { name: string, path: string }[]
};

const plugin: LazyPlugin = {
  1: 'epwalsh/obsidian.nvim',
  version: '*',
  lazy: true,
  ft: ['markdown'],
  dependencies: ['nvim-lua/plenary.nvim'],
  opts: {
    workspaces: (getGlobalConfiguration().packages["obsidian"]?.config as ObsidianConfig)?.workspaces ?? []
  }
};
export { plugin as default };
