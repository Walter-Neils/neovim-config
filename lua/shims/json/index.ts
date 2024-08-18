export function insertJSONShims(this: void) {
  if(globalThis.JSON === undefined) {
    globalThis.JSON = {} as any;
  }
  // TODO: Replacer and reviver support
  globalThis.JSON.stringify = (value, replacer) => {
    if (replacer !== undefined) {
      vim.notify("JSON.stringify replacer param does not have shim implementation", vim.log.levels.ERROR);
    }
    return vim.json.encode(value);
  };
  globalThis.JSON.parse = (text, reviver) => {
    if (reviver !== undefined) {
      vim.notify("JSON.parse reviver param does not have shim implementation", vim.log.levels.ERROR);
    }
    vim.json.decode(text);
  };
}
