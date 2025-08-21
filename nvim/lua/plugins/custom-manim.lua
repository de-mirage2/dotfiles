vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufEnter", "TextChanged" }, {
  pattern = "*.py",
  callback = function()
    -- Check if buffer contains a specific import
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("^%s*import%s+manim") or line:match("^%s*from%s+manim") then

        local ts_utils = require('nvim-treesitter.ts_utils')

        local last_input_range = ""

        local function get_class_name()
          local node = ts_utils.get_node_at_cursor()
          while node do
            if node:type() == "class_definition" then
              -- Get class row
              -- class_row = select(1, node:start()) -- useless
              -- Get the class name node
              for child in node:iter_children() do
                if child:type() == "identifier" then
                  class_name_found = vim.treesitter.get_node_text(child, 0)
                end
              end
            end
            node = node:parent()
          end
          return class_name_found
        end

        local function play_video()
          local class_name = get_class_name()
          
          if not class_name then
            print("No class name found at cursor!")
            return nil
          end

          local abs_filedir = vim.fn.expand('%:p:h')
          local configHandle = io.open(abs_filedir .. '/manim.cfg', 'r')
          local pixel_height, frame_rate
          for line in configHandle:lines() do
            if line:sub(1,12) == "pixel_height" then
              pixel_height = line:match("(%d+)$")
            end
            if line:sub(1,10) == "frame_rate" then
              frame_rate = line:match("(%d+)$")
            end
          end
          local mpvHandle = io.popen('mpv --fs "' .. abs_filedir .. '/media/videos/' .. vim.fn.expand('%:r') .. '/' .. pixel_height .. 'p' .. frame_rate .. '/' .. class_name .. '.mp4" & ') 
          -- local result = mpvHandle:read("*a")
          -- mpvHandle:close()
          print(result)
          return
        end

        local function render_scene(toggleMode)
          class_name = get_class_name()

          if not class_name then
            print("No class name found at cursor!")
            return nil
          end

          -- local cursor_row = vim.api.nvim_win_get_cursor(0)[1] --useless

          -- extract lines (not needed anymore
          -- local lines = vim.api.nvim_buf_get_lines(1, class_row, cursor_row, false)

          -- LOL THIS WAS KIND OF USELESS ALL I NEEDED TO DO WAS PASS THE -s FLAG I GUESS HAHA
          -- to consider: If i want to render a screenshot at a certain line, I could try and create a temp file consisting of
          -- solely the lines at & above the cursor and render that

          -- -- count self.play | self.pair
          -- -- idea: iterate through each letter/word.
          -- -- if comment (#) found, cut to next line
          -- -- if self.wait found, add 1 to the count.
          -- -- if (, add 1 to depth.
          -- -- if ), subtract 1 from depth.
          -- -- if self.play found (depth already 0), set reading=true and add 1 to the count.
          -- -- while reading if comma (,) found and depth = 1 still, add 1 to the count if the next non-space character isn't lowercase.
          -- local count = 0 
          -- local depth = 0
          -- local reading = false
          -- for j, line in ipairs(lines) do
          --   for i=1, #line do
          --     if reading then
          --       if line:sub(i,i) == "," and depth == 1 then 
          --         count = count + 1
          --       end
          --     end
          --     if line:sub(i,i) == "#" then
          --       break
          --     end
          --     if i+8 < string.len(line) then
          --       if line:sub(i,i+8) == "self.wait" then
          --         count = count + 1
          --       end
          --       if line:sub(i,i+8) == "self.play" then
          --         count = count+1
          --         reading = true
          --       end
          --     end
          --     if line:sub(i,i) == "(" then
          --       depth = depth + 1
          --     end
          --     if line:sub(i,i) == ")" then
          --       depth = depth - 1
          --       if depth == 0 then 
          --         reading = false
          --       end
          --     end
          --   end
          -- end

          -- local command = string.format("echo '%s to %s' has %s matches; uv run manim render -p %s %s", class_row, cursor_row, count, vim.api.nvim_buf_get_name(0), class_name)
          local command = string.format("uv run manim render %s %s -v DEBUG", vim.fn.expand('%:p'), class_name)

          if (toggleMode == 0) then
            command = command .. string.format(' -sqm; mpv media/images/main/%s_ManimCE_*', class_name)
          elseif (toggleMode == 1) then
            command = command .. ' -p'
          elseif (toggleMode == 2) then
            input_range = vim.fn.input("Enter range (formatted as: `x,y`): ")
            if input_range == "" then
              input_range = last_input_range
            end
            command = command .. ' -p -n ' .. input_range
          end 

          -- create new terminal buffer anyway

          -- local term_buf = nil

          -- -- find an existing terminal buffer
          -- for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          --   if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
          --     term_buf = buf
          --     break
          --   end
          -- end
          --
          -- if term_buf then
          --   -- Use existing terminal
          --   vim.api.nvim_set_current_buf(term_buf)
          --   vim.fn.chansend(vim.b.terminal_job_id, command .. "\n")
          -- else
            -- Create new vertical terminal
            vim.cmd('vsplit')
            vim.cmd('enew') -- New buffer
            -- vim.print(class_row)
            vim.fn.termopen(command)
            vim.cmd('startinsert')
          -- end
        end

        vim.keymap.set("n", "<localleader>mi", function() render_scene(0)  end, { noremap = false, silent = true })
        vim.keymap.set("n", "<localleader>mm", function() render_scene(1)  end, { noremap = false, silent = true })
        vim.keymap.set("n", "<localleader>mx", function() render_scene(2)  end, { noremap = false, silent = true })
        vim.keymap.set("n", "<localleader>mp", function() play_video() end, { noremap = false, silent = true })

        return
      end
    end
  end,
})
