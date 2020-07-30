let g:vim_svelte_plugin_use_typescript = 1
let g:ale_completion_tsserver_autoimport = 1

let b:ale_linter_aliases = ['css', 'javascript']
let g:ale_linters = {'svelte': ['tsserver']}
let b:ale_linters = {'svelte': ['tsserver']}
