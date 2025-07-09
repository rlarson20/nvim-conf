## air

---
<https://github.com/posit-dev/air>

Air is an R formatter and language server, written in Rust.

Refer to the [documentation](https://posit-dev.github.io/air/editors.html) for more details.

Snippet to enable the language server: >lua
  vim.lsp.enable('air')

Default config:

- cmd: >lua
  { "air", "language-server" }
- filetypes: >lua
  { "r" }
- root_markers: >lua
  { "air.toml", ".air.toml", ".git" }
<

---

## alloy_ls

---
<https://github.com/AlloyTools/org.alloytools.alloy>

Alloy is a formal specification language for describing structures and a tool for exploring them.

You may also need to configure the filetype for Alloy (*.als) files:
>
  autocmd BufNewFile,BufRead *.als set filetype=alloy

or
>lua
  vim.filetype.add({
    pattern = {
      ['.*/*.als'] = 'alloy',
    },
  })

Alternatively, you may use a syntax plugin like <https://github.com/runoshun/vim-alloy>.

Snippet to enable the language server: >lua
  vim.lsp.enable('alloy_ls')

Default config:

- cmd: >lua
  { "alloy", "lsp" }
- filetypes: >lua
  { "alloy" }
- root_markers: >lua
  { ".git" }
<

---

## ansiblels

<https://github.com/ansible/vscode-ansible>

Language server for the ansible configuration management tool.

`ansible-language-server` can be installed via `npm`:
>sh
  npm install -g @ansible/ansible-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('ansiblels')

Default config:

- cmd: >lua
  { "ansible-language-server", "--stdio" }
- filetypes: >lua
  { "yaml.ansible" }
- root_markers: >lua
  { "ansible.cfg", ".ansible-lint" }
- settings: >lua
  {
    ansible = {
      ansible = {
        path = "ansible"
      },
      executionEnvironment = {
        enabled = false
      },
      python = {
        interpreterPath = "python"
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = "ansible-lint"
        }
      }
    }
  }
<

---

## astro

<https://github.com/withastro/language-tools/tree/main/packages/language-server>

`astro-ls` can be installed via `npm` >sh
  npm install -g @astrojs/language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('astro')

Default config:

- before_init (use "gF" to view): ../lsp/astro.lua:12
- cmd: >lua
  { "astro-ls", "--stdio" }
- filetypes: >lua
  { "astro" }
- init_options: >lua
  {
    typescript = {}
  }
