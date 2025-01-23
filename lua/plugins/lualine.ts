import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";
import { globalThemeType, onThemeChange } from "../theme";
import { getNavic } from "./navic";

const plugin: LazyPlugin = {
  1: 'nvim-lualine/lualine.nvim',
  dependencies: ['nvim-tree/nvim-web-devicons'],
  config: function(this: void) {
    const module = useExternalModule<{
      setup: (this: void, arg: unknown) => void
    }>("lualine");
    type LuaLineSectionConfig = ([key: string] | [func: (this: void) => string]) & {
      fmt: (this: void, input: string) => string
    };
    type LuaLineConfig = {
      options: unknown,
    } & {
      sections: {
        [key in `lualine_${'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'x' | 'y' | 'z'}`]?: LuaLineSectionConfig[]
      }
    };
    const createStandardComponent = (type: string) => {
      const result: LuaLineSectionConfig = [] as unknown as LuaLineSectionConfig;
      result[0] = type;
      return type as any;
    };
    const createCustomComponent = (func: (this: void) => string, fmt?: (this: void, unformatted: string) => string) => {
      const result: LuaLineSectionConfig = [] as unknown as LuaLineSectionConfig;
      result.fmt = fmt ?? (input => input);

      result[0] = func;
      return result;
    };


    const genConfig = () => {
      const config: LuaLineConfig = {
        options: {
          theme: globalThemeType() === 'dark' ? 'material' : 'ayu_light',
          refresh: {
            //statusline: 1500
          }
        },
        sections: {
          lualine_b: [createStandardComponent('branch'), createStandardComponent('diff'), createStandardComponent('diagnostics')],
          lualine_c: [

          ],
          lualine_x: [
          ]
        }
      };
      {
        const navic = getNavic();
        if (navic !== undefined) {
          config.sections.lualine_c!.push(createCustomComponent(() => {
            if (navic.is_available()) {
              return navic.get_location();
            }
            else {
              return '';
            }
          }));
        }
      }
      if (getGlobalConfiguration().packages.copilot?.enabled) {
        if (getGlobalConfiguration().packages["copilotLuaLine"]?.enabled) {
          config.sections.lualine_x!.push(createStandardComponent('copilot'));
        }
      }
      return config;
    }

    onThemeChange(type => {
      module.setup(genConfig());
    });
    module.setup(genConfig());
  }
};
export { plugin as default };
