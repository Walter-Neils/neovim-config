export function parseEnvFileContent(this: void, content: string): { [key: string]: string | undefined } {
  const result: { [key: string]: string | undefined } = {};
  const lines = content.split('\n').map(x => x.trim()).filter(x => x.length > 0).filter(x => !x.startsWith("#"));
  for (const line of lines) {
    const [key, ...valuePossibleSplit] = line.split('=');
    const valueWithPossibleComment = valuePossibleSplit.join("=");
    const [value, comment] = valueWithPossibleComment.split("#").map(x => x.trim());
    const STRING_DELIMS = ['"', "'"] as const;
    const delimiter = STRING_DELIMS.find(x => value.startsWith(x));
    let finalValue = value;
    if (delimiter !== undefined) {
      const start = finalValue.indexOf(delimiter) + 1;
      // It's delimited
      let end = finalValue.lastIndexOf(delimiter);
      if (end === -1) {
        throw new Error(`No closing string delimiter`);
      }
      end--;
      finalValue = finalValue.slice(start, end);
      finalValue = finalValue.replaceAll(`\\${delimiter}`, `${delimiter}`);
      finalValue = finalValue.replaceAll(`\\n`, '\n');
    }
    result[key] = finalValue;
  }
  return result;
}
