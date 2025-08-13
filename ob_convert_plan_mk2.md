Of course. Based on the provided API documentation and the latest changelog, here is a guide to rewriting your `<leader>nn` keymap to use the new, refactored API for creating notes in `obsidian.nvim`.

---

### Guide: Updating Your "Create New Note" Keymap

Recent updates to `obsidian.nvim`, as documented in `raw_changelog.md`, have refactored a significant portion of the Lua API. Many functions that were previously methods on the `Client` object have been moved to become static or instance methods on the `Note` class.

This guide will walk you through updating the `<leader>nn` keymap defined in your `obsidian.lua` file to align with this new API structure.

#### 1. The Old Keymap

Your current implementation for creating a new note looks like this:

```lua
-- Create new note
vim.keymap.set('n', '<leader>nn', function()
  local client = require('obsidian').get_client()

  vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
    if title == nil or title == '' then
      print 'Note creation cancelled.'
      return
    end

    -- 1. Create a note object in memory using the client.
    local note = client:create_note {
      title = title,
      tags = { 'obsidian-nvim-generated' },
      no_write = true,
    }
    -- 2. Open a new buffer for the note.
    client:open_note(note, { sync = true })
    -- 3. Write the note's content to the new buffer.
    client:write_note_to_buffer(note)
  end)
end, {
  buffer = ev.buf,
  desc = 'Create new note',
})
```

This code relies on three methods from the `client` object: `create_note`, `open_note`, and `write_note_to_buffer`.

#### 2. The API Changes

The `raw_changelog.md` file highlights the key refactoring:

> Refactor several note functionalities from `Client` into `Note`:
>
> | Client (old)  | Note (new) |
> |---------------|------------|
> | `write_note`  | `write`    |
> | `create_note` | `create`   |
> | `open_note`   | `open`     |

Additionally, looking at `ob_api.txt`, we can see that `write_note_to_buffer` has been replaced by an instance method on the note object itself: `note:write_to_buffer()`.

The new workflow will be:
1.  Use the static `Note.create()` method to create a note object in memory.
2.  Use the static `Note.open()` method to open a buffer for that note.
3.  Use the instance method `note:write_to_buffer()` to write its contents.

#### 3. The New Implementation

Here is the updated code for your keymap. You can directly replace the old `vim.keymap.set(...)` block with this new one.

```lua
-- Create new note
vim.keymap.set('n', '<leader>nn', function()
  -- The Note class is now used for creating and opening notes.
  local Note = require('obsidian.note')

  -- Prompt the user for a title for the new note.
  vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
    -- If the user cancelled the input, title will be nil.
    if not title or title == '' then
      print('Note creation cancelled.')
      return
    end

    -- 1. Create the new note object in memory using Note.create().
    -- The `should_write = false` option is the new equivalent of `no_write = true`.
    local note = Note.create {
      title = title,
      tags = { 'obsidian-nvim-generated' },
      should_write = false,
    }

    -- 2. Open the new note. Note.open() is a static method.
    -- The `sync = true` option ensures Neovim switches to the new buffer.
    Note.open(note, { sync = true })

    -- 3. Write the note's content and frontmatter to the newly opened buffer.
    -- This is now an instance method on the note object itself.
    note:write_to_buffer()
  end)
end, {
  buffer = ev.buf,
  desc = 'Create new note',
})
```

#### Step-by-Step Explanation of Changes

1.  **`local Note = require('obsidian.note')`**: Instead of getting the global `client` object, we now directly require the `Note` module. The operations for creating and opening a note are now handled by this class.

2.  **`Note.create { ... }`**: This is the new static method that replaces `client:create_note`.
    *   The option `no_write = true` has been replaced by **`should_write = false`**, which serves the same purpose of creating a note object in memory without immediately writing it to a file. This is confirmed by the `obsidian.note.NoteOpts` class definition in `ob_api.txt`.

3.  **`Note.open(note, { sync = true })`**: This static method replaces `client:open_note`. It takes the note object as its first argument and opens it in a buffer, switching to it synchronously.

4.  **`note:write_to_buffer()`**: This instance method replaces `client:write_note_to_buffer(note)`. Since it is called on the `note` object itself, you no longer need to pass the note as an argument. It correctly writes the note's content and frontmatter to the current buffer, which `Note.open()` just switched to.
