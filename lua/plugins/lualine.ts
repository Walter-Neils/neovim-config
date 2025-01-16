import { LazyPlugin } from "../../ambient/lazy";
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
        [key in `lualine_${'a' | 'b' | 'c' | 'd'}`]?: LuaLineSectionConfig[]
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
          theme: globalThemeType() === 'dark' ? 'material' : 'ayu_light'
        },
        sections: {
          lualine_b: [createStandardComponent('branch'), createStandardComponent('diff'), createStandardComponent('diagnostics')],
          lualine_c: [
            createCustomComponent(() => {
              const navic = getNavic();
              if (navic === undefined) {
                return ` Navic`;
              }
              else {
                if (navic.is_available()) {
                  return navic.get_location();
                }
                else {
                  return `󱈸 Scope Unavailable`;
                }
              }
            }),
          ]
        }
      };
      return config;
    }

    onThemeChange(type => {
      module.setup(genConfig());
    });
    module.setup(genConfig());
  }
};
export { plugin as default };
