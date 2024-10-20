type KeymapSetOptions = {
  desc?: string,
  noremap?: boolean,
  expr?: boolean,
  silent?: boolean
};
type KeyMapping = {
  mode: 'i' | 'a' | 'n' | 't' | 'v'
} & (
    {
      inputStroke: string,
      outputStroke: string,
      options: KeymapSetOptions
    } | {
      inputStroke: string,
      action: (this: void) => void,
      options: KeymapSetOptions
    }
  );


export function keyMappingExists(this: void, mode: KeyMapping['mode'], bind: string) {
  const result: string = vim.api.nvim_call_function('mapcheck', [bind, mode]) as string;
  if (result !== null && result.length > 0) {
    return true;
  }
  else {
    return false;
  }
}

export function applyKeyMapping(this: void, map: KeyMapping) {
  if ('action' in map) {
    vim.keymap.set(map.mode, map.inputStroke, map.action, map.options);
  }
  else {
    vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options);
  }
}
