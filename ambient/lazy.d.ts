export type LazyPlugin = {
  1?: string,
  lazy?: boolean,
  branch?: string,
  import?: string,
  cmd?: string[],
  config?: ((this: void, arg1: unknown, opts: unknown) => void) | boolean,
  opts?: ((this: void) => any) | any,
  dependencies?: string[],
  event?: 'InsertEnter' | string,
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
