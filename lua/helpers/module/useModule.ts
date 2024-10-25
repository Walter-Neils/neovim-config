// Use an external module without resolving from TypeScript sources
export function useExternalModule<ModuleType>(importTarget: string) {
  try {
    return require(importTarget) as ModuleType;
  }
  catch {
    console.error(`Failed to import module ${importTarget}`);
    return undefined!;
  }
}
