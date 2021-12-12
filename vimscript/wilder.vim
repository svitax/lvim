call wilder#enable_cmdline_enter()
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
cmap <expr> <C-j> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <C-k> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#setup({'modes': [':', '/', '?']})

" This allows using the history menu without having the substitution pipeline
" kick in which uses the wildmenu renderer
" @see: https://github.com/gelguy/wilder.nvim/issues/84
let s:always_use_popupmenu = 0
function! s:set_always_use_popupmenu(use, x)
  let s:always_use_popupmenu = a:use
  return a:x
endfunction

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
      \       'dir_command': ['fd', '-td'],
      \       'filters': ['cpsm_filter'],
      \     }),
      \     wilder#substitute_pipeline({
      \       'pipeline': wilder#python_search_pipeline({
      \         'skip_cmdtype_check': 1,
      \         'pattern': wilder#python_fuzzy_pattern({
      \           'start_at_boundary': 0,
      \         }),
      \       }),
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
      \     }),
      \     [
      \       wilder#check({_, x -> empty(x)}),
      \       wilder#history(),
      \     ],
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern({
      \         'start_at_boundary': 0,
      \       }),
      \     }),
      \   ),
      \ ])

let s:highlighters = [
      \ wilder#pcre2_highlighter(),
      \ has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
      \ ]

let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'border': 'rounded',
      \ 'max_height': '20%',
      \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \ 'highlighter': s:highlighters,
      \ 'highlights': #{
      \   default: 'Normal',
      \   border: 'Comment',
      \   accent: wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#89b482'}]),
      \  },
      \ 'left': [
      \   ' ',
      \   wilder#popupmenu_devicons(),
      \   wilder#popupmenu_buffer_flags({
      \     'flags': ' a + ',
      \     'icons': {'+': '', 'a': '', 'h': ''},
      \   }),
      \ ],
      \ 'right': [
      \   ' ',
      \   wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

" let s:wildmenu_renderer = wilder#wildmenu_renderer({
"       \ 'highlighter': s:highlighters,
"       \ 'separator': ' · ',
"       \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
"       \ 'right': [' ', wilder#wildmenu_index()],
"       \  'highlights': #{
"       \    default:  'CursorColumn',
"       \    accent: wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#89b482'}]),
"       \  },
"       \ 'apply_incsearch_fix': 1
"       \ })

let s:wildmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'border': 'rounded',
      \ 'max_height': '20%',
      \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \ 'highlighter': s:highlighters,
      \ 'apply_incsearch_fix': 1,
      \ 'highlights': #{
      \   default: 'Normal',
      \   border: 'Comment',
      \   accent: wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#89b482'}]),
      \  },
      \ 'left': [
      \   ' ',
      \   wilder#popupmenu_devicons(),
      \   wilder#popupmenu_buffer_flags({
      \     'flags': ' a + ',
      \     'icons': {'+': '', 'a': '', 'h': ''},
      \   }),
      \ ],
      \ 'right': [
      \   ' ',
      \   wilder#popupmenu_scrollbar(),
      \ ],
      \ }))


call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': s:popupmenu_renderer,
      \ '/': s:wildmenu_renderer,
      \ 'substitute': s:wildmenu_renderer,
      \ }))
