" =============================================================================
" File:          autoload/ctrlp/ctrlp_notebook.vim
" Description:   Load notebooks directly from CtrlP
" =============================================================================


" Load guard
if ( exists('g:loaded_ctrlp_notebook') && g:loaded_ctrlp_notebook )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_notebook = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#ctrlp_notebook#init()',
	\ 'accept': 'ctrlp#ctrlp_notebook#accept',
	\ 'lname': 'notebooks',
	\ 'sname': 'notebooks',
	\ 'type': 'line',
	\ })

	" \ 'enter': 'ctrlp#ctrlp_notebook#enter()',
	" \ 'exit': 'ctrlp#ctrlp_notebook#exit()',
	" \ 'opts': 'ctrlp#ctrlp_notebook#opts()',
	" \ 'sort': 0,
	" \ 'specinput': 0,

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#ctrlp_notebook#init()
	let l:notebooks = ctrlp_notebook#list()
	if exists("v:this_notebook")
		let l:notebooks = filter(l:notebooks, "v:val != '".v:this_notebook."'")
	endif
	return l:notebooks
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#ctrlp_notebook#accept(mode, str)
	call ctrlp#exit()
  if a:mode == 'h'
    call ctrlp_notebook#delete(a:str)
    return
  endif
  call ctrlp_notebook#open(a:str)
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#ctrlp_notebook#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#ctrlp_notebook#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#ctrlp_notebook#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#ctrlp_notebook#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/notebook.vim
" command! CtrlPNotebook call ctrlp#init(ctrlp#ctrlp_notebook#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
