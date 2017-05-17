let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/keyboard
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +6 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +9 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/hardware_usb.xml
badd +5 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/hardware_nousb.xml
badd +13 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/gatt.xml
badd +0 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/
badd +10 notes.md
argglobal
silent! argdel *
argadd bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/
edit bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 10 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 40 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 7 - ((6 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 0
wincmd w
argglobal
edit notes.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 8 - ((7 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 05|
wincmd w
argglobal
edit bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/gatt.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 13 - ((12 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 09|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 10 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 40 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
