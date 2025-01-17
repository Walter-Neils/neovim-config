type NeovideAPIGExtensions = {
  g: ({
    neovide: true,
    neovide_version: string,
    neovide_channel_id: number,
    neovide_scale_factor: number,
    neovide_transparency: number,
    neovide_position_animation_length: number,
    neovide_scroll_animation_length: number,
    neovide_scroll_animation_far_lines: number,
    neovide_hide_mouse_when_typing: boolean,
    neovide_underline_stroke_scale: number,
    experimental_layer_grouping: boolean,
    neovide_refresh_rate: number,
    neovide_refresh_rate_idle: number,
    neovide_no_idle: boolean,
    neovide_theme: 'auto' | string,
    neovide_confirm_quit: boolean,
    neovide_detach_on_quit: 'always_quit' | 'always_detach' | 'prompt',
    neovide_cursor_animation_length: number,
    neovide_cursor_trail_size: number,
    neovide_cursor_antialiasing: boolean,
    neovide_cursor_animate_in_insert_mode: boolean,
    neovide_cursor_animate_command_line: boolean,
    neovide_cursor_unfocused_outline_width: boolean,
    neovide_cursor_smooth_blink: boolean,
    neovide_cursor_vfx_mode: '' | 'railgun' | 'torpedo' | 'pixiedust' | 'sonicboom' | 'ripple' | 'wireframe';
    neovide_cursor_vfx_opacity: number,
    neovide_cursor_vfx_particle_lifetime: number,
    neovide_cursor_vfx_particle_density: number,
    neovide_cursor_vfx_particle_speed: number,
    neovide_cursor_vfx_particle_phase: number,
    neovide_cursor_vfx_particle_curl: number,
    neovide_padding_top: number,
    neovide_padding_bottom: number,
    neovide_padding_right: number,
    neovide_padding_left: number
    neovide_floating_corner_radius: number
  } | {
    neovide: false | undefined
  }
  ),
  o: {
    guifont: string
  }
} & typeof vim;

export function isNeovideSession() {
  return (vim as unknown as NeovideAPIGExtensions).g.neovide !== undefined;
}

export function getNeovideExtendedVimContext() {
  return vim as unknown as NeovideAPIGExtensions;
}
