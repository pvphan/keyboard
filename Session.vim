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
badd +2 uart/apitypes.h
badd +179 uart/cmd_def.h
badd +161 uart/example.c
badd +52 ble-1.5.0_src/thermometer-demo/main.c
badd +98 blinky_pjrc/blinky.c
badd +60 uart/Makefile
badd +60 uart/uart.c
badd +178 ble-1.5.0_src/thermometer-demo/uart.c
badd +87 hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
badd +10 hid_over_gatt_keyboard/gatt.xml
badd +1 hid_over_gatt_keyboard/hardware.xml
badd +3 hid_over_gatt_keyboard/project-ble113-m256k.bgproj
badd +2 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +0 uart/ble113_src/gatt.xml
argglobal
silent! argdel *
edit hid_over_gatt_keyboard/gatt.xml
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 25 + 26) / 52)
exe '2resize ' . ((&lines * 24 + 26) / 52)
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
let s:l = 7 - ((6 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 027|
wincmd w
argglobal
edit uart/ble113_src/gatt.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 10 - ((9 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 025|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 25 + 26) / 52)
exe '2resize ' . ((&lines * 24 + 26) / 52)
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
