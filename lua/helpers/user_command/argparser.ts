export function parseArgs<ArgType extends { [key: string]: string }>(this: void, args: string[]) {
  let result: any = {};
  let primedKey: string | undefined = undefined;
  for (let i = 0; i < args.length; i++) {
    const segment = args[i];
    if (segment.startsWith('--')) {
      if (primedKey !== undefined) {
        result[primedKey] = true;
      }
      primedKey = segment.replaceAll("--", "");
    }
    else {
      if (primedKey === undefined) {
        throw new Error(`Expected a key, got a value`);
      }
      else if (segment.startsWith("\"")) {
        // NOT WORKING!!
        const delim = segment[0];
        let end: number = i;
        for (let v = i; !args[v].endsWith(delim) && v < args.length; v++) {
          end = v;
        }
        if (!args[end].endsWith(delim)) {
          throw new Error(`Unterminated string: ${args[end]}`);
        }
        let valueResult = '';
        for (let v = i; v <= end; v++) {
          valueResult += args[v];
        }
        result[primedKey] = valueResult;
      }
      else {
        result[primedKey] = segment;
      }
      primedKey = undefined;
    }
  }
  return result as ArgType;
}
