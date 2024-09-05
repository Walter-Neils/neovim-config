import { fs } from "../../shims/fs";

const dataPath = vim.fn.stdpath("data") + "/winvim/one-off";
vim.fn.system(["mkdir", "-p", dataPath]);

export function oneOffFunction(
  key: string,
  only_once: () => void,
  not_first_time?: () => void,
) {
  const path = `${dataPath}/${key}`;
  if (fs.existsSync(path)) {
    not_first_time?.();
  } else {
    fs.writeFileSync(path, "");
    only_once();
  }
}
