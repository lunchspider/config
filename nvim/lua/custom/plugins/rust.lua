return {
    {
        'rust-lang/rust.vim',
        setup = function ()
            vim.cmd[[
                let g:rustfmt_autosave = 1
                let g:rustfmt_emit_files = 1
                let g:rustfmt_fail_silently = 0
                let g:rust_clip_command = 'xclip -selection clipboard'
            ]]
        end
    },
}
