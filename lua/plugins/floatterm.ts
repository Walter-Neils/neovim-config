import { LazyPlugin } from "../../ambient/lazy";

type FloattermOptions = {
  g: {
    floaterm_shell: '&shell' | string,
    floaterm_title: '$1/$2' | string,
    floaterm_width: 0.6 | number,
    floaterm_height: 0.6 | number,
    floaterm_borderchars: '─│─│┌┐┘└' | string,
    floaterm_giteditor: true | boolean,
    floaterm_opener: 'edit' | 'split' | 'vsplit' | 'tabe' | 'drop' | string,
    // 0: always do NOT close floaterm window
    // 1: Close window if job exits normally
    // 2: Always close floaterm window
    floaterm_autoclose: 0 | 1 | 2,
    // 0: do NOT hide previous floaterm windows
    // 1: Hide windows of identical position
    // 2: Always hide them
    floaterm_autohide: 0 | 1 | 2,
    floaterm_autoinsert: true | boolean,
    floaterm_titleposition: 'left' | 'center' | 'right'
  } & ({
    floaterm_wintype: 'float',
    floaterm_position: 'top' | 'bottom' | 'left' | 'right' | 'topleft' | 'topright' | 'bottomleft' | 'bottomright' | 'center' | 'auto'
  } | {
    floaterm_wintype: 'split' | 'vsplit',
    floaterm_position: 'leftabove' | 'aboveleft' | 'rightbelow' | 'belowright' | 'topleft' | 'botright'
  })
}

export function extendNeovimAPIWithFloattermConfig() {
  return vim as (typeof vim) & FloattermOptions;
}

const plugin: LazyPlugin = {
  1: 'voldikss/vim-floaterm',
  cmd: ["FloatermNew", "FloatermToggle", "FloatermShow", "FloatermHide"],
};

const nvim = extendNeovimAPIWithFloattermConfig();
nvim.g.floaterm_title = "";
nvim.g.floaterm_wintype = 'float';
nvim.g.floaterm_position = 'center';
nvim.g.floaterm_width = 0.999;
nvim.g.floaterm_height = 0.999;

export { plugin as default };
