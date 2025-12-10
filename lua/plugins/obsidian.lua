return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    -- TODO: may or may not automate this for multiple vaults;
    -- idea: input is segment between my home and the **.md
    'BufReadPre /Users/rjlarson/Vaults/Laugh-Tale/**.md',
    'BufNewFile /Users/rjlarson/Vaults/Laugh-Tale/**.md',
    'BufReadPre /Users/rjlarson/src/Daedalus/Codex-Prometheum/**.md',
    'BufNewFile /Users/rjlarson/src/Daedalus/Codex-Prometheum/**.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    -- completion
    'hrsh7th/nvim-cmp',
    -- picker
    'nvim-telescope/telescope.nvim',
    -- syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    'MeanderingProgrammer/render-markdown.nvim',
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'LaughTale',
        path = '~/Vaults/Laugh-Tale',
      },
      {
        name = 'Codex-Prometheum',
        path = '~/src/Daedalus/Codex-Prometheum',
        overrides = {
          notes_subdir = '00_Inbox',
          daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = '10_Daily_Notes',
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = '%Y-%m-%d',
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = '%B %-d, %Y',
            -- Optional, default tags to add to each new daily note created.
            default_tags = { 'daily-notes' },
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil,
          },
          templates = {
            folder = '07_Templates',
            date_format = '%Y-%m-%d',
            time_format = '%H:%M',
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
          },
        },
      },
    },
    -- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
    -- 'workspaces'. For example:
    -- dir = "~/vaults/work",

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = '00_Seedbox',

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*".
    log_level = vim.log.levels.INFO,

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = '02_Periodic_Notes/02-01_Daily',
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = '%Y-%m-%d',
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = '%B %-d, %Y',
      -- Optional, default tags to add to each new daily note created.
      default_tags = { 'daily-notes' },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 4 chars.
      min_chars = 4,
    },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'ObsidianNoteEnter',
      callback = function(ev)
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        vim.keymap.set('n', 'gf', function()
          return require('obsidian').util.gf_passthrough()
        end, {
          buffer = ev.buf,
          noremap = false,
          expr = true,
          desc = 'Follow markdown/wiki links',
        })

        -- Toggle check-boxes.
        vim.keymap.set('n', '<leader>ch', function()
          return require('obsidian').util.toggle_checkbox()
        end, {
          buffer = ev.buf,
          desc = 'Toggle checkbox',
        })

        -- Smart action depending on context, either follow link or toggle checkbox.
        vim.keymap.set('n', '<cr>', function()
          return require('obsidian').util.smart_action()
        end, {
          buffer = ev.buf,
          expr = true,
          desc = 'Smart action (follow link or toggle checkbox)',
        })

        -- Create new note
        vim.keymap.set('n', '<leader>nn', function()
          local Note = require 'obsidian.note'

          -- Prompt the user for a title for the new note.
          vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
            -- If the user cancelled the input (e.g., by pressing Esc), title will be nil.
            if title == nil or title == '' then
              print 'Note creation cancelled.'
              return
            end

            -- Create the new note with the provided title and your desired tags.
            local note = Note.create {
              title = title,
              tags = { 'obsidian-nvim-generated' },
              no_write = true,
            }
            Note.open(note, { sync = true })
            note:write_to_buffer()
          end)
        end, {
          buffer = ev.buf,
          desc = 'Create new note',
        })
      end,
    }),
    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = 'notes_subdir',

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix '.md'
    end,

    -- Optional, customize how wiki links are formatted. You can set this to one of:
    --  * "use_alias_only", e.g. '[[Foo Bar]]'
    --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
    --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
    --  * "use_path_only", e.g. '[[foo-bar.md]]'
    -- Or you can set it to a function that takes a table of options and returns a string, like this:
    -- wiki_link_func = function(opts)
    --   return require('obsidian.util').wiki_link_id_prefix(opts)
    -- end,
    wiki_link_style = 'prepend_note_path',

    -- Optional, customize how markdown links are formatted.
    markdown_link_func = function(opts)
      return require('obsidian.util').markdown_link(opts)
    end,

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = 'markdown',

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    ['frontmatter.enabled'] = true,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    ['frontmatter.func'] = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      string.trim = function(s)
        return s:match '^%s*(.-)%s*$'
      end
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          -- Special handling for the source field
          if k == 'source' and type(v) == 'string' then
            -- Strip any YAML formatting that might have been added
            local cleaned = v:gsub('^>%-?%s*', ''):gsub('\n', ' '):trim()
            out[k] = cleaned
          else
            out[k] = v
          end
        end
      end
      return out
    end,

    -- Optional, for templates (see below).
    templates = {
      folder = '01_Vault_Meta_and_MOCs/01-02_Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      --[[ vim.fn.jobstart { 'open', url } -- Mac OS ]]
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
    -- file it will be ignored but you can customize this behavior here.
    ---@param img string
    follow_img_func = function(img)
      vim.fn.jobstart { 'qlmanage', '-p', img } -- Mac OS quick look preview
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    end,

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    ['search.sort_by'] = 'modified',
    ['search.sort_reversed'] = true,

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    ['search.max_lines'] = 1000,

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = 'vsplit',

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      ---@param client obsidian.Client
      post_setup = function(client) end,

      -- Runs anytime you enter the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      enter_note = function(client, note) end,

      -- Runs anytime you leave the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      -- leave_note = function(client, note)
      --   vim.api.nvim_buf_call(note.bufnr or 0, function()
      --     vim.cmd 'silent w'
      --   end)
      -- end,

      -- Runs right before writing the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      ---@param client obsidian.Client
      ---@param workspace obsidian.Workspace
      post_set_workspace = function(client, workspace) end,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = false, -- set to false to disable all additional syntax features
      --   update_debounce = 200, -- update delay after a text change (in milliseconds)
      --   max_file_length = 5000, -- disable UI features for files with more than this many lines
      --   -- Define how various check-boxes are displayed
      --   checkboxes = {
      --     -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      --     [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
      --     ['x'] = { char = '', hl_group = 'ObsidianDone' },
      --     ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
      --     ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
      --     ['!'] = { char = '', hl_group = 'ObsidianImportant' },
      --
      --     -- You can also add more custom ones...
      --   },
      --   -- Use bullet marks for non-checkbox lists.
      --   bullets = { char = '•', hl_group = 'ObsidianBullet' },
      --   external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      --   reference_text = { hl_group = 'ObsidianRefText' },
      --   highlight_text = { hl_group = 'ObsidianHighlightText' },
      --   tags = { hl_group = 'ObsidianTag' },
      --   block_ids = { hl_group = 'ObsidianBlockID' },
      --   hl_groups = {
      --     -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      --     ObsidianTodo = { bold = true, fg = '#f78c6c' },
      --     ObsidianDone = { bold = true, fg = '#89ddff' },
      --     ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
      --     ObsidianTilde = { bold = true, fg = '#ff5370' },
      --     ObsidianImportant = { bold = true, fg = '#d73128' },
      --     ObsidianBullet = { bold = true, fg = '#89ddff' },
      --     ObsidianRefText = { underline = true, fg = '#c792ea' },
      --     ObsidianExtLinkIcon = { fg = '#c792ea' },
      --     ObsidianTag = { italic = true, fg = '#89ddff' },
      --     ObsidianBlockID = { italic = true, fg = '#89ddff' },
      --     ObsidianHighlightText = { bg = '#75662e' },
      --   },
    },

    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = '07_Attachments', -- This is the default

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      img_name_func = function()
        -- Prefix image names with timestamp.
        return string.format('%s-', os.time())
      end,

      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format('![%s](%s)', path.name, path)
      end,
    },
  },
}
