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
    vim.notify('AppImage environment detected. Integrating...');
    injectSTDPathOverride();
  }
}
