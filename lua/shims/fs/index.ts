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
  writeFileSync
};
