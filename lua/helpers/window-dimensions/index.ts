export function actualBufferDimensions(target: NeovimBuffer) {
  const window = vim.fn.bufwinid(target);
  const wininfos = vim.fn.getwininfo(window);

  if (wininfos === null) {
    return undefined;
  }
  const wininfo = wininfos[0];


  return {
    actualWidth: wininfo.width - wininfo.textoff
  };
}
