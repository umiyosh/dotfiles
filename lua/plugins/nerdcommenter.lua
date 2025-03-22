return {
  {
    -- コメントアウトを簡単にするやつ
    "scrooloose/nerdcommenter",
    keys = {
      { '<Leader>x', '<Plug>NERDCommenterToggle', mode = '', silent = true },
    },
    init = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCreateDefaultMappings = 0
      vim.g.NERDShutUp = 1
      vim.g.NERDCustomDelimiters = {
        terraform = { left = '#', leftAlt = 'FOO', rightAlt = 'BAR' },
        plantuml  = { left = "'''", leftAlt = 'FOO', rightAlt = 'BAR' }
      }
    end
  },
}
