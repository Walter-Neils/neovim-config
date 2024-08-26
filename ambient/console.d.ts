type ConsoleType = {
  log: (this: void, message: string) => void,
  warn: (this: void, message: string) => void,
  error: (this: void, message: string) => void
};

declare var console: ConsoleType;
