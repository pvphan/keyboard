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
badd +3 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +3 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/hardware_usb.xml
badd +7 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/hardware_nousb.xml
badd +3 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/gatt.xml
badd +1 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/
badd +1 notes.md
badd +1 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/cdc.xml
badd +7 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble112.bgproj
badd +31 bglib_jrow/Arduino/BGLib.h
badd +1032 bglib_jrow/Arduino/BGLib.cpp
badd +233 bglib_jrow/Arduino/BGLibConfig.h
badd +19 uart/example.c
badd +450 uart/Makefile
argglobal
silent! argdel *
argadd bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/
set stal=2
edit bglib_jrow/Arduino/BGLib.cpp
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
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
let s:l = 1033 - ((25 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1033
normal! 0
tabedit bglib_jrow/Arduino/BGLib.cpp
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
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
let s:l = 1034 - ((23 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1034
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
let s:l = 8 - ((7 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabnext 2
set stal=1
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
