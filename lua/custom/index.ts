import { initCustomOpen } from "./custom-open";
import { initCustomJumplist } from "./jumplist";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
  initCustomJumplist();
}
