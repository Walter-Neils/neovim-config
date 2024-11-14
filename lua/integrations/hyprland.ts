export function isDesktopHyprland(this: void): boolean {
  return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") !== null;
}

// Get the refresh rates of monitors present in the system
function getRefreshRates(this: void): number[] {
  const out = vim.fn.system(["hyprctl", "monitors"]).split('\n').map(x => x.trim());

  // Monitor res and refresh rates are the only non-blank lines that don't have `:` in them
  const targets = out.filter(x => !x.includes(":")).map(x => x.trim()).filter(x => x.length > 0);


  const extractRefreshRate = function(this: void, line: string) {
    const [resAndRefresh] = line.split(' at ');
    const [resolution, refreshRate] = resAndRefresh.split('@');
    return Number(refreshRate);
  };

  return targets.map(x => extractRefreshRate(x));
}

export const Hyprland = {
  getRefreshRates
}
