type KeymapSetOptions = {
  desc?: string,
  noremap?: boolean,
  expr?: boolean,
  silent?: boolean,
  buffer?: number
};
type VimModes = 'i' | 'a' | 'n' | 't' | 'v';
type KeyMapping = {
  mode: VimModes | VimModes[],
  options?: KeymapSetOptions
} & (
    {
      inputStroke: string,
      outputStroke: string,
    } | {
      inputStroke: string,
      action: (this: void) => void,
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
  map.options = { silent: true, ...map.options };
  if ('action' in map) {
    vim.keymap.set(map.mode, map.inputStroke, map.action, map.options);
  }
  else {
    vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options);
  }
}
