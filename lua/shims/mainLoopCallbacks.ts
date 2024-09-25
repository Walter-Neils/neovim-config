export function setTimeout(callback: (this: void) => void, ms: number) {
  let cancelFlag: boolean = false;

  const cancel = () => {
    cancelFlag = true;
  };

  const wrapper = () => {
    if (!cancelFlag) {
      callback();
    }
  };

  vim.defer_fn(wrapper, ms);

  return cancel;
}

export function setImmediate(callback: (this: void) => void) {
  return vim.schedule(callback);
}

export function setInterval(callback: (this: void) => void, interval: number) {
  let cancelFlag = false;
  const wrapper = () => {
    if (!cancelFlag) {
      callback();
      setTimeout(wrapper, interval);
    }
  };

  const cancel = () => {
    cancelFlag = true;
  };
  setTimeout(wrapper, interval);
  return cancel;
}

export function clearTimeout(this: void, handle: ReturnType<typeof setTimeout>) {
  handle();
}

export function clearInterval(this: void, handle: ReturnType<typeof setInterval>) {
  handle();
}
export function insertMainLoopCallbackShims() {
  const global = globalThis as any;
  global.setTimeout = setTimeout;
  global.clearTimeout = clearTimeout;
  global.setInterval = setInterval;
  global.clearInterval = clearInterval;
  global.setImmediate = setImmediate;
}
