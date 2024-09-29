import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

function getCrates() {
  type CratesModule = {
    setup: (this: void, opts?: unknown) => void
  };

  return useExternalModule<CratesModule>("crates");
}

const plugin: LazyPlugin = {
  1: 'saecki/crates.nvim',
  tag: (getGlobalConfiguration().packages.crates?.config as { bleedingEdge?: boolean } | undefined)?.bleedingEdge ? undefined : 'stable',
  event: ["BufRead Cargo.toml"],
  config: () => {
    getCrates().setup();
  }
};
export { plugin as default };
