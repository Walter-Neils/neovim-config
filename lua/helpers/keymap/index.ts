type KeymapSetOptions = {
  desc?: string
};
type KeyMapping = {
  mode: 'i' | 'a' | 'n' | 't'
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

export function applyKeyMapping(this: void, map: KeyMapping) {
  if ('action' in map) {
    vim.keymap.set(map.mode, map.inputStroke, map.action, map.options);
  }
  else {
    vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options);
  }
}
