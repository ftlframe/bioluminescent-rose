-- Theme Palette: Bioluminescent Rose
-- Edit THIS file to change the entire color scheme.
-- Every highlight in the editor references these names.

return {
  -- Backgrounds
  bg = "#000000",
  surface = "#0d0d0f",
  gutter = "#101010",
  overlay = "#191724",
  visual = "#403d52",

  -- Foreground scale (bright → dim)
  fg = "#e0def4",       -- lavender-white (body text)
  dim = "#6e6a86",      -- dusky purple (comments, receded)
  muted = "#524f67",    -- deeper mute
  faint = "#2c2c2e",    -- near-invisible (guides, separators)

  -- Tri-tone pink scale
  rose = "#ff8fb1",       -- vivid pink (keywords, logic)
  rose_bright = "#ffcfdf", -- pastel rose (strings, data)
  rose_hot = "#eb6f92",    -- deep love (errors, preprocessor)

  -- Supporting colors
  iris = "#c4a7e7",      -- pale purple (types)
  gold = "#f6c177",      -- warm gold (warnings)
  foam = "#9ccfd8",      -- soft cyan (links, redirections)
  pine = "#31748f",      -- steel blue (search accent)

  -- Functional (git, diagnostics)
  error = "#eb6f92",
  warn = "#f6c177",
  info = "#ff8fb1",
  hint = "#6e6a86",
  git_add = "#ff8fb1",
  git_change = "#c4a7e7",
  git_delete = "#eb6f92",
}
