## how to make template files for nvim

[Source](https://zignar.net/2024/11/20/template-files-for-nvim/)

### BufNewFile

set it up so that if you start editing a file that doesnt exist (what BufNewFile does)

set up so ex:
`:e /tmp/newfile.sh`
triggers BufNewFile event
autocommand triggers, looks for file in
`~/.config/nvim/templates/<ext>.tpl`
if exists, read contents into buffer
in this case, `<ext>` is `sh`, so looking for `sh.tpl`

#### example shell template

```bash
#!/usr/bin/env bash
set -Eeuo pipefail
```

author had set up this vimscript autocmd:

```vim
autocmd BufNewFile * silent! 0r $HOME/.config/nvim/templates/%:e.tpl
```

### Lua and Exact Match

User turned it into Lua, for specific files (e.g. pom.xml files for maven)

Turned oneliner into this lua script:

```lua
vim.api_nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("templates", { clear = true }),
  desc = "Load template file",
  callback = function(args)
    local home = os.getenv("HOME")
    -- fnamemodify with `:t` gets the tail of the file path: the actual filename
    -- See :help fnamemodify
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local tmpl = home .. "/.config/nvim/templates/" .. fname ..".tpl"
    -- fs_stat is used to check if the file exists
    if vim.uv.fs_stat(tmpl) then
      -- See :help :read
      -- 0 is the range:
      -- This reads as: "Insert the file <tmpl> below the specified line (0)"
      vim.cmd("0r " .. tmpl)
    else
        -- fnamemodify with `:e` gets the filename extension
      local ext = vim.fn.fnamemodify(args.file, ":e")
      tmpl = home .. "/.config/nvim/templates/" .. ext ..".tpl"
      if vim.uv.fs_stat(tmpl) then
        vim.cmd("0r " .. tmpl)
      end
    end
  end
})
```

#### Example `pom.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <properties>
  </properties>

  <build>
  </build>

  <dependencies>
  </dependencies>
</project>
```

### Snippets

some templates had TODO markers to manually update
addition of `vim.snippet.expand` also allows expandding as snippet

#### updated autocommand

```lua
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("templates", { clear = true }),
  desc = "Load template file",
  callback = function(args)
    local home = os.getenv("HOME")
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local ext = vim.fn.fnamemodify(args.file, ":e")
    local candidates = { fname, ext }
    local uv = vim.uv
    for _, candidate in ipairs(candidates) do
      local tmpl = table.concat({ home, "/.config/nvim/templates/", candidate, ".tpl" })
      if uv.fs_stat(tmpl) then
        vim.cmd("0r " .. tmpl)
        return
      end
    end
    for _, candidate in ipairs(candidates) do
      local tmpl = table.concat({ home, "/.config/nvim/templates/", candidate, ".stpl" })
      local f = io.open(tmpl, "r")
      if f then
        local content = f:read("*a")
        vim.snippet.expand(content)
        return
      end
    end
  end
})
```

now tries:

- `<filename>.tpl`
- `<filename_extension>.tpl`
- `<filename>.stpl`
- `<filename_extension>.stpl`

`.tpl` is read as is into buffer, `.stpl` expanded via snippet

#### new snippet pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>${1:group}</groupId>
  <artifactId>${2:artifact}</artifactId>
  <version>${3:0.1.0}</version>
  <packaging>${4:jar}</packaging>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>${5:21}</maven.compiler.source>
    <maven.compiler.target>${5:21}</maven.compiler.target>
  </properties>

  <build>
  </build>

  <dependencies>
  </dependencies>
</project>
```

with this: start in snippet mode, with group, artifact, version, jar and JDK version, jump through each with tab to fill in