- root_markers: >lua
  { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
<

------------------------------------------------------------------------------

## autotools_ls

<https://github.com/Freed-Wu/autotools-language-server>

`autotools-language-server` can be installed via `pip` >sh
  pip install autotools-language-server

Language server for autoconf, automake and make using tree sitter in python.

Snippet to enable the language server: >lua
  vim.lsp.enable('autotools_ls')

Default config:

- cmd: >lua
  { "autotools-language-server" }
- filetypes: >lua
  { "config", "automake", "make" }
- root_dir (use "gF" to view): ../lsp/autotools_ls.lua:16
<

------------------------------------------------------------------------------

## clojure_lsp

<https://github.com/clojure-lsp/clojure-lsp>

Clojure Language Server

Snippet to enable the language server: >lua
  vim.lsp.enable('clojure_lsp')

Default config:

- cmd: >lua
  { "clojure-lsp" }
- filetypes: >lua
  { "clojure", "edn" }
- root_markers: >lua
  { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn" }
<

------------------------------------------------------------------------------

## cmake

<https://github.com/regen100/cmake-language-server>

CMake LSP Implementation

Snippet to enable the language server: >lua
  vim.lsp.enable('cmake')

Default config:

- cmd: >lua
  { "cmake-language-server" }
- filetypes: >lua
  { "cmake" }
- init_options: >lua
  {
    buildDirectory = "build"
  }
- root_markers: >lua
  { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }
<

------------------------------------------------------------------------------

## coq_lsp

<https://github.com/ejgallego/coq-lsp/>

Snippet to enable the language server: >lua
  vim.lsp.enable('coq_lsp')

Default config:

- cmd: >lua
  { "coq-lsp" }
- filetypes: >lua
  { "coq" }
- root_markers: >lua
  { "_CoqProject", ".git" }
<

------------------------------------------------------------------------------

## crystalline

<https://github.com/elbywan/crystalline>

Crystal language server.

Snippet to enable the language server: >lua
  vim.lsp.enable('crystalline')

Default config:

- cmd: >lua
  { "crystalline" }
- filetypes: >lua
  { "crystal" }
- root_markers: >lua
  { "shard.yml", ".git" }
<

------------------------------------------------------------------------------

## denols

<https://github.com/denoland/deno>

Deno's built-in language server

To appropriately highlight codefences returned from denols, you will need to augment vim.g.markdown_fenced languages
 in your init.lua. Example:
>lua
  vim.g.markdown_fenced_languages = {
    "ts=typescript"
  }

Snippet to enable the language server: >lua
  vim.lsp.enable('denols')

Default config:

- cmd: >lua
  { "deno", "lsp" }
- cmd_env: >lua
  {
    NO_COLOR = true
  }
- filetypes: >lua
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
- handlers: >lua
  {
    ["textDocument/definition"] = <function 1>,
    ["textDocument/references"] = <function 1>,
    ["textDocument/typeDefinition"] = <function 1>
  }
- on_attach (use "gF" to view): ../lsp/denols.lua:66
- root_markers: >lua
  { "deno.json", "deno.jsonc", ".git" }
- settings: >lua
  {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true
          }
        }
      }
    }
  }
<

------------------------------------------------------------------------------

## diagnosticls

<https://github.com/iamcco/diagnostic-languageserver>

Diagnostic language server integrate with linters.

Snippet to enable the language server: >lua
  vim.lsp.enable('diagnosticls')

Default config:

- cmd: >lua
  { "diagnostic-languageserver", "--stdio" }
- filetypes: >lua
  {}
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------

## docker_compose_language_service

<https://github.com/microsoft/compose-language-service>
This project contains a language service for Docker Compose.

`compose-language-service` can be installed via `npm`:
>sh
  npm install @microsoft/compose-language-service

Note: If the docker-compose-langserver doesn't startup when entering a `docker-compose.yaml` file, make sure that the filetype is `yaml.docker-compose`. You can set with: `:set filetype=yaml.docker-compose`.

Snippet to enable the language server: >lua
  vim.lsp.enable('docker_compose_language_service')

Default config:

- cmd: >lua
  { "docker-compose-langserver", "--stdio" }
- filetypes: >lua
  { "yaml.docker-compose" }
