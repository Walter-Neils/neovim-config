function getAppImageConfigData() {
  return {
    appDir: os.getenv('APPDIR'),
  }
}

function injectSTDPathOverride() {
  vim.fn.stdpath = target => {
    return `/tmp/winvim/${target}`;
  };
}

export function enablePortableAppImageLogic(this: void) {
  const appImageEnvironment = getAppImageConfigData();
  if (appImageEnvironment.appDir !== null) {
    // We need to prevent `nvim` from writing to it's normal directories (because there might be an existing install, and the AppImage is supposed to be transient)
    injectSTDPathOverride();
  }
}
