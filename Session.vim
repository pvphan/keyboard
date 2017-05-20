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
badd +75 uart/example.c
badd +34 ble-1.5.0_src/thermometer-demo/main.c
badd +98 blinky_pjrc/blinky.c
badd +60 uart/Makefile
badd +11 uart/uart.c
badd +8 ble-1.5.0_src/thermometer-demo/uart.c
badd +55 hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
badd +46 hid_over_gatt_keyboard/gatt.xml
badd +3 hid_over_gatt_keyboard/hardware.xml
badd +3 hid_over_gatt_keyboard/project-ble113-m256k.bgproj
badd +2 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +28 uart/ble113_src/gatt.xml
badd +11 ble-1.5.0_src/thermometer-demo/stubs.c
badd +1 ble-1.5.0_src/thermometer-demo/uart.h
badd +1 uart/uart.h
badd +6 notes.md
badd +1255 bglib_jrow/Arduino/BGLib.cpp
badd +155 uart/cmd_def.c
badd +149 ble-1.5.0_src/scan_example/main.c
badd +28 tmk_keyboard/tmk_core/common/uart.c
badd +52 tmk_keyboard/tmk_core/common/keyboard.c
badd +632 tmk_keyboard/tmk_core/common/command.c
badd +80 tmk_keyboard/tmk_core/protocol/bluefruit/main.c
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
let s:l = 7 - ((6 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
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
let s:l = 3 - ((2 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3
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
let s:l = 38 - ((15 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
38
normal! 0
wincmd w
exe '1resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe '2resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
exe '3resize ' . ((&lines * 15 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 105 + 105) / 211)
exe '4resize ' . ((&lines * 34 + 26) / 53)
exe 'vert 4resize ' . ((&columns * 105 + 105) / 211)
tabedit uart/example.c
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
let s:l = 15 - ((14 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0
wincmd w
argglobal
edit hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 96 - ((41 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
96
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabedit tmk_keyboard/tmk_core/protocol/bluefruit/main.c
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
let s:l = 97 - ((30 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
97
normal! 021|
wincmd w
argglobal
edit tmk_keyboard/tmk_core/common/keyboard.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 99 - ((24 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
99
normal! 06|
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabnext 3
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
