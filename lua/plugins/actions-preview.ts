import { LazyPlugin } from "../../ambient/lazy";

type ActionsPreviewAPI = {
  code_actions: (this: void) => void
};

export function getActionsPreview() {
  let target = "actions-preview";
  const module = require<ActionsPreviewAPI>(target);
  return module;
}

const plugin: LazyPlugin = {
  1: 'aznhe21/actions-preview.nvim',
  event: "VeryLazy",
};
export { plugin as default };
