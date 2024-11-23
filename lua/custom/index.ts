import { initCustomOpen } from "./custom-open";
import { initCustomEnvLoader } from "./env-load";
import { initCustomEnvManager } from "./env-manager";
import { initCustomGetPIDCommand } from "./getpid";
import { initCustomGit } from "./git";
import { initCustomJumplist } from "./jumplist";
import { setupCustomProfilerCommands } from "./profile";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
  initCustomEnvLoader();
  initCustomJumplist();
  initCustomGit();
  setupCustomProfilerCommands();
  initCustomGetPIDCommand();
  initCustomEnvManager();
}
