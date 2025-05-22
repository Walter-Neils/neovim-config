import { usePersistentValue } from "../../helpers/persistent-data";

export function loadEnvironmentSecrets() {
  const [getEnvironmentSecrets, setEnvironmentSecrets] = usePersistentValue<{ [key: string]: string }>('environment-secrets', {});
  if (Object.keys(getEnvironmentSecrets()).length < 1) {
    setEnvironmentSecrets({});
  }
  const secrets = getEnvironmentSecrets();
  for (const key in secrets) {
    vim.env[key] = secrets[key];
  }
}
