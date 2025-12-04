return {
  "Pocco81/auto-save.nvim",
  event = "InsertLeave", -- lazy load on leaving insert mode
  config = function()
    require("auto-save").setup({
      enabled = true, -- start enabled
      execution_message = {
        message = function() -- message to show when autosave runs
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        -- cleaning_interval = 1250,
        cleaning_intervl = 8250,
      },
      -- trigger_events = { "InsertLeave", "TextChanged" }, -- save on leave insert or text change
      trigger_events = { "InsertLeave" }, -- save on leave insert or text change
      condition = function(buf)
        local fn = vim.fn
        if fn.getbufvar(buf, "&modifiable") == 1 and fn.expand("%") ~= "" then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      -- debounce_delay = 135, -- ms to wait before writing
      debounce_delay = 6135, -- ms to wait before writing
    })
  end,
}
