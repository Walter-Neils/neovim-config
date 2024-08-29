import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'iamcco/markdown-preview.nvim',
  cmd: ["MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"],
  build: "cd app && npm install",
  init: function(this: void) {
    (vim.g as unknown as { mkdp_filetypes: string[] }).mkdp_filetypes = ["markdown"];
  },
  ft: ['markdown']
};
export { plugin as default };
