" ctrlp_notebook.vim - Ctrlp extension to manage notes and code snippets.
" Maintainer:         Pascal Lalancette
" Version:            1.0

" Location of notebook files
let g:ctrlp_notebook_path="~/.vim_notebooks"

function! s:CtrlPNotebook()
	if !exists(":CtrlP")
        echohl WarningMsg
		echomsg "Error: CtrlP not installed."
        echohl None
		return
	endif
    call ctrlp#init(ctrlp#ctrlp_notebook#id())
endfunction

command! -nargs=1 Note call ctrlp_notebook#create(<f-args>)
command! -nargs=1 NOpen call ctrlp_notebook#open(<f-args>)
command! -nargs=1 NDelete call ctrlp_notebook#delete(<f-args>)
command! -nargs=0 NRun call ctrlp_notebook#run()
command! -nargs=0 NList echo join(ctrlp_notebook#list(), ", ")
command! -nargs=0 CtrlPNotebook call s:CtrlPNotebook()
