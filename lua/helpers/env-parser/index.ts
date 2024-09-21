export function parseEnvFileContent(this: void, content: string): { [key: string]: string | undefined } {
  const result: { [key: string]: string | undefined } = {};
  const lines = content.split('\n').map(x => x.trim()).filter(x => x.length > 0).filter(x => !x.startsWith("#"));
  for (const line of lines) {
    const [key, ...valuePossibleSplit] = line.split('=');
    const valueWithPossibleComment = valuePossibleSplit.join("=");
    const [value, comment] = valueWithPossibleComment.split("#").map(x => x.trim());
    result[key] = value;
  }
  return result;
}
