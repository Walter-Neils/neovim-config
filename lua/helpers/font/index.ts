import { getNeovideExtendedVimContext, isNeovideSession } from "../../integrations/neovide";

export function setGUIFont(this: void, fontName: string, fontSize: number) {
  if (isNeovideSession()) {
    const opts = getNeovideExtendedVimContext();
    opts.o.guifont = `${fontName}:h${fontSize}`;
  }
} 
