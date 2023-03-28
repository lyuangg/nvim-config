
-- 获取当前选中的文本
local function get_visual_selection()
  local selected_text = ''
  if vim.fn.mode() == "v" then
    local selected_lines = vim.fn.getline("'<", "'>")
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")

    if #selected_lines == 1 then
        selected_text = string.sub(selected_lines[1], s_start[3], s_end[3])
    else
        for i, v in ipairs(selected_lines) do
            if i == 1 then
                selected_text = selected_text .. string.sub(v, s_start[3])
            elseif i == #selected_lines then
                selected_text = selected_text .. string.sub(v, 0, s_end[3])
            else
                selected_text = selected_text .. v
            end
        end
    end
  end
  return selected_text
end

-- 获取当前选中的文本, 如果没有选中文本则获取光标下的单词，然后打开浏览器访问该网址
function Open_url()
    local url = get_visual_selection()
    if url == "" then
        url = vim.fn.expand("<cWORD>")
    end
    if url == "" then
        return
    end
    if url:sub(1, 4) == "www." then
      url = "http://" .. url
    end
    vim.fn.jobstart({"open", url})
end

-- 打开选中的文本或光标下的单词对应的文件
function Open_file()
    local file_path = get_visual_selection()
    if file_path == "" then
        file_path = vim.fn.expand("<cfile>")
    end
    if file_path == "" then
        return
    end
    if vim.fn.filereadable(file_path) == 1 then
        vim.cmd("edit " .. file_path)
        return
    end

    local file_path2 = string.gsub(file_path, "^%.","")
    file_path2 = vim.fn.expand("%:p:h") .. "/" .. file_path2
    if vim.fn.filereadable(file_path2) == 1 then
        vim.cmd("edit " .. file_path2)
        return
    end

    local file_name = vim.fn.fnamemodify(file_path, ":t")
    local file_path3 = vim.fn.findfile(file_name)
    if file_path3 ~= "" then
        vim.cmd("edit " .. file_path3)
        return
    end

    print("File not found: " .. file_path)
end
