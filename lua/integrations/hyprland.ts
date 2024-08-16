export function isDesktopHyprland(this: void): boolean {
  return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") !== null;
}

// Get the refresh rates of monitors present in the system
function getRefreshRates(this: void): number[] {
  const out = vim.fn.system(["hyprctl", "monitors"]).split('\n').map(x => x.trim());

  /*
   *
   * Monitor DP-3 (ID 0):
        3440x1440@164.99899 at -960x1080
        description: Samsung Electric Company LC34G55T H4ZT300290
        make: Samsung Electric Company
        model: LC34G55T
        serial: H4ZT300290
        active workspace: 1 (1)
        special workspace: 0 ()
        reserved: 0 40 0 0
        scale: 1.00
        transform: 0
        focused: yes
        dpmsStatus: 1
        vrr: 0
        activelyTearing: false
        disabled: false
        currentFormat: XRGB8888
        availableModes: 3440x1440@99.98Hz 3440x1440@165.00Hz 3440x1440@59.97Hz 2560x1440@165.00Hz 2560x1440@99.95Hz 2560x1440@59.95Hz 1920x1080@165.00Hz 1920x1080@100.00Hz 1920x1080@60.00Hz 1920x1080@59.94Hz 1920x1080@50.00Hz 1680x1050@59.95Hz 1600x900@60.00Hz 1280x1024@75.03Hz 1280x1024@60.02Hz 1440x900@59.89Hz 1280x800@59.81Hz 1152x864@75.00Hz 1280x720@60.00Hz 1280x720@59.94Hz 1280x720@50.00Hz 1024x768@75.03Hz 1024x768@70.07Hz 1024x768@60.00Hz 800x600@75.00Hz 800x600@72.19Hz 800x600@60.32Hz 800x600@56.25Hz 720x576@50.00Hz 720x480@59.94Hz 640x480@75.00Hz 640x480@72.81Hz 640x480@59.94Hz
  * */


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
