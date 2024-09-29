type LazyKey = {
  1: string,
  2: string,
  desc?: string
};
export type LazyPlugin = {
  1?: string,
  lazy?: boolean,
  build?: string
  branch?: string,
  tag?: string,
  import?: string,
  cmd?: string[],
  keys?: LazyKey[] | string[],
  config?: ((this: void, arg1: unknown, opts: unknown) => void) | boolean,
  opts?: ((this: void) => any) | any,
  dependencies?: string[],
  event?: 'InsertEnter' | string | string[],
  version?: string,
  // file type (?)
  ft?: string[],
  priority?: number,
  main?: string,
  init?: (this: void) => void
};
export type LazyModuleInterface = {
  setup: (this: void, plugins: LazyPlugin[]) => void
};
