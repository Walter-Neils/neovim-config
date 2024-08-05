type NeovideAPIGExtensions = {
  g: ({
    neovide: true,
    neovide_version: string,
    neovide_channel_id: number,
    neovide_scale_factor: number
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
