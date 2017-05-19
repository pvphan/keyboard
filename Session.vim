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
badd +90 uart/example.c
badd +186 ble-1.5.0_src/thermometer-demo/main.c
badd +98 blinky_pjrc/blinky.c
badd +60 uart/Makefile
badd +11 uart/uart.c
badd +8 ble-1.5.0_src/thermometer-demo/uart.c
badd +15 hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
badd +16 hid_over_gatt_keyboard/gatt.xml
badd +1 hid_over_gatt_keyboard/hardware.xml
badd +3 hid_over_gatt_keyboard/project-ble113-m256k.bgproj
badd +2 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +21 uart/ble113_src/gatt.xml
badd +11 ble-1.5.0_src/thermometer-demo/stubs.c
badd +0 ble-1.5.0_src/thermometer-demo/uart.h
badd +0 uart/uart.h
argglobal
silent! argdel *
set stal=2
edit uart/uart.h
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe '3resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
exe '4resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 4resize ' . ((&columns * 105 + 105) / 211)
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
let s:l = 9 - ((8 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 027|
wincmd w
argglobal
edit uart/uart.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 52 - ((13 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
52
normal! 0
wincmd w
argglobal
edit ble-1.5.0_src/thermometer-demo/uart.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 3 - ((2 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3
normal! 0
wincmd w
argglobal
edit ble-1.5.0_src/thermometer-demo/uart.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 193 - ((13 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
193
normal! 09|
wincmd w
exe '1resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe '3resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
exe '4resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 4resize ' . ((&columns * 105 + 105) / 211)
tabedit uart/ble113_src/gatt.xml
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
let s:l = 100 - ((24 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
100
normal! 031|
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
