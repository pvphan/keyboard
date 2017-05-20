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
badd +25 hid_over_gatt_keyboard/hid_over_gatt_keyboard.bgs
badd +46 hid_over_gatt_keyboard/gatt.xml
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
badd +124 tmk_keyboard/tmk_core/common/keyboard.c
badd +632 tmk_keyboard/tmk_core/common/command.c
badd +1 tmk_keyboard/tmk_core/protocol/bluefruit/main.c
badd +51 ble60_main/Makefile
badd +1 main.c
badd +118 ble60_main/main.c
badd +11 ble60_main/uart.h
badd +98 ble60_main/uart.c
badd +346 ble60_main/usb_debug_only.c
badd +28 tmk_keyboard/tmk_core/common/matrix.h
badd +62 tmk_keyboard/keyboard/gh60/matrix.c
badd +422 ble60_main/cmd_def.c
badd +2394 ble60_main/cmd_def.h
badd +1394 bglib_jrow/Arduino/BGLib.h
badd +124 bglib_jrow/Arduino/BGLibConfig.h
badd +0 ble60_main/commands.c
argglobal
silent! argdel *
set stal=2
edit ble60_main/uart.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 100 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 110 + 105) / 211)
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
let s:l = 41 - ((16 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 09|
wincmd w
argglobal
edit bglib_jrow/Arduino/BGLib.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 81 - ((6 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
81
normal! 05|
wincmd w
exe 'vert 1resize ' . ((&columns * 100 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 110 + 105) / 211)
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
let s:l = 80 - ((38 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
80
normal! 08|
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
let s:l = 123 - ((23 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
123
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 105) / 211)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 211)
tabedit ble60_main/main.c
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
let s:l = 129 - ((25 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
129
normal! 05|
wincmd w
argglobal
edit ble60_main/commands.c
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 458 - ((26 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
458
normal! 014|
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
