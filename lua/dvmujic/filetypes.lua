
vim.cmd[[autocmd BufRead,BufEnter *.typ set filetype=typst]]
vim.cmd[[autocmd BufRead,BufEnter *.ts set filetype=typescript]]
vim.cmd[[autocmd BufRead,BufEnter *.{frag,vert} set filetype=glsl]]

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.wgsl",
    callback = function() vim.bo.filetype = "wgsl" end,
})

