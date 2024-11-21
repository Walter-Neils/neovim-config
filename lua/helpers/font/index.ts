import { getNeovideExtendedVimContext, isNeovideSession } from "../../integrations/neovide";
import { setTimeout } from "../../shims/mainLoopCallbacks";

export function setGUIFont(this: void, fontName: string, fontSize: number) {
  if (isNeovideSession()) {
    fontName = fontName.replaceAll(" ", "_");
    const opts = getNeovideExtendedVimContext();
    opts.o.guifont = `${fontName}:h${fontSize}`;
  }
  else {
    vim.notify(`Cannot update GUI font: feature is only available in a Neovide context`, vim.log.levels.ERROR);
  }
}

export async function getAvailableGUIFonts(this: void): Promise<string[]> {
  if (isNeovideSession()) {
    vim.cmd("set guifont=*");
    await new Promise<void>(resolve => setTimeout(() => resolve(), 500));
    const buffer = vim.api.nvim_get_current_buf();
    const lines = vim.api.nvim_buf_get_lines(buffer, 0, vim.api.nvim_buf_line_count(buffer), false);
    let targetIndex = lines.indexOf(`Available Fonts on this System`);
    if (targetIndex === -1) {
      throw new Error(`Possible format change`);
    }
    targetIndex += 2; // Skip this line and the next
    return lines.slice(targetIndex);
  }
  else {
    throw new Error(`Fetching the list of available GUI font options is only possible under Neovide`);
  }
}