- root_markers: >lua
  { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" }
<

------------------------------------------------------------------------------

## dockerls

<https://github.com/rcjsuen/dockerfile-language-server-nodejs>

`docker-langserver` can be installed via `npm` >sh
  npm install -g dockerfile-language-server-nodejs

Additional configuration can be applied in the following way >lua
  vim.lsp.config('dockerls', {
      settings = {
          docker = {
       languageserver = {
           formatter = {
        ignoreMultilineInstructions = true,
    },
       },
   }
      }
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('dockerls')

Default config:

- cmd: >lua
  { "docker-langserver", "--stdio" }
- filetypes: >lua
  { "dockerfile" }
- root_markers: >lua
  { "Dockerfile" }
<

------------------------------------------------------------------------------

## elixirls

<https://github.com/elixir-lsp/elixir-ls>

`elixir-ls` can be installed by following the instructions [here](https://github.com/elixir-lsp/elixir-ls#building-and-running).

1. Download the zip from <https://github.com/elixir-lsp/elixir-ls/releases/latest/>
2. Unzip it and make it executable.

   ```bash
   unzip elixir-ls.zip -d /path/to/elixir-ls
   # Unix
   chmod +x /path/to/elixir-ls/language_server.sh
   ```

**By default, elixir-ls doesn't have a `cmd` set.** This is because nvim-lspconfig does not make assumptions about your path. You must add the following to your init.vim or init.lua to set `cmd` to the absolute path ($HOME and ~ are not expanded) of your unzipped elixir-ls.
>lua
  vim.lsp.config('elixirls', {
      -- Unix
      cmd = { "/path/to/elixir-ls/language_server.sh" };
      -- Windows
      cmd = { "/path/to/elixir-ls/language_server.bat" };
      ...
  })

'root_dir' is chosen like this: if two or more directories containing `mix.exs` were found when searching directories upward, the second one (higher up) is chosen, with the assumption that it is the root of an umbrella app. Otherwise the directory containing the single mix.exs that was found is chosen.

Snippet to enable the language server: >lua
  vim.lsp.enable('elixirls')

Default config:

- filetypes: >lua
  { "elixir", "eelixir", "heex", "surface" }
- root_dir (use "gF" to view): ../lsp/elixirls.lua:28
<

------------------------------------------------------------------------------
elmls

<https://github.com/elm-tooling/elm-language-server#installation>

If you don't want to use Nvim to install it, then you can use >sh
  npm install -g elm elm-test elm-format @elm-tooling/elm-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('elmls')

Default config:

- capabilities: >lua
  {
    offsetEncoding = { "utf-8", "utf-16" }
  }
- cmd: >lua
  { "elm-language-server" }
- filetypes: >lua
  { "elm" }
- init_options: >lua
  {
    disableElmLSDiagnostics = false,
    elmReviewDiagnostics = "off",
    onlyUpdateDiagnosticsOnSave = false,
    skipInstallPackageConfirmation = false
  }
- root_dir (use "gF" to view): ../lsp/elmls.lua:12
<

------------------------------------------------------------------------------
elp

<https://whatsapp.github.io/erlang-language-platform>

ELP integrates Erlang into modern IDEs via the language server protocol and was
inspired by rust-analyzer.

Snippet to enable the language server: >lua
  vim.lsp.enable('elp')

Default config:

- cmd: >lua
  { "elp", "server" }
- filetypes: >lua
  { "erlang" }
- root_markers: >lua
  { "rebar.config", "erlang.mk", ".git" }
<

------------------------------------------------------------------------------
erlangls

<https://erlang-ls.github.io>

Language Server for Erlang.

Clone [erlang_ls](https://github.com/erlang-ls/erlang_ls)
Compile the project with `make` and copy resulting binaries somewhere in your $PATH eg. `cp _build/*/bin/* ~/local/bin`

Installation instruction can be found [here](https://github.com/erlang-ls/erlang_ls).

Installation requirements:
    - [Erlang OTP 21+](https://github.com/erlang/otp)
    - [rebar3 3.9.1+](https://github.com/erlang/rebar3)

Snippet to enable the language server: >lua
  vim.lsp.enable('erlangls')

Default config:

- cmd: >lua
  { "erlang_ls" }
- filetypes: >lua
  { "erlang" }
- root_markers: >lua
  { "rebar.config", "erlang.mk", ".git" }
<

------------------------------------------------------------------------------
gdscript

<https://github.com/godotengine/godot>

Language server for GDScript, used by Godot Engine.

Snippet to enable the language server: >lua
  vim.lsp.enable('gdscript')

Default config:

- cmd (use "gF" to view): ../lsp/gdscript.lua:10
- filetypes: >lua
  { "gd", "gdscript", "gdscript3" }
- root_markers: >lua
  { "project.godot", ".git" }
<

------------------------------------------------------------------------------
gdshader_lsp

<https://github.com/godofavacyn/gdshader-lsp>

A language server for the Godot Shading language.

Snippet to enable the language server: >lua
  vim.lsp.enable('gdshader_lsp')

Default config:

- cmd: >lua
  { "gdshader-lsp", "--stdio" }
- filetypes: >lua
  { "gdshader", "gdshaderinc" }
- root_markers: >lua
  { "project.godot" }
<

------------------------------------------------------------------------------
gh_actions_ls

<https://github.com/lttb/gh-actions-language-server>

Language server for GitHub Actions.

The projects [forgejo](https://forgejo.org/) and [gitea](https://about.gitea.com/)
design their actions to be as compatible to github as possible
with only [a few differences](https://docs.gitea.com/usage/actions/comparison#unsupported-workflows-syntax) between the systems.
The `gh_actions_ls` is therefore enabled for those `yaml` files as well.

The `gh-actions-language-server` can be installed via `npm`:
>sh
  npm install -g gh-actions-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('gh_actions_ls')

Default config:

- capabilities: >lua
  {
    workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true
      }
    }
  }
- cmd: >lua
  { "gh-actions-language-server", "--stdio" }
- filetypes: >lua
  { "yaml" }
- init_options: >lua
  {}
- root_dir (use "gF" to view): ../lsp/gh_actions_ls.lua:16
<

------------------------------------------------------------------------------
graphql

<https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli>

`graphql-lsp` can be installed via `npm`:
>sh
  npm install -g graphql-language-service-cli

Note that you must also have [the graphql package](https://github.com/graphql/graphql-js) installed within your project and create a [GraphQL config file](https://the-guild.dev/graphql/config/docs).

Snippet to enable the language server: >lua
  vim.lsp.enable('graphql')

Default config:

- cmd: >lua
  { "graphql-lsp", "server", "-m", "stream" }
- filetypes: >lua
  { "graphql", "typescriptreact", "javascriptreact" }
- root_dir (use "gF" to view): ../lsp/graphql.lua:15
<

------------------------------------------------------------------------------
htmx

<https://github.com/ThePrimeagen/htmx-lsp>

`htmx-lsp` can be installed via `cargo` >sh
  cargo install htmx-lsp

Lsp is still very much work in progress and experimental. Use at your own risk.

Snippet to enable the language server: >lua
  vim.lsp.enable('htmx')

Default config:

- cmd: >lua
  { "htmx-lsp" }
- filetypes: >lua
  { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
idris2_lsp

<https://github.com/idris-community/idris2-lsp>

The Idris 2 language server.

Plugins for the Idris 2 filetype include
[Idris2-Vim](https://github.com/edwinb/idris2-vim) (fewer features, stable) and
[Nvim-Idris2](https://github.com/ShinKage/nvim-idris2) (cutting-edge,
experimental).

Idris2-Lsp requires a build of Idris 2 that includes the "Idris 2 API" package.
Package managers with known support for this build include the
[AUR](https://aur.archlinux.org/packages/idris2/) and
[Homebrew](https://formulae.brew.sh/formula/idris2#default).

If your package manager does not support the Idris 2 API, you will need to build
Idris 2 from source. Refer to the
[the Idris 2 installation instructions](https://github.com/idris-lang/Idris2/blob/main/INSTALL.md)
for details.  Steps 5 and 8 are listed as "optional" in that guide, but they are
necessary in order to make the Idris 2 API available.

You need to install a version of Idris2-Lsp that is compatible with your
version of Idris 2. There should be a branch corresponding to every released
Idris 2 version after v0.4.0. Use the latest commit on that branch. For example,
if you have Idris v0.5.1, you should use the v0.5.1 branch of Idris2-Lsp.

If your Idris 2 version is newer than the newest Idris2-Lsp branch, use the
latest commit on the `master` branch, and set a reminder to check the Idris2-Lsp
repo for the release of a compatible versioned branch.

Snippet to enable the language server: >lua
  vim.lsp.enable('idris2_lsp')

Default config:

- cmd: >lua
  { "idris2-lsp" }
- filetypes: >lua
  { "idris2" }
- root_dir (use "gF" to view): ../lsp/idris2_lsp.lua:34
<

------------------------------------------------------------------------------
jqls

<https://github.com/wader/jq-lsp>
Language server for jq, written using Go.
You can install the server easily using go install >sh

# install directly

  go install github.com/wader/jq-lsp@master

# copy binary to $PATH

  cp $(go env GOPATH)/bin/jq-lsp /usr/local/bin

Note: To activate properly nvim needs to know the jq filetype.
You can add it via >lua
  vim.cmd([[au BufRead,BufNewFile *.jq setfiletype jq]])

Snippet to enable the language server: >lua
  vim.lsp.enable('jqls')

Default config:

- cmd: >lua
  { "jq-lsp" }
- filetypes: >lua
  { "jq" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
jsonls

<https://github.com/hrsh7th/vscode-langservers-extracted>

vscode-json-language-server, a language server for JSON and JSON schema

`vscode-json-language-server` can be installed via `npm` >sh
  npm i -g vscode-langservers-extracted

`vscode-json-language-server` only provides completions when snippet support is enabled. If you use Neovim older than v0.10 you need to enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.
>lua
  --Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('jsonls', {
    capabilities = capabilities,
  })

Snippet to enable the language server: >lua
  vim.lsp.enable('jsonls')

Default config:

- cmd: >lua
  { "vscode-json-language-server", "--stdio" }
- filetypes: >lua
  { "json", "jsonc" }
- init_options: >lua
  {
    provideFormatter = true
  }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
julials

<https://github.com/julia-vscode/julia-vscode>

LanguageServer.jl can be installed with `julia` and `Pkg` >sh
  julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
where `~/.julia/environments/nvim-lspconfig` is the location where
the default configuration expects LanguageServer.jl to be installed.

To update an existing install, use the following command >sh
  julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'

Note: In order to have LanguageServer.jl pick up installed packages or dependencies in a
Julia project, you must make sure that the project is instantiated >sh
  julia --project=/path/to/my/project -e 'using Pkg; Pkg.instantiate()'

Note: The julia programming language searches for global environments within the `environments/`
folder of `$JULIA_DEPOT_PATH` entries. By default this simply `~/.julia/environments`

Snippet to enable the language server: >lua
  vim.lsp.enable('julials')

Default config:

- cmd: >lua
  { "julia", "--startup-file=no", "--history-file=no", "-e", '    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig\n    # with the regular load path as a fallback\n    ls_install_path = joinpath(\n        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),\n        "environments", "nvim-lspconfig"\n    )\n    pushfirst!(LOAD_PATH, ls_install_path)\n    using LanguageServer\n    popfirst!(LOAD_PATH)\n    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")\n    project_path = let\n        dirname(something(\n            ## 1. Finds an explicitly set project (JULIA_PROJECT)\n            Base.load_path_expand((\n                p = get(ENV, "JULIA_PROJECT", nothing);\n                p === nothing ? nothing : isempty(p) ? nothing : p\n            )),\n            ## 2. Look for a Project.toml file in the current working directory,\n            ##    or parent directories, with $HOME as an upper boundary\n            Base.current_project(),\n            ## 3. First entry in the load path\n            get(Base.load_path(), 1, nothing),\n            ## 4. Fallback to default global environment,\n            ##    this is more or less unreachable\n            Base.load_path_expand("@v#.#"),\n        ))\n    end\n    @info "Running language server" VERSION pwd() project_path depot_path\n    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)\n    server.runlinter = true\n    run(server)\n  ' }
- filetypes: >lua
  { "julia" }
- on_attach (use "gF" to view): ../lsp/julials.lua:119
- root_markers: >lua
  { "Project.toml", "JuliaProject.toml" }
<

------------------------------------------------------------------------------
just

<https://github.com/terror/just-lsp>

`just-lsp` is an LSP for just built on top of the tree-sitter-just parser.

Snippet to enable the language server: >lua
  vim.lsp.enable('just')

Default config:

- cmd: >lua
  { "just-lsp" }
- filetypes: >lua
  { "just" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
lsp_ai

<https://github.com/SilasMarvin/lsp-ai>

LSP-AI is an open source language server that serves as a backend for AI-powered functionality in your favorite code
editors. It offers features like in-editor chatting with LLMs and code completions.

You will need to provide configuration for the inference backends and models you want to use, as well as configure
completion/code actions. See the [wiki docs](https://github.com/SilasMarvin/lsp-ai/wiki/Configuration) and
[examples](https://github.com/SilasMarvin/lsp-ai/blob/main/examples/nvim) for more information.

Snippet to enable the language server: >lua
  vim.lsp.enable('lsp_ai')

Default config:

- cmd: >lua
  { "lsp-ai" }
- filetypes: >lua
  {}
- init_options: >lua
  {
    memory = {
      file_store = vim.empty_dict()
    },
    models = vim.empty_dict()
  }
<

------------------------------------------------------------------------------
matlab_ls

<https://github.com/mathworks/MATLAB-language-server>

MATLAB® language server implements the Microsoft® Language Server Protocol for the MATLAB language.

Snippet to enable the language server: >lua
  vim.lsp.enable('matlab_ls')

Default config:

- cmd: >lua
  { "matlab-language-server", "--stdio" }
- filetypes: >lua
  { "matlab" }
- root_dir (use "gF" to view): ../lsp/matlab_ls.lua:6
- settings: >lua
  {
    MATLAB = {
      indexWorkspace = true,
      installPath = "",
      matlabConnectionTiming = "onStart",
      telemetry = true
    }
  }
<

------------------------------------------------------------------------------
mojo

<https://github.com/modularml/mojo>

`mojo-lsp-server` can be installed [via Modular](https://developer.modular.com/download)

Mojo is a new programming language that bridges the gap between research and production by combining Python syntax and ecosystem with systems programming and metaprogramming features.

Snippet to enable the language server: >lua
  vim.lsp.enable('mojo')

Default config:

- cmd: >lua
  { "mojo-lsp-server" }
- filetypes: >lua
  { "mojo" }
- root_markers: >lua
  { ".git" }
<

------------------------------------------------------------------------------
mutt_ls

<https://github.com/neomutt/mutt-language-server>

A language server for (neo)mutt's muttrc. It can be installed via pip.
>sh
  pip install mutt-language-server

Snippet to enable the language server: >lua
  vim.lsp.enable('mutt_ls')

Default config:

- cmd: >lua
  { "mutt-language-server" }
- filetypes: >lua
  { "muttrc", "neomuttrc" }
- root_markers: >lua
  { ".git" }
- settings: >lua
  {}
<

------------------------------------------------------------------------------
prolog_ls

<https://github.com/jamesnvc/lsp_server>

Language Server Protocol server for SWI-Prolog

Snippet to enable the language server: >lua
  vim.lsp.enable('prolog_ls')

Default config:

- cmd: >lua
  { "swipl", "-g", "use_module(library(lsp_server)).", "-g", "lsp_server:main", "-t", "halt", "--", "stdio" }
- filetypes: >lua
  { "prolog" }
- root_markers: >lua
  { "pack.pl" }
<

------------------------------------------------------------------------------
r_language_server

[languageserver](https://github.com/REditorSupport/languageserver) is an
implementation of the Microsoft's Language Server Protocol for the R
language.

It is released on CRAN and can be easily installed by
>r
  install.packages("languageserver")

Snippet to enable the language server: >lua
  vim.lsp.enable('r_language_server')

Default config:

- cmd: >lua
  { "R", "--no-echo", "-e", "languageserver::run()" }
- filetypes: >lua
  { "r", "rmd", "quarto" }
- root_dir (use "gF" to view): ../lsp/r_language_server.lua:12
<

------------------------------------------------------------------------------
