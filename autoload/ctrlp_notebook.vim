" vim:fdm=marker

" ctrlp_notebook.vim - Ctrlp extension to manage notes and code snippets.
" Maintainer:         Pascal Lalancette
" Version:            1.0


" Return notebook location path {{{
function! s:notebook_path()
    if !exists('g:ctrlp_notebook_path')
        return expand('%:.')
    endif
    return g:ctrlp_notebook_path
endfunction
"}}}

" Return a note file path from its name {{{
function! s:note_file(name)
    let l:file = s:notebook_path()."/".a:name.".py"
    return fnamemodify(expand(l:file), ':p')
endfunction

"}}}

" system() implementation which keep only first line and remove ending newline
" {{{
function! s:system(cmd)
    let l:output=system(a:cmd)
    let l:lines = split(l:output, "\n")
    if empty(l:lines)
        return ""
    endif
    return l:lines[0]
endfunction
" }}}

function! s:edit(name)
    let l:note = s:note_file(a:name)
    exec("edit ".l:note)
    exec("setlocal makeprg=python\\ \%")
    silent! nunmap <Leader>r
    nnoremap <silent> <Leader>r :call ctrlp_notebook#run()<CR>
    silent! nunmap <Leader>d
    nnoremap <silent> <Leader>d :call ctrlp_notebook#debug()<CR>
endfunction

" Create a note {{{
function! ctrlp_notebook#create(name)
    " Make sure notebook folder path exits
    if empty(glob(s:notebook_path()))
        mkdir(:notebook_path())
    endif
    call s:edit(a:name)
    echo 'Note '.a:name.' created!'
endfunction
"}}}

" Open a note {{{
function! ctrlp_notebook#open(name)
    call s:edit(a:name)
    echo 'Editing note '.a:name
endfunction
"}}}

" Delete a note {{{
function! ctrlp_notebook#delete(name)
    call delete(s:note_file(a:name))
    echo 'Note '.a:name.' deleted'
endfunction
"}}}

" List all persisted notes {{{
function! ctrlp_notebook#list()
	let l:wildignore=&wildignore
	set wildignore=
	let l:notebook_files=split(globpath(s:notebook_path(), "*.py"))
	let l:result=map(l:notebook_files, "fnamemodify(expand(v:val), ':t:r')")
	let &wildignore=l:wildignore
	return l:result
endfunction
"}}}

" Run a note {{{
function! ctrlp_notebook#run()
    exec("Make")
    exec("Copen")
endfunction
"}}}

" Debug a note {{{
function! ctrlp_notebook#debug()
    exec("Start python %")
endfunction
"}}}

