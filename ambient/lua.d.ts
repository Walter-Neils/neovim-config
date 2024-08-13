type LuaOSLib = {
  os: {
    getenv: (this: void, key: string) => string | null
  }
};

declare var os: LuaOSLib['os'];
