import { initCustomOpen } from "./custom-open";
import { initCustomEnvLoader } from "./env-load";
import { initCustomJumplist } from "./jumplist";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
  initCustomEnvLoader();
  initCustomJumplist();
}
