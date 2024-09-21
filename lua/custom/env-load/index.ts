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

function locateEnvFiles(this: void) {
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
          vim.notify(`Failed to crawl directory '${path}/${entry.path}'`);
        }
      }
    }
  };
  crawl(cwd);
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
    vim.ui.select([true, false], {
      prompt: 'Override Duplicates?',
      format_item: item => {
        return item ? "Yes" : "No";
      }
    }, override => {
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
    if ('from-file' in args) {
      if (args["from-file"] !== undefined) {
        loadEnvFromFile(args["from-file"], !!args.overwrite);
      }
    }
    if ('scan' in args) {
      const files = locateEnvFiles();
      for (const file of files) {
        vim.notify(file);
      }
    }

    if ('pick' in args) {
      showEnvSourceDialog();
    }

  }, {
    nargs: '*'
  });
}
