syntax on
" autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
:set background=dark
:set vb t_vb=
set nojoinspaces
set encoding=utf-8
set wrapmargin=1
set mouse=h
set fo=ltc
set ruler
set nohlsearch
set ai ic
map KK i<C-R>=strftime("%Y.%m.%d")<CR><CR>
map K^ :,$s/^/> /''
map K& :,$s/^> \?//''
map KA :set noai noic
map KB :set ai ic
map K1 :pu s1G"spWifyi - oBcc: m/j/^Subject:
map KC "md`m
map KD "md'm
map KE F<yf>Pls </hhi
map KF :+,$!msfold''
map KG 70| 
map KJ 76|F 
map KH 71|F 
map KN :w:nn
map KI "mP
map KP "mp
map KR :'m,.!
map KT :e#
map KV :+,$!mime''
map KW :w
map KX :e xG"mp
map KY m'"my'm''
map KL /^........................................................................./
map KO :/^Date:/co'z:s/[^0-9]*\([^-+]*\).*/\1/:/^From:/m'z:s/$/,/J:.g/:[^<]*<\([^>]*\)>/s//: \1/
