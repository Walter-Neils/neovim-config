import { fs } from "../../shims/fs";

export function isRunningUnderNixOS(this: void) {
  return fs.existsSync("/etc/NIXOS");
}
