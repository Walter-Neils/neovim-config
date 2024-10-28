import { useExternalModule } from "../../helpers/module/useModule";
import { parseArgs } from "../../helpers/user_command/argparser";

export function setupCustomProfilerCommands() {
  vim.api.nvim_create_user_command('LuaJITProfiler', (_args) => {
    const args: {
      operation: 'start'
    } | {
      operation: 'stop'
    } = parseArgs(_args.fargs);

    const getJIT = () => {
      type JITType = {
        start: (this: void, options: unknown, output: unknown) => void,
        stop: (this: void) => void
      };
      return useExternalModule<JITType>("jit.p");
    };

    if (args.operation === 'start') {
      getJIT().start("32", "profile.txt");
    }
    else if (args.operation === 'stop') {
      getJIT().stop();
    }
  }, { nargs: '*' });
}
