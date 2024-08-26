export function centerText(input: string, width: number, spacer: string = ' '): string {
  while (input.length + spacer.length < width) {
    input = `${spacer}${input}${spacer}`;
  }
  return input;
}
