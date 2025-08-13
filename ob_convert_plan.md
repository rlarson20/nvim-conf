Of course. Based on the provided API documentation and your current configuration, here is a guide to rewriting the `<leader>nn` keymap to use the new `obsidian.nvim` API.

### Guide to Updating the "Create New Note" Keymap (`<leader>nn`)

The new Obsidian API adopts a more object-oriented approach. Instead of calling most methods from the `client` object, you now interact directly with objects like `obsidian.Note`.

Here is a breakdown of the changes required to update your keymap.

#### 1. The Old Code

First, let's look at the original code for your `<leader>nn` mapping. It relies heavily on the `client` object for all operations.

```lua
-- OLD IMPLEMENTATION
vim.keymap.set('n', '<leader>nn', function()
  local client = require('obsidian').get_client()

  -- Prompt the user for a title for the new note.
  vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
    -- If the user cancelled the input (e.g., by pressing Esc), title will be nil.
    if title == nil or title == '' then
      print 'Note creation cancelled.'
      return
    end

    -- Create the new note with the provided title and your desired tags.
    local note = client:create_note {
      title = title,
      tags = { 'obsidian-nvim-generated' },
      no_write = true,
    }
    client:open_note(note, { sync = true })
    client:write_note_to_buffer(note)
  end)
end, {
  buffer = ev.buf,
  desc = 'Create new note',
})
```

#### 2. The New API Mappings

Based on the `ob_api.txt` documentation, here are the direct replacements for the deprecated functions:

`client:create_note({ ... })`    = `require("obsidian.note").Note.create({ ... })`.
This is a static method on the `Note` class.
The option `no_write = true` is now `should_write = false`.
`client:open_note(note, ...)`   =  `note:open({ ... })`.
`client:write_note_to_buffer(note)` | `note:write_to_buffer()`.
This is also an instance method on the `Note` object.

#### 3. The New Code (Updated Implementation)

Here is the complete, updated keymap function. You can replace your old `<leader>nn` block with this one.

```lua
-- NEW IMPLEMENTATION
vim.keymap.set('n', '<leader>nn', function()
  -- Require the Note class from the new API
  local Note = require('obsidian.note').Note

  -- Prompt the user for a title for the new note.
  vim.ui.input({ prompt = 'Enter note title: ' }, function(title)
    -- If the user cancelled the input (e.g., by pressing Esc), title will be nil.
    if title == nil or title == '' then
      print 'Note creation cancelled.'
      return
    end

    -- 1. Create a new Note object in memory.
    --    Note that we use the static method `Note.create()`.
    --    `should_write = false` prevents the note from being immediately saved to disk,
    --    mimicking the old `no_write = true` behavior.
    local note = Note.create {
      title = title,
      tags = { 'obsidian-nvim-generated' },
      should_write = false,
    }

    -- 2. Open the note in a buffer.
    --    This is now a method on the note object itself.
    note:open({ sync = true })

    -- 3. Write the note's contents (including frontmatter and template) to the buffer.
    note:write_to_buffer()
  end)
end, {
  buffer = ev.buf,
  desc = 'Create new note',
})
```

### Summary of Changes

1.  **Require the `Note` Class:** You now need to get the `Note` class definition with `local Note = require('obsidian.note').Note`.
2.  **Use `Note.create`:** The old `client:create_note` is replaced by the static method `Note.create`.
3.  **Update Creation Option:** The key `no_write = true` is replaced by its logical equivalent `should_write = false`. Based on the documentation for `obsidian.note.NoteOpts`, this option prevents the note from being written to disk upon creation.
4.  **Use `note:open()` and `note:write_to_buffer()`:** The actions of opening the note and writing its contents to a buffer are now instance methods called directly on the `note` object that you created. This makes the code more readable and object-oriented.
5.  **Client No Longer Needed:** For this specific operation, you no longer need to get the `client` instance at all, as all the required functions are available on the `Note` class and its instances.
