import { initCustomOpen } from "./custom-open";
import { initCustomEnvLoader } from "./env-load";
import { initCustomGit } from "./git";
import { initCustomJumplist } from "./jumplist";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
  initCustomEnvLoader();
  initCustomJumplist();
  initCustomGit();
}
