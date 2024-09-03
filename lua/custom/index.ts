import { initCustomOpen } from "./custom-open";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
}
