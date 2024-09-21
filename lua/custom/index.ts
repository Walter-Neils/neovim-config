import { initCustomOpen } from "./custom-open";
import { initCustomEnvLoader } from "./env-load";
import { initCustomTmux } from "./tmux";

export function setupCustomLogic() {
  initCustomTmux();
  initCustomOpen();
  initCustomEnvLoader();
}
