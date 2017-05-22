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
badd +34 ble-1.5.0_src/thermometer-demo/main.c
badd +98 blinky_pjrc/blinky.c
badd +60 uart/Makefile
badd +46 uart/uart.c
badd +52 ble-1.5.0_src/thermometer-demo/uart.c
badd +41 hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
badd +91 hid_over_gatt_keyboard/gatt.xml
badd +3 hid_over_gatt_keyboard/hardware.xml
badd +3 hid_over_gatt_keyboard/project-ble113-m256k.bgproj
badd +2 bglib_jrow/BLEFirmware/BGLib_U1A1P_38400_noflow/project-ble113-m256k.bgproj
badd +28 uart/ble113_src/gatt.xml
badd +11 ble-1.5.0_src/thermometer-demo/stubs.c
badd +3 ble-1.5.0_src/thermometer-demo/uart.h
badd +8 uart/uart.h
badd +6 notes.md
badd +1033 bglib_jrow/Arduino/BGLib.cpp
badd +155 uart/cmd_def.c
badd +149 ble-1.5.0_src/scan_example/main.c
badd +28 tmk_keyboard/tmk_core/common/uart.c
badd +123 tmk_keyboard/tmk_core/common/keyboard.c
badd +632 tmk_keyboard/tmk_core/common/command.c
badd +78 tmk_keyboard/tmk_core/protocol/bluefruit/main.c
badd +72 ble60_main/Makefile
badd +1 main.c
badd +13 ble60_main/main.c
badd +1 ble60_main/uart.h
badd +1 ble60_main/uart.c
badd +346 ble60_main/usb_debug_only.c
badd +28 tmk_keyboard/tmk_core/common/matrix.h
badd +62 tmk_keyboard/keyboard/gh60/matrix.c
badd +417 ble60_main/cmd_def.c
badd +7 ble60_main/cmd_def.h
badd +1394 bglib_jrow/Arduino/BGLib.h
badd +124 bglib_jrow/Arduino/BGLibConfig.h
badd +1 ble60_main/commands.c
badd +166 ble60_main/bglib_ugly.c
badd +3 ble60_main/bglib_ugly.h
argglobal
silent! argdel *
set stal=2
edit ble60_main/main.c
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
let s:l = 66 - ((26 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
66
normal! 0
wincmd w
argglobal
edit ble60_main/uart.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 100 - ((48 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
100
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabedit ble60_main/bglib_ugly.h
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
let s:l = 10 - ((9 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 0
wincmd w
argglobal
edit ble60_main/bglib_ugly.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 191 - ((15 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
191
normal! 0
wincmd w
argglobal
edit ble60_main/uart.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit ble60_main/uart.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 126 - ((33 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
126
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
tabnext 1
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
