export function parseArgs<ArgType extends { [key: string]: string | boolean | undefined }>(this: void, args: string[]): ArgType {
  let result: { [key: string]: any } = {};
  let primedKey: string | undefined = undefined;

  for (let i = 0; i < args.length; i++) {
    const segment = args[i];

    if (segment.startsWith('--')) {
      if (primedKey !== undefined) {
        result[primedKey] = true;
      }
      primedKey = segment.slice(2); // Manually remove the leading "--"
    } else {
      if (primedKey === undefined) {
        throw new Error(`Expected a key, got a value`);
      } else if (segment.startsWith("\"") || segment.startsWith("'")) {
        const delim = segment[0];
        let valueResult = segment.slice(1);
        let end = i;

        while (end < args.length && !args[end].endsWith(delim)) {
          end++;
          valueResult += ' ' + args[end];
        }

        if (end >= args.length || !args[end].endsWith(delim)) {
          throw new Error(`Unterminated string: ${args[end]}`);
        }

        valueResult = valueResult.slice(0, valueResult.length - 1); // Remove the closing delimiter
        result[primedKey] = valueResult;
        i = end; // Advance the loop to the end of the string
      } else {
        result[primedKey] = segment;
      }
      primedKey = undefined;
    }
  }

  if (primedKey !== undefined) {
    result[primedKey] = true;
  }

  return result as ArgType;
}

