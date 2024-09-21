function readFileSync(this: void, target: string) {
  const [file] = io.open(target, "r");
  if (file === undefined) {
    throw new Error(`Failed to open file for read`);
  }

  const content = file.read("*a");

  file.close();

  if (content === undefined) {
    throw new Error(`Failed to read file`);
  }

  return content;
}

function writeFileSync(this: void, path: string, content: string) {
  const [file] = io.open(path, "w");
  if (file === undefined) {
    throw new Error(`Failed to open file for writing`);
  }
  file.write(content);
  file.close();
}

function readdirSync(this: void, path: string) {
  const files: { path: string, type: 'file' | 'directory' }[] = [];
  const handle = vim.uv.fs_scandir(path);
  if (handle === undefined) {
    throw new Error(`Cannot open directory ${path}`);
  }
  while (true) {
    const [name, type] = vim.uv.fs_scandir_next(handle);
    if (name === undefined) break;
    files.push({ path: name, type });
  }
  return files;
}

function existsSync(this: void, target: string) {
  const [file] = io.open(target, "r");
  if (file !== undefined) {
    file.close();
    return true;
  }
  else {
    return false;
  }
}

export const fs = {
  readFileSync,
  existsSync,
  writeFileSync,
  readdirSync
};
