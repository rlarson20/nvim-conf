<!--markdownlint-disable-->
## working copy of lspconfig

*lspconfig-all*

LSP configurations provided by nvim-lspconfig are listed below.

                                      Type |gO| to see the table of contents.

==============================================================================
LSP configs

------------------------------------------------------------------------------
ada_ls

https://github.com/AdaCore/ada_language_server

Installation instructions can be found [here](https://github.com/AdaCore/ada_language_server#Install).

Workspace-specific [settings](https://github.com/AdaCore/ada_language_server/blob/master/doc/settings.md) such as `projectFile` can be provided in a `.als.json` file at the root of the workspace.
Alternatively, configuration may be passed as a "settings" object to `vim.lsp.config('ada_ls', {})`:
>lua
  vim.lsp.config('ada_ls', {
      settings = {
        ada = {
          projectFile = "project.gpr";
          scenarioVariables = { ... };
        }
      }
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('ada_ls')


Default config:
- cmd: >lua
  { "ada_language_server" }
- filetypes: >lua
  { "ada" }
- root_dir (use "gF" to view): ../lsp/ada_ls.lua:23
<
------------------------------------------------------------------------------
angularls

https://github.com/angular/vscode-ng-language-service
`angular-language-server` can be installed via npm `npm install -g @angular/language-server`.
>lua
  local project_library_path = "/path/to/project/lib"
  local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

  vim.lsp.config('angularls', {
    cmd = cmd,
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('angularls')


Default config:
- cmd: >lua
  { "ngserver", "--stdio", "--tsProbeLocations", "../..,?/node_modules", "--ngProbeLocations", "../../@angular/language-server/node_modules,?/node_modules/@angular/language-server/node_modules", "--angularCoreVersion", "" }
- filetypes: >lua
  { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" }
- root_markers: >lua
  { "angular.json", "nx.json" }
<

------------------------------------------------------------------------------
arduino_language_server

https://github.com/arduino/arduino-language-server

Language server for Arduino

The `arduino-language-server` can be installed by running:
>
  go install github.com/arduino/arduino-language-server@latest

The `arduino-cli` tool must also be installed. Follow [these
installation instructions](https://arduino.github.io/arduino-cli/latest/installation/) for
your platform.

After installing `arduino-cli`, follow [these
instructions](https://arduino.github.io/arduino-cli/latest/getting-started/#create-a-configuration-file)
for generating a configuration file if you haven't done so already, and make
sure you [install any relevant platforms
libraries](https://arduino.github.io/arduino-cli/latest/getting-started/#install-the-core-for-your-board).

The language server also requires `clangd` to be installed. Follow [these
installation instructions](https://clangd.llvm.org/installation) for your
platform.

If you don't have a sketch yet create one.
>sh
  $ arduino-cli sketch new test
  $ cd test

You will need a `sketch.yaml` file in order for the language server to understand your project. It will also save you passing options to `arduino-cli` each time you compile or upload a file. You can generate the file by using the following commands.


First gather some information about your board. Make sure your board is connected and run the following:
>sh
  $ arduino-cli board list
  Port         Protocol Type              Board Name  FQBN            Core
  /dev/ttyACM0 serial   Serial Port (USB) Arduino Uno arduino:avr:uno arduino:avr

Then generate the file:
>sh
  arduino-cli board attach -p /dev/ttyACM0 -b arduino:avr:uno test.ino

The resulting file should look like this:
>yaml
  default_fqbn: arduino:avr:uno
  default_port: /dev/ttyACM0

Your folder structure should look like this:
>
  .
  ├── test.ino
  └── sketch.yaml

For further instructions about configuration options, run `arduino-language-server --help`.

Note that an upstream bug makes keywords in some cases become undefined by the language server.
Ref: https://github.com/arduino/arduino-ide/issues/159

Snippet to enable the language server: >lua
  vim.lsp.enable('arduino_language_server')


Default config:
- capabilities: >lua
  {
    textDocument = {
      semanticTokens = vim.NIL
    },
    workspace = {
      semanticTokens = vim.NIL
    }
  }
- cmd: >lua
  { "arduino-language-server" }
- filetypes: >lua
  { "arduino" }
- root_dir (use "gF" to view): ../lsp/arduino_language_server.lua:73
<

------------------------------------------------------------------------------
asm_lsp

https://github.com/bergercookie/asm-lsp

Language Server for NASM/GAS/GO Assembly

`asm-lsp` can be installed via cargo:
cargo install asm-lsp

Snippet to enable the language server: >lua
  vim.lsp.enable('asm_lsp')


Default config:
- cmd: >lua
  { "asm-lsp" }
- filetypes: >lua
  { "asm", "vmasm" }
- root_markers: >lua
  { ".asm-lsp.toml", ".git" }
<

------------------------------------------------------------------------------
awk_ls

https://github.com/Beaglefoot/awk-language-server/

`awk-language-server` can be installed via `npm` >sh
  npm install -g awk-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('awk_ls')


Default config:
- cmd: >lua
  { "awk-language-server" }
- filetypes: >lua
  { "awk" }
<

------------------------------------------------------------------------------
bacon_ls

https://github.com/crisidev/bacon-ls

A Language Server Protocol wrapper for [bacon](https://dystroy.org/bacon/).
It offers textDocument/diagnostic and workspace/diagnostic capabilities for Rust
workspaces using the Bacon export locations file.

It requires `bacon` and `bacon-ls` to be installed on the system using
[mason.nvim](https://github.com/williamboman/mason.nvim) or manually
>sh
  $ cargo install --locked bacon bacon-ls

Settings can be changed using the `init_options` dictionary:util
>lua
  init_options = {
      -- Bacon export filename (default: .bacon-locations).
      locationsFile = ".bacon-locations",
      -- Try to update diagnostics every time the file is saved (default: true).
      updateOnSave = true,
      --  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
      updateOnSaveWaitMillis = 1000,
      -- Try to update diagnostics every time the file changes (default: true).
      updateOnChange = true,
      -- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
      validateBaconPreferences = true,
      -- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
      createBaconPreferencesFile = true,
      -- Run bacon in background for the bacon-ls job (default: true)
      runBaconInBackground = true,
      -- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
      runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
      -- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
      synchronizeAllOpenFilesWaitMillis = 2000,
  }

Snippet to enable the language server: >lua
  vim.lsp.enable('bacon_ls')


Default config:
- cmd: >lua
  { "bacon-ls" }
- filetypes: >lua
  { "rust" }
- init_options: >lua
  {}
- root_markers: >lua
  { ".bacon-locations", "Cargo.toml" }
<

------------------------------------------------------------------------------
basedpyright

https://detachhead.github.io/basedpyright

`basedpyright`, a static type checker and language server for python

Snippet to enable the language server: >lua
  vim.lsp.enable('basedpyright')


Default config:
- cmd: >lua
  { "basedpyright-langserver", "--stdio" }
- filetypes: >lua
  { "python" }
- on_attach (use "gF" to view): ../lsp/basedpyright.lua:22
- root_markers: >lua
  { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" }
- settings: >lua
  {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  }
<

------------------------------------------------------------------------------
bashls

https://github.com/bash-lsp/bash-language-server

`bash-language-server` can be installed via `npm` >sh
  npm i -g bash-language-server

Language server for bash, written using tree sitter in typescript.

Snippet to enable the language server: >lua
  vim.lsp.enable('bashls')


Default config:
- cmd: >lua
  { "bash-language-server", "start" }
- filetypes: >lua
  { "bash", "sh" }
- root_markers: >lua
  { ".git" }
- settings: >lua
  {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    }
  }
<

------------------------------------------------------------------------------
clangd

https://clangd.llvm.org/installation.html

- **NOTE:** Clang >= 11 is recommended! See [#23](https://github.com/neovim/nvim-lspconfig/issues/23).
- If `compile_commands.json` lives in a build directory, you should
  symlink it to the root of your source tree.
  ```
  ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/
  ```
- clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html)
  specified as compile_commands.json, see https://clangd.llvm.org/installation#compile_commandsjson

Snippet to enable the language server: >lua
  vim.lsp.enable('clangd')


Default config:
- capabilities: >lua
  {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true
      }
    }
  }
- cmd: >lua
  { "clangd" }
- filetypes: >lua
  { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
- on_attach (use "gF" to view): ../lsp/clangd.lua:63
- on_init (use "gF" to view): ../lsp/clangd.lua:63
- root_markers: >lua
  { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" }
<

------------------------------------------------------------------------------
css_variables

https://github.com/vunguyentuan/vscode-css-variables/tree/master/packages/css-variables-language-server

CSS variables autocompletion and go-to-definition

`css-variables-language-server` can be installed via `npm`:
>sh
  npm i -g css-variables-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('css_variables')


Default config:
- cmd: >lua
  { "css-variables-language-server", "--stdio" }
- filetypes: >lua
  { "css", "scss", "less" }
- root_markers: >lua
  { "package.json", ".git" }
- settings: >lua
  {
    cssVariables = {
      blacklistFolders = { "**/.cache", "**/.DS_Store", "**/.git", "**/.hg", "**/.next", "**/.svn", "**/bower_components", "**/CVS", "**/dist", "**/node_modules", "**/tests", "**/tmp" },
      lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" }
    }
  }
<

------------------------------------------------------------------------------
cssls

https://github.com/hrsh7th/vscode-langservers-extracted

`css-languageserver` can be installed via `npm`:
>sh
  npm i -g vscode-langservers-extracted

Neovim does not currently include built-in snippets. `vscode-css-language-server` only provides completions when snippet support is enabled. To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.
>lua
  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('cssls', {
    capabilities = capabilities,
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('cssls')


Default config:
- cmd: >lua
  { "vscode-css-language-server", "--stdio" }
- filetypes: >lua
  { "css", "scss", "less" }
- init_options: >lua
  {
    provideFormatter = true
  }
- root_markers: >lua
  { "package.json", ".git" }
- settings: >lua
  {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  }
<

------------------------------------------------------------------------------
djlsp

https://github.com/fourdigits/django-template-lsp

`djlsp`, a language server for Django templates.

Snippet to enable the language server: >lua
  vim.lsp.enable('djlsp')


Default config:
- cmd: >lua
  { "djlsp" }
- filetypes: >lua
  { "html", "htmldjango" }
- root_markers: >lua
  { ".git" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
eslint

https://github.com/hrsh7th/vscode-langservers-extracted

`vscode-eslint-language-server` is a linting engine for JavaScript / Typescript.
It can be installed via `npm`:
>sh
  npm i -g vscode-langservers-extracted

The default `on_attach` config provides the `LspEslintFixAll` command that can be used to format a document on save >lua
  local base_on_attach = vim.lsp.config.eslint.on_attach
  vim.lsp.config("eslint", {
    on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  })

See [vscode-eslint](https://github.com/microsoft/vscode-eslint/blob/55871979d7af184bf09af491b6ea35ebd56822cf/server/src/eslintServer.ts#L216-L229) for configuration options.

Messages handled in lspconfig: `eslint/openDoc`, `eslint/confirmESLintExecution`, `eslint/probeFailed`, `eslint/noLibrary`

Additional messages you can handle: `eslint/noConfig`

Snippet to enable the language server: >lua
  vim.lsp.enable('eslint')


Default config:
- before_init (use "gF" to view): ../lsp/eslint.lua:37
- cmd: >lua
  { "vscode-eslint-language-server", "--stdio" }
- filetypes: >lua
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" }
- handlers: >lua
  {
    ["eslint/confirmESLintExecution"] = <function 1>,
    ["eslint/noLibrary"] = <function 2>,
    ["eslint/openDoc"] = <function 3>,
    ["eslint/probeFailed"] = <function 4>
  }
- on_attach (use "gF" to view): ../lsp/eslint.lua:37
- root_dir (use "gF" to view): ../lsp/eslint.lua:37
- settings: >lua
  {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = false,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
    }
  }
- `workspace_required` : `true`
<

------------------------------------------------------------------------------
gitlab_ci_ls

https://github.com/alesbrelih/gitlab-ci-ls

Language Server for Gitlab CI

`gitlab-ci-ls` can be installed via cargo:
cargo install gitlab-ci-ls

Snippet to enable the language server: >lua
  vim.lsp.enable('gitlab_ci_ls')


Default config:
- cmd: >lua
  { "gitlab-ci-ls" }
- filetypes: >lua
  { "yaml.gitlab" }
- init_options: >lua
  {
    cache_path = "/home/runner/.cache/gitlab-ci-ls/",
    log_path = "/home/runner/.cache/gitlab-ci-ls//log/gitlab-ci-ls.log"
  }
- root_dir (use "gF" to view): ../lsp/gitlab_ci_ls.lua:14
<

------------------------------------------------------------------------------
html

https://github.com/hrsh7th/vscode-langservers-extracted

`vscode-html-language-server` can be installed via `npm` >sh
  npm i -g vscode-langservers-extracted

Neovim does not currently include built-in snippets. `vscode-html-language-server` only provides completions when snippet support is enabled.
To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.

The code-formatting feature of the lsp can be controlled with the `provideFormatter` option.
>lua
  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('html', {
    capabilities = capabilities,
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('html')


Default config:
- cmd: >lua
  { "vscode-html-language-server", "--stdio" }
- filetypes: >lua
  { "html", "templ" }
- init_options: >lua
  {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
- root_markers: >lua
  { "package.json", ".git" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
java_language_server

https://github.com/georgewfraser/java-language-server

Java language server

Point `cmd` to `lang_server_linux.sh` or the equivalent script for macOS/Windows provided by java-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('java_language_server')


Default config:
- filetypes: >lua
  { "java" }
- root_markers: >lua
  { "build.gradle", "build.gradle.kts", "pom.xml", ".git" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
jinja_lsp

jinja-lsp enhances minijinja development experience by providing Helix/Nvim users with advanced features such as autocomplete, syntax highlighting, hover, goto definition, code actions and linting.

The file types are not detected automatically, you can register them manually (see below) or override the filetypes:
>lua
  vim.filetype.add {
    extension = {
      jinja = 'jinja',
      jinja2 = 'jinja',
      j2 = 'jinja',
    },
  }

Snippet to enable the language server: >lua
  vim.lsp.enable('jinja_lsp')


Default config:
- cmd: >lua
  { "jinja-lsp" }
- filetypes: >lua
  { "jinja" }
- name: >lua
  "jinja_lsp"
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
lemminx

https://github.com/eclipse/lemminx

The easiest way to install the server is to get a binary from https://github.com/redhat-developer/vscode-xml/releases and place it on your PATH.

NOTE to macOS users: Binaries from unidentified developers are blocked by default. If you trust the downloaded binary, run it once, cancel the prompt, then remove the binary from Gatekeeper quarantine with `xattr -d com.apple.quarantine lemminx`. It should now run without being blocked.

Snippet to enable the language server: >lua
  vim.lsp.enable('lemminx')


Default config:
- cmd: >lua
  { "lemminx" }
- filetypes: >lua
  { "xml", "xsd", "xsl", "xslt", "svg" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
ltex_plus

https://github.com/ltex-plus/ltex-ls-plus

LTeX Language Server: LSP language server for LanguageTool 🔍✔️ with support for LaTeX 🎓, Markdown 📝, and others

To install, download the latest [release](https://github.com/ltex-plus/ltex-ls-plus) and ensure `ltex-ls-plus` is on your path.

This server accepts configuration via the `settings` key.
>lua
    settings = {
      ltex = {
        language = "en-GB",
      },
    },

To support org files or R sweave, users can define a custom filetype autocommand (or use a plugin which defines these filetypes):
>lua
  vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]

Snippet to enable the language server: >lua
  vim.lsp.enable('ltex_plus')


Default config:
- cmd: >lua
  { "ltex-ls-plus" }
- filetypes: >lua
  { "bib", "context", "gitcommit", "html", "markdown", "org", "pandoc", "plaintex", "quarto", "mail", "mdx", "rmd", "rnoweb", "rst", "tex", "text", "typst", "xhtml" }
- get_language_id (use "gF" to view): ../lsp/ltex_plus.lua:39
- root_markers: >lua
  { ".git" }
- settings: >lua
  {
    ltex = {
      enabled = { "bib", "context", "gitcommit", "html", "markdown", "org", "pandoc", "plaintex", "quarto", "mail", "mdx", "rmd", "rnoweb", "rst", "tex", "latex", "text", "typst", "xhtml" }
    }
  }
<

------------------------------------------------------------------------------
lua_ls

https://github.com/luals/lua-language-server

Lua language server.

`lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).

The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.

If you primarily use `lua-language-server` for Neovim, and want to provide completions,
analysis, and location handling for plugins on runtime path, you can use the following
settings.
>lua
  vim.lsp.config('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })

See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
* [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
* [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)

Snippet to enable the language server: >lua
  vim.lsp.enable('lua_ls')


Default config:
- cmd: >lua
  { "lua-language-server" }
- filetypes: >lua
  { "lua" }
- root_markers: >lua
  { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }
<

------------------------------------------------------------------------------
markdown_oxide

https://github.com/Feel-ix-343/markdown-oxide

Editor Agnostic PKM: you bring the text editor and we
bring the PKM.

Inspired by and compatible with Obsidian.

Check the readme to see how to properly setup.

Snippet to enable the language server: >lua
  vim.lsp.enable('markdown_oxide')


Default config:
- cmd: >lua
  { "markdown-oxide" }
- filetypes: >lua
  { "markdown" }
- on_attach (use "gF" to view): ../lsp/markdown_oxide.lua:11
- root_markers: >lua
  { ".git", ".obsidian", ".moxide.toml" }
<

------------------------------------------------------------------------------
marksman

https://github.com/artempyanykh/marksman

Marksman is a Markdown LSP server providing completion, cross-references, diagnostics, and more.

Marksman works on MacOS, Linux, and Windows and is distributed as a self-contained binary for each OS.

Pre-built binaries can be downloaded from https://github.com/artempyanykh/marksman/releases

Snippet to enable the language server: >lua
  vim.lsp.enable('marksman')


Default config:
- cmd: >lua
  { "marksman", "server" }
- filetypes: >lua
  { "markdown", "markdown.mdx" }
- root_markers: >lua
  { ".marksman.toml", ".git" }
<

------------------------------------------------------------------------------
nginx_language_server

https://pypi.org/project/nginx-language-server/

`nginx-language-server` can be installed via pip:
>sh
  pip install -U nginx-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('nginx_language_server')


Default config:
- cmd: >lua
  { "nginx-language-server" }
- filetypes: >lua
  { "nginx" }
- root_markers: >lua
  { "nginx.conf", ".git" }
<

------------------------------------------------------------------------------
oxlint

https://github.com/oxc-project/oxc

`oxc` is a linter / formatter for JavaScript / Typescript supporting over 500 rules from ESLint and its popular plugins
It can be installed via `npm`:
>sh
  npm i -g oxlint

Snippet to enable the language server: >lua
  vim.lsp.enable('oxlint')


Default config:
- cmd: >lua
  { "oxc_language_server" }
- filetypes: >lua
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
- root_dir (use "gF" to view): ../lsp/oxlint.lua:14
- `workspace_required` : `true`
<

------------------------------------------------------------------------------
postgres_lsp

https://pgtools.dev

A collection of language tools and a Language Server Protocol (LSP) implementation for Postgres, focusing on developer experience and reliable SQL tooling.

Snippet to enable the language server: >lua
  vim.lsp.enable('postgres_lsp')


Default config:
- cmd: >lua
  { "postgrestools", "lsp-proxy" }
- filetypes: >lua
  { "sql" }
- root_markers: >lua
  { "postgrestools.jsonc" }
<

------------------------------------------------------------------------------
ruff

https://github.com/astral-sh/ruff

A Language Server Protocol implementation for Ruff, an extremely fast Python linter and code formatter, written in Rust. It can be installed via `pip`.
>sh
  pip install ruff

**Available in Ruff `v0.4.5` in beta and stabilized in Ruff `v0.5.3`.**

This is the new built-in language server written in Rust. It supports the same feature set as `ruff-lsp`, but with superior performance and no installation required. Note that the `ruff-lsp` server will continue to be maintained until further notice.

Server settings can be provided via:
>lua
  vim.lsp.config('ruff', {
    init_options = {
      settings = {
        -- Server settings should go here
      }
    }
  })

Refer to the [documentation](https://docs.astral.sh/ruff/editors/) for more details.

Snippet to enable the language server: >lua
  vim.lsp.enable('ruff')


Default config:
- cmd: >lua
  { "ruff", "server" }
- filetypes: >lua
  { "python" }
- root_markers: >lua
  { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
rust_analyzer

https://github.com/rust-lang/rust-analyzer

rust-analyzer (aka rls 2.0), a language server for Rust


See [docs](https://rust-analyzer.github.io/book/configuration.html) for extra settings. The settings can be used like this >lua
  vim.lsp.config('rust_analyzer', {
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false;
        }
      }
    }
  })

Note: do not set `init_options` for this LS config, it will be automatically populated by the contents of settings["rust-analyzer"] per
https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26.

Snippet to enable the language server: >lua
  vim.lsp.enable('rust_analyzer')


Default config:
- before_init (use "gF" to view): ../lsp/rust_analyzer.lua:54
- capabilities: >lua
  {
    experimental = {
      serverStatusNotification = true
    }
  }
- cmd: >lua
  { "rust-analyzer" }
- filetypes: >lua
  { "rust" }
- on_attach (use "gF" to view): ../lsp/rust_analyzer.lua:54
- root_dir (use "gF" to view): ../lsp/rust_analyzer.lua:54
<

------------------------------------------------------------------------------
sqls

https://github.com/sqls-server/sqls
>lua
  vim.lsp.config('sqls', {
    cmd = {"path/to/command", "-config", "path/to/config.yml"};
    ...
  })
Sqls can be installed via `go install github.com/sqls-server/sqls@latest`. Instructions for compiling Sqls from the source can be found at [sqls-server/sqls](https://github.com/sqls-server/sqls).

Snippet to enable the language server: >lua
  vim.lsp.enable('sqls')


Default config:
- cmd: >lua
  { "sqls" }
- filetypes: >lua
  { "sql", "mysql" }
- root_markers: >lua
  { "config.yml" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
superhtml

https://github.com/kristoff-it/superhtml

HTML Language Server & Templating Language Library

This LSP is designed to tightly adhere to the HTML spec as well as enforcing
some additional rules that ensure HTML clarity.

If you want to disable HTML support for another HTML LSP, add the following
to your configuration:
>lua
  vim.lsp.config('superhtml', {
    filetypes = { 'superhtml' }
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('superhtml')


Default config:
- cmd: >lua
  { "superhtml", "lsp" }
- filetypes: >lua
  { "superhtml", "html" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
tailwindcss

https://github.com/tailwindlabs/tailwindcss-intellisense

Tailwind CSS Language Server can be installed via npm:

npm install -g @tailwindcss/language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('tailwindcss')


Default config:
- before_init (use "gF" to view): ../lsp/tailwindcss.lua:9
- cmd: >lua
  { "tailwindcss-language-server", "--stdio" }
- filetypes: >lua
  { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" }
- root_dir (use "gF" to view): ../lsp/tailwindcss.lua:9
- settings: >lua
  {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html"
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
- `workspace_required` : `true`
<

------------------------------------------------------------------------------
taplo

https://taplo.tamasfe.dev/cli/usage/language-server.html

Language server for Taplo, a TOML toolkit.

`taplo-cli` can be installed via `cargo` >sh
  cargo install --features lsp --locked taplo-cli

Snippet to enable the language server: >lua
  vim.lsp.enable('taplo')


Default config:
- cmd: >lua
  { "taplo", "lsp", "stdio" }
- filetypes: >lua
  { "toml" }
- root_markers: >lua
  { ".taplo.toml", "taplo.toml", ".git" }
<

------------------------------------------------------------------------------
ts_ls

https://github.com/typescript-language-server/typescript-language-server

`ts_ls`, aka `typescript-language-server`, is a Language Server Protocol implementation for TypeScript wrapping `tsserver`. Note that `ts_ls` is not `tsserver`.

`typescript-language-server` depends on `typescript`. Both packages can be installed via `npm` >sh
  npm install -g typescript typescript-language-server

To configure typescript language server, add a
[`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) or
[`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to the root of your
project.

Here's an example that disables type checking in JavaScript files.
>json
  {
    "compilerOptions": {
      "module": "commonjs",
      "target": "es6",
      "checkJs": false
    },
    "exclude": [
      "node_modules"
    ]
  }

Use the `:LspTypescriptSourceAction` command to see "whole file" ("source") code-actions such as:
- organize imports
- remove unused code

### Vue support

As of 2.0.0, the Vue language server no longer supports TypeScript itself. Instead, a plugin
adds Vue support to this language server.

*IMPORTANT*: It is crucial to ensure that `@vue/typescript-plugin` and `@vue/language-server `are of identical versions.
>lua
  vim.lsp.config('ts_ls', {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = {"javascript", "typescript", "vue"},
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  })

  -- You must make sure the Vue language server is setup
  -- e.g. vim.lsp.config('vue_ls')
  -- See vue_ls's section for more information

`location` MUST be defined. If the plugin is installed in `node_modules`,
`location` can have any value.

`languages` must include `vue` even if it is listed in `filetypes`.

`filetypes` is extended here to include Vue SFC.

Snippet to enable the language server: >lua
  vim.lsp.enable('ts_ls')


Default config:
- cmd: >lua
  { "typescript-language-server", "--stdio" }
- filetypes: >lua
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
- handlers: >lua
  {
    ["_typescript.rename"] = <function 1>
  }
- init_options: >lua
  {
    hostInfo = "neovim"
  }
- on_attach (use "gF" to view): ../lsp/ts_ls.lua:73
- root_markers: >lua
  { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
<

------------------------------------------------------------------------------
ty

https://github.com/astral-sh/ty

A Language Server Protocol implementation for ty, an extremely fast Python type checker and language server, written in Rust.

For installation instructions, please refer to the [ty documentation](https://github.com/astral-sh/ty/blob/main/README.md#getting-started).

Snippet to enable the language server: >lua
  vim.lsp.enable('ty')


Default config:
- cmd: >lua
  { "ty", "server" }
- filetypes: >lua
  { "python" }
- root_markers: >lua
  { "ty.toml", "pyproject.toml", ".git" }
<

------------------------------------------------------------------------------
vale_ls

https://github.com/errata-ai/vale-ls

An implementation of the Language Server Protocol (LSP) for the Vale command-line tool.

Snippet to enable the language server: >lua
  vim.lsp.enable('vale_ls')


Default config:
- cmd: >lua
  { "vale-ls" }
- filetypes: >lua
  { "markdown", "text", "tex", "rst" }
- root_markers: >lua
  { ".vale.ini" }
<

------------------------------------------------------------------------------
vimls

https://github.com/iamcco/vim-language-server

You can install vim-language-server via npm >sh
  npm install -g vim-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('vimls')


Default config:
- cmd: >lua
  { "vim-language-server", "--stdio" }
- filetypes: >lua
  { "vim" }
- init_options: >lua
  {
    diagnostic = {
      enable = true
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      runtimepath = true
    },
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true
    },
    vimruntime = ""
  }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
wasm_language_tools

https://github.com/g-plane/wasm-language-tools

WebAssembly Language Tools aims to provide and improve the editing experience of WebAssembly Text Format.
It also provides an out-of-the-box formatter (a.k.a. pretty printer) for WebAssembly Text Format.

Snippet to enable the language server: >lua
  vim.lsp.enable('wasm_language_tools')


Default config:
- cmd: >lua
  { "wat_server" }
- filetypes: >lua
  { "wat" }
<

------------------------------------------------------------------------------
yamlls

https://github.com/redhat-developer/yaml-language-server

`yaml-language-server` can be installed via `yarn` >sh
  yarn global add yaml-language-server

To use a schema for validation, there are two options:

1. Add a modeline to the file. A modeline is a comment of the form:
>
  # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>

where the relative filepath is the path relative to the open yaml file, and the absolute filepath
is the filepath relative to the filesystem root ('/' on unix systems)

2. Associated a schema url, relative , or absolute (to root of project, not to filesystem root) path to
the a glob pattern relative to the detected project root. Check `:checkhealth vim.lsp` to determine the resolved project
root.
>lua
  vim.lsp.config('yamlls', {
    ...
    settings = {
      yaml = {
        ... -- other settings. note this overrides the lspconfig defaults.
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["../path/relative/to/file.yml"] = "/.github/workflows/*",
          ["/path/from/root/of/project"] = "/.github/workflows/*",
        },
      },
    }
  })

Currently, kubernetes is special-cased in yammls, see the following upstream issues:
* [#211](https://github.com/redhat-developer/yaml-language-server/issues/211).
* [#307](https://github.com/redhat-developer/yaml-language-server/issues/307).

To override a schema to use a specific k8s schema version (for example, to use 1.18):
>lua
  vim.lsp.config('yamlls', {
    ...
    settings = {
      yaml = {
        ... -- other settings. note this overrides the lspconfig defaults.
        schemas = {
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] = "/*.k8s.yaml",
          ... -- other schemas
        },
      },
    }
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('yamlls')


Default config:
- cmd: >lua
  { "yaml-language-server", "--stdio" }
- filetypes: >lua
  { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" }
- root_markers: >lua
  { ".git" }
- settings: >lua
  {
    redhat = {
      telemetry = {
        enabled = false
      }
    }
  }
<

------------------------------------------------------------------------------
## DAP docs
