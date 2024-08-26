import { fs } from "../../shims/fs";

const persistValueInstances: {
  [key: string]: ReturnType<typeof usePersistentValue<unknown>>
} = {};

const dataPath = vim.fn.stdpath("data") + "/winvim";

vim.fn.system(["mkdir", "-p", dataPath]);

export function getWinvimLocalDataDirectory() {
  return dataPath;
}

export function usePersistentValue<TValue>(key: string, defaultValue: TValue) {
  {
    const target = persistValueInstances[key] as unknown;
    if (target !== undefined) {
      return target as typeof result;
    }
  }

  const filePath = `${dataPath}/${key}`;

  let currentValue: TValue = defaultValue;

  if (fs.existsSync(filePath)) {
    currentValue = vim.json.decode(fs.readFileSync(filePath)) as TValue;
  }

  const get = () => {
    return currentValue;
  };

  const set = (newValue: TValue) => {
    currentValue = newValue;
    fs.writeFileSync(filePath, vim.json.encode(newValue));
    return currentValue;
  };

  const result = [get, set] as const;

  persistValueInstances[key] = result as ReturnType<typeof usePersistentValue<unknown>>;

  return result;
}
