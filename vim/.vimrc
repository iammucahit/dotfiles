let mapleader = " "
set nu
set wrap
set linebreak
set mouse=a
:colorscheme habamax
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
let g:netrw_banner = 0

" Enable Windows clipboard support in WSL Vim using win32yank
if system('uname -r') =~ 'microsoft' " We're inside WSL
  let g:win32yank_path = expand('~/.local/bin/win32yank.exe')

  if executable(g:win32yank_path)
    " Press leader+y to send current yank to Windows
    nnoremap <leader>y :call system(g:win32yank_path . ' -i', getreg('"'))<CR>
    vnoremap <leader>y "qy:call system(g:win32yank_path . ' -i', getreg('q'))<CR>

    " Press leader+p to pull from Windows and paste
    nnoremap <leader>p :call setreg('"', system(g:win32yank_path . ' -o'))<CR>p
  endif
endif

" Disable arrow keys in normal, insert, and visual mode aka hardmode
function! HardMode()
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    execute 'noremap ' . key . ' <NOP>'
    execute 'inoremap ' . key . ' <NOP>'
    execute 'vnoremap ' . key . ' <NOP>'
  endfor
endfunction

call HardMode()
