# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) with respect to the public API, which currently includes the installation steps, dependencies, configuration, keymappings, commands, and other plugin functionality. At the moment this does _not_ include the Lua `Client` API, although in the future it will once that API stabilizes.

## Unreleased

### Fixed

- Fixed incorrect call signature for `options.callbacks.post_set_workspace`
- Fixed incorrect fallback for `resolve_note`.

## [v3.13.0](https://github.com/obsidian-nvim/obsidian.nvim/releases/tag/v3.13.0) - 2025-07-28

### Added

- Allow custom directory and ID logic for templates
- When filling out a template with user-provided substitution functions, pass a "context" object to each invocation so that users can respond accordingly.
  - Added `obsidian.InsertTemplateContext` and `obsidian.CloneTemplateContext` as these new "context" objects.
- Github workflow and `make types` now use `lua-language-server` to check type issues.
- Added the `completion.create_new` option to allow for disabling new note creation in the picker.
- Added `makefile types` target to check types via lua-ls.
- New `obsidian.config` type for user config type check.
- More informative healthcheck.
- A guide to embed images for both viewing in neovim and obsidian app: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images
- Added `check_buffers` option to `Note.write` and `Note.save` for automatically reloading buffers with `checktime` after writing them to disk
- Added footer options.
- Added default mappings: `]o` and `[o`, for navigating links in note.
- Support pasting image to sub directory in current directory.
- Reimplement `Obsidian rename` with `vim.lsp`.
- Support parsing `title` frontmatter property.

### Changed

- Remove `itertools.lua` in favor of `vim.iter`.
- Commands are now context sensitive (mode and if in note).
- Remove `debug` command and lazy log functions, and point user to `checkhealth obsidian`.
- Remove `mappings.lua`, see: <https://github.com/obsidian-nvim/obsidian.nvim/wiki/Keymaps>
- Moved `daily` as its own module instead of client method.
- Refactor the `util` module.
- Refactor several note functionalities from `Client` into `Note`:

  | Client (old)          | Note (new)              |
  | --------------------- | ----------------------- |
  | `write_note`          | `write`                 |
  | `create_note`         | `create`                |
  | `open_note`           | `open`                  |
  | `parse_title_id_path` | `resolve_title_id_path` |
  | `new_note_id`         | `generate_id`           |
  | `new_note_path`       | `_generate_path`        |

- Refactor `Client:create_note` → `Note:create` and `Client:write_note` → `Note:write`
- Use `vim.defaulttable` instead of custom impl.
- Remove the class `obsdian.CallbackManager`, but callback system is not changed.
- Remove `api.insert_text`, use `vim.api.nvim_put`
- change `clipboard_is_img` to use `vim.fn.system` instead of `io.popen` to get the output of the command with awareness of the shell variables.
- use `run_job` wrap with `bash` to run `save_clipboard_image` async for Wayland sessions to avoid data corruption.
- Use a `Obsidian` global variable to hold the state instead of client.
- `opts.img_text_func` has an obsidian app compatibility, and only accept one path argument.
- Moved `client:apply_async` -> `api.dir`
- Deprecate `statusline` options and `vim.g.obsidian` in favor of `footer` options and `vim.b.obsidian_footer`.
- Moved `client:switch_workspace` -> `Workspace.switch`
- Moved `client:follow_link_async` -> `api.follow_link`
- Moved `client:resolve_note_async` -> `search.resolve_note_async`
- Moved `client:find_notes_async` -> `search.find_notes_async`
- `Obsidian toggle_checkbox` will only be triggered in correct context, in `paragraph` and `list` ts nodes.
- `opts.checkbox.create_new` to configure whether insert new checkbox
- Don't depend on plenary anymore!

### Fixed

- Fixed improper tmp-file creation during template tests
- Only error once if template folder is not found.
- Fixed corrupted text when custom variables appear more than once in a template file (#198)
- Add further checks to void false positives when finding tags
- Off-by-one bug when avoiding tag in code blocks
- Make tag picker case insensitive
- `ObsidianPasteImg` will now work on Wayland sessions
- Handle error exit code from git in get_plugin_info
- Fixed incorrect usage of `Note.create` in `daily_notes`.
- Fixed tag completion for blink.cmp and improved frontmatter tag handling
- Fixed to allow numbers in note IDs.
- Fixed ignore subdirectories specified in `daily_notes.date_format`
- Fixed not make sure template folder exists.
- Refactored workspace module for a better api.
- Fixed types in `opts.workspaces[*].overrides` to all be optional.
