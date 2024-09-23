import { getNeovideExtendedVimContext, isNeovideSession } from "../../integrations/neovide";

export function setGUIFont(this: void, fontName: string, fontSize: number) {
  if (isNeovideSession()) {
    const opts = getNeovideExtendedVimContext();
    opts.o.guifont = `${fontName}:h${fontSize}`;
  }
  else {
    vim.notify(`Cannot update GUI font: feature is only available in a Neovide context`, vim.log.levels.ERROR);
  }
} 
