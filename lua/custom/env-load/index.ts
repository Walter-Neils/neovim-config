import { parseEnvFileContent } from "../../helpers/env-parser";
import { parseArgs } from "../../helpers/user_command/argparser";
import { fs } from "../../shims/fs";

function loadEnvFromFile(this: void, targetFile: string, overwrite: boolean) {
  const fileContent = fs.readFileSync(targetFile);
  const variables = parseEnvFileContent(fileContent);
  for (const key in variables) {
    if (vim.env[key] !== undefined) {
      if (!overwrite) {
        vim.notify(`Skipping environment variable '${key}' because it's already set, and '--overwrite' was not specified`, vim.log.levels.WARN);
        continue;
      }
    }
    vim.env[key] = variables[key];
  }
}

let _locatedEnvFiles: string[] | undefined = undefined;

vim.api.nvim_create_autocmd('DirChanged', {
  callback: () => {
    _locatedEnvFiles = undefined;
  }
});

function locateEnvFiles(this: void) {
  if (_locatedEnvFiles !== undefined) {
    return _locatedEnvFiles;
  }
  const cwd = vim.fn.getcwd();
  const envFiles: string[] = [];
  const crawl = (path: string) => {
    const entries = fs.readdirSync(path);
    for (const entry of entries) {
      if (entry.type === 'file') {
        if (entry.path.endsWith(".env")) {
          envFiles.push(`${path}/${entry.path}`);
        }
      }
      else if (entry.type === 'directory') {
        if (entry.path === "..") continue;
        if (entry.path === ".") continue;
        try {
          crawl(`${path}/${entry.path}`);
        } catch {
          if ((vim.g as any).debug_env_load) {
            vim.notify(`Failed to crawl directory '${path}/${entry.path}'`);
          }
        }
      }
    }
  };
  crawl(cwd);
  _locatedEnvFiles = envFiles;
  return envFiles;
}

function showEnvSourceDialog(this: void) {
  const files = locateEnvFiles();
  vim.ui.select(files, {
    prompt: 'Select a file to load',
    format_item: item => {
      return item.replace(vim.fn.getcwd() + "/", "");
    }
  }, choice => {
    if (choice === undefined) {
      return;
    }
    vim.ui.select([false, true], {
      prompt: `${choice.replace(vim.fn.getcwd() + "/", "")}: Override Duplicates?`,
      format_item: item => {
        return item ? "Yes" : "No";
      }
    }, override => {
      if (override === undefined) {
        return;
      }
      loadEnvFromFile(choice, override);
    });
  });
}

export function initCustomEnvLoader(this: void) {
  vim.api.nvim_create_user_command("Env", (_args) => {
    const args = parseArgs<{
      'from-file': string,
      'overwrite': boolean | undefined
    } | {
      'scan': boolean
    } | {
      'pick': boolean
    }>(_args.fargs);
    if (Object.keys(args).length < 1) {
      vim.notify(`Use --from-file, --scan, or --pick`);
      return;
    }
    let resolved = false;
    if ('from-file' in args) {
      resolved = true;
      loadEnvFromFile(args["from-file"], !!args.overwrite);
    }
    if ('scan' in args) {
      resolved = true;
      const files = locateEnvFiles();
      for (const file of files) {
        vim.notify(file);
      }
    }

    if ('pick' in args) {
      resolved = true;
      showEnvSourceDialog();
    }

    if (!resolved) {
      vim.notify(`Cannot handle keys ${Object.keys(args).join(",")}`, vim.log.levels.ERROR);
    }
  }, {
    nargs: '*'
  });
}
