export function useExternalModule<ModuleType>(importTarget: string) {
  return require(importTarget) as ModuleType;
}
