export function getOpenPorts(args?: { count?: number, start?: number, end?: number }) {
  const count = args?.count ?? 1;
  const start = args?.start ?? 49152;
  const end = args?.end ?? 65535;
  const cmdResult = vim.fn.system(["bash", "-c", `comm -23 <(seq ${start} ${end} | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n ${count}`]);
  const ports = cmdResult.split('\n').map(x => Number(x)).filter(x => x !== 0);
  return ports;
}
