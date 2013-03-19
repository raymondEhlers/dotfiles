" This scheme was created by CSApproxSnapshot
" on Mon, 18 Mar 2013

hi clear
if exists("syntax_on")
    syntax reset
endif

if v:version < 700
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" substitute(substitute(<q-args>, "undercurl", "underline", "g"), "guisp\\S\\+", "", "g")
else
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" <q-args>
endif

function! s:old_kde()
  " Konsole only used its own palette up til KDE 4.2.0
  if executable('kde4-config') && system('kde4-config --kde-version') =~ '^4.[10].'
    return 1
  elseif executable('kde-config') && system('kde-config --version') =~# 'KDE: 3.'
    return 1
  else
    return 0
  endif
endfunction

if 0
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_konsole") && g:CSApprox_konsole) || (&term =~? "^konsole" && s:old_kde())
    CSAHi Normal term=NONE cterm=NONE ctermbg=59 ctermfg=248 gui=NONE guibg=#333333 guifg=#a8aaaa
    CSAHi cppMinMax term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBitField term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbersCom term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbers term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Statement term=bold cterm=bold ctermbg=bg ctermfg=87 gui=bold guibg=bg guifg=#44ffff
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=37 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Type term=underline cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=63 gui=underline guibg=bg guifg=#4444ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=238 gui=NONE guibg=bg guifg=#444444
    CSAHi Error term=reverse cterm=NONE ctermbg=16 ctermfg=160 gui=NONE guibg=#000000 guifg=#bb0000
    CSAHi Todo term=NONE cterm=NONE ctermbg=124 ctermfg=226 gui=NONE guibg=#aa0006 guifg=#fff300
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=63 gui=NONE guibg=bg guifg=#4444ff
    CSAHi NonText term=bold cterm=bold ctermbg=bg ctermfg=63 gui=bold guibg=bg guifg=#4444ff
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=87 gui=NONE guibg=bg guifg=#44ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=124 ctermfg=231 gui=NONE guibg=#880000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=reverse ctermbg=188 ctermfg=16 gui=reverse guibg=#000000 guifg=#bbcccc
    CSAHi Search term=reverse cterm=NONE ctermbg=bg ctermfg=46 gui=NONE guibg=bg guifg=#00ff00
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=83 gui=bold guibg=bg guifg=#44ff44
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi LineNr term=underline cterm=NONE ctermbg=238 ctermfg=16 gui=NONE guibg=#404040 guifg=#000000
    CSAHi cCppParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cMulti term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=248 ctermfg=16 gui=NONE guibg=#aaaaaa guifg=#000000
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=188 ctermfg=231 gui=NONE guibg=#cccccc guifg=#ffffff
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=NONE ctermbg=231 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=#a9a9a9 guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=102 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=79 gui=NONE guibg=bg guifg=#33cc99
    CSAHi CursorLineNr term=bold cterm=bold ctermbg=188 ctermfg=16 gui=bold guibg=#cccccc guifg=#000000
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=226 gui=bold guibg=bg guifg=#ffff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=37 ctermfg=231 gui=NONE guibg=#00aaaa guifg=#ffffff
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VertSplit term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi Visual term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=226 gui=NONE guibg=bg guifg=#ffff00
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi cCppBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cUserCont term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBadBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=102 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=124 ctermfg=fg gui=NONE guibg=#8b0000 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=83 ctermfg=16 gui=NONE guibg=#44ff44 guifg=#000000
    CSAHi lCursor term=NONE cterm=NONE ctermbg=248 ctermfg=59 gui=NONE guibg=#a8aaaa guifg=#333333
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=37 ctermfg=fg gui=NONE guibg=#008b8b guifg=fg
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=63 gui=NONE guibg=bg guifg=#4444ff
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=37 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=105 gui=bold guibg=bg guifg=#6666ff
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=231 gui=NONE guibg=bg guifg=#ffffff
    CSAHi cCppInIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInSkip term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Folded term=NONE cterm=NONE ctermbg=16 ctermfg=19 gui=NONE guibg=#000000 guifg=#000088
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=19 ctermfg=226 gui=NONE guibg=#080888 guifg=#ffff00
    CSAHi DiffChange term=bold cterm=NONE ctermbg=232 ctermfg=231 gui=NONE guibg=#080808 guifg=#ffffff
    CSAHi DiffDelete term=bold cterm=bold ctermbg=232 ctermfg=238 gui=bold guibg=#080808 guifg=#444444
    CSAHi DiffText term=reverse cterm=bold ctermbg=232 ctermfg=160 gui=bold guibg=#080808 guifg=#bb0000
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=252 gui=NONE guibg=#a9a9a9 guifg=#d3d3d3
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_eterm") && g:CSApprox_eterm) || &term =~? "^eterm"
    CSAHi Normal term=NONE cterm=NONE ctermbg=236 ctermfg=188 gui=NONE guibg=#333333 guifg=#a8aaaa
    CSAHi cppMinMax term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBitField term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbersCom term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbers term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Statement term=bold cterm=bold ctermbg=bg ctermfg=123 gui=bold guibg=bg guifg=#44ffff
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=44 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Type term=underline cterm=bold ctermbg=bg ctermfg=255 gui=bold guibg=bg guifg=#ffffff
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=105 gui=underline guibg=bg guifg=#4444ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=238 gui=NONE guibg=bg guifg=#444444
    CSAHi Error term=reverse cterm=NONE ctermbg=16 ctermfg=160 gui=NONE guibg=#000000 guifg=#bb0000
    CSAHi Todo term=NONE cterm=NONE ctermbg=160 ctermfg=226 gui=NONE guibg=#aa0006 guifg=#fff300
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=105 gui=NONE guibg=bg guifg=#4444ff
    CSAHi NonText term=bold cterm=bold ctermbg=bg ctermfg=105 gui=bold guibg=bg guifg=#4444ff
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=123 gui=NONE guibg=bg guifg=#44ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=124 ctermfg=255 gui=NONE guibg=#880000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=reverse ctermbg=195 ctermfg=16 gui=reverse guibg=#000000 guifg=#bbcccc
    CSAHi Search term=reverse cterm=NONE ctermbg=bg ctermfg=46 gui=NONE guibg=bg guifg=#00ff00
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=120 gui=bold guibg=bg guifg=#44ff44
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=255 gui=bold guibg=bg guifg=#ffffff
    CSAHi LineNr term=underline cterm=NONE ctermbg=238 ctermfg=16 gui=NONE guibg=#404040 guifg=#000000
    CSAHi cCppParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cMulti term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=188 ctermfg=16 gui=NONE guibg=#aaaaaa guifg=#000000
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=252 ctermfg=255 gui=NONE guibg=#cccccc guifg=#ffffff
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=NONE ctermbg=255 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=#a9a9a9 guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=86 gui=NONE guibg=bg guifg=#33cc99
    CSAHi CursorLineNr term=bold cterm=bold ctermbg=252 ctermfg=16 gui=bold guibg=#cccccc guifg=#000000
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=226 gui=bold guibg=bg guifg=#ffff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=44 ctermfg=255 gui=NONE guibg=#00aaaa guifg=#ffffff
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VertSplit term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=255 gui=bold guibg=bg guifg=#ffffff
    CSAHi Visual term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=226 gui=NONE guibg=bg guifg=#ffff00
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi cCppBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cUserCont term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBadBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=124 ctermfg=fg gui=NONE guibg=#8b0000 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=120 ctermfg=16 gui=NONE guibg=#44ff44 guifg=#000000
    CSAHi lCursor term=NONE cterm=NONE ctermbg=188 ctermfg=236 gui=NONE guibg=#a8aaaa guifg=#333333
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=37 ctermfg=fg gui=NONE guibg=#008b8b guifg=fg
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=105 gui=NONE guibg=bg guifg=#4444ff
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=44 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=105 gui=bold guibg=bg guifg=#6666ff
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=255 gui=NONE guibg=bg guifg=#ffffff
    CSAHi cCppInIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInSkip term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Folded term=NONE cterm=NONE ctermbg=16 ctermfg=19 gui=NONE guibg=#000000 guifg=#000088
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=19 ctermfg=226 gui=NONE guibg=#080888 guifg=#ffff00
    CSAHi DiffChange term=bold cterm=NONE ctermbg=232 ctermfg=255 gui=NONE guibg=#080808 guifg=#ffffff
    CSAHi DiffDelete term=bold cterm=bold ctermbg=232 ctermfg=238 gui=bold guibg=#080808 guifg=#444444
    CSAHi DiffText term=reverse cterm=bold ctermbg=232 ctermfg=160 gui=bold guibg=#080808 guifg=#bb0000
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=231 gui=NONE guibg=#a9a9a9 guifg=#d3d3d3
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
elseif has("gui_running") || &t_Co == 256
    CSAHi Normal term=NONE cterm=NONE ctermbg=236 ctermfg=248 gui=NONE guibg=#333333 guifg=#a8aaaa
    CSAHi cppMinMax term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBitField term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbersCom term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbers term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Statement term=bold cterm=bold ctermbg=bg ctermfg=87 gui=bold guibg=bg guifg=#44ffff
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=37 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Type term=underline cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=63 gui=underline guibg=bg guifg=#4444ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=238 gui=NONE guibg=bg guifg=#444444
    CSAHi Error term=reverse cterm=NONE ctermbg=16 ctermfg=124 gui=NONE guibg=#000000 guifg=#bb0000
    CSAHi Todo term=NONE cterm=NONE ctermbg=124 ctermfg=226 gui=NONE guibg=#aa0006 guifg=#fff300
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=63 gui=NONE guibg=bg guifg=#4444ff
    CSAHi NonText term=bold cterm=bold ctermbg=bg ctermfg=63 gui=bold guibg=bg guifg=#4444ff
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=87 gui=NONE guibg=bg guifg=#44ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=88 ctermfg=231 gui=NONE guibg=#880000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=reverse ctermbg=152 ctermfg=16 gui=reverse guibg=#000000 guifg=#bbcccc
    CSAHi Search term=reverse cterm=NONE ctermbg=bg ctermfg=46 gui=NONE guibg=bg guifg=#00ff00
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=83 gui=bold guibg=bg guifg=#44ff44
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi LineNr term=underline cterm=NONE ctermbg=238 ctermfg=16 gui=NONE guibg=#404040 guifg=#000000
    CSAHi cCppParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cMulti term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=201 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=51 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=248 ctermfg=16 gui=NONE guibg=#aaaaaa guifg=#000000
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=252 ctermfg=231 gui=NONE guibg=#cccccc guifg=#ffffff
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=250 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=NONE ctermbg=231 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=#a9a9a9 guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=78 gui=NONE guibg=bg guifg=#33cc99
    CSAHi CursorLineNr term=bold cterm=bold ctermbg=252 ctermfg=16 gui=bold guibg=#cccccc guifg=#000000
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=226 gui=bold guibg=bg guifg=#ffff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=37 ctermfg=231 gui=NONE guibg=#00aaaa guifg=#ffffff
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VertSplit term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=#ffffff
    CSAHi Visual term=reverse cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=226 gui=NONE guibg=bg guifg=#ffff00
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi cCppBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cUserCont term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBadBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=88 ctermfg=fg gui=NONE guibg=#8b0000 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=83 ctermfg=16 gui=NONE guibg=#44ff44 guifg=#000000
    CSAHi lCursor term=NONE cterm=NONE ctermbg=248 ctermfg=236 gui=NONE guibg=#a8aaaa guifg=#333333
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=30 ctermfg=fg gui=NONE guibg=#008b8b guifg=fg
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=63 gui=NONE guibg=bg guifg=#4444ff
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=37 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=63 gui=bold guibg=bg guifg=#6666ff
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=231 gui=NONE guibg=bg guifg=#ffffff
    CSAHi cCppInIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInSkip term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Folded term=NONE cterm=NONE ctermbg=16 ctermfg=18 gui=NONE guibg=#000000 guifg=#000088
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=18 ctermfg=226 gui=NONE guibg=#080888 guifg=#ffff00
    CSAHi DiffChange term=bold cterm=NONE ctermbg=232 ctermfg=231 gui=NONE guibg=#080808 guifg=#ffffff
    CSAHi DiffDelete term=bold cterm=bold ctermbg=232 ctermfg=238 gui=bold guibg=#080808 guifg=#444444
    CSAHi DiffText term=reverse cterm=bold ctermbg=232 ctermfg=124 gui=bold guibg=#080808 guifg=#bb0000
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=252 gui=NONE guibg=#a9a9a9 guifg=#d3d3d3
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=196 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=21 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
elseif has("gui_running") || &t_Co == 88
    CSAHi Normal term=NONE cterm=NONE ctermbg=80 ctermfg=84 gui=NONE guibg=#333333 guifg=#a8aaaa
    CSAHi cppMinMax term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBitField term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbersCom term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cNumbers term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Statement term=bold cterm=bold ctermbg=bg ctermfg=31 gui=bold guibg=bg guifg=#44ffff
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=21 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Type term=underline cterm=bold ctermbg=bg ctermfg=79 gui=bold guibg=bg guifg=#ffffff
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=19 gui=underline guibg=bg guifg=#4444ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=80 gui=NONE guibg=bg guifg=#444444
    CSAHi Error term=reverse cterm=NONE ctermbg=16 ctermfg=48 gui=NONE guibg=#000000 guifg=#bb0000
    CSAHi Todo term=NONE cterm=NONE ctermbg=32 ctermfg=76 gui=NONE guibg=#aa0006 guifg=#fff300
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=19 gui=NONE guibg=bg guifg=#4444ff
    CSAHi NonText term=bold cterm=bold ctermbg=bg ctermfg=19 gui=bold guibg=bg guifg=#4444ff
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=31 gui=NONE guibg=bg guifg=#44ffff
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=32 ctermfg=79 gui=NONE guibg=#880000 guifg=#ffffff
    CSAHi IncSearch term=reverse cterm=reverse ctermbg=58 ctermfg=16 gui=reverse guibg=#000000 guifg=#bbcccc
    CSAHi Search term=reverse cterm=NONE ctermbg=bg ctermfg=28 gui=NONE guibg=bg guifg=#00ff00
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=28 gui=bold guibg=bg guifg=#44ff44
    CSAHi ModeMsg term=bold cterm=bold ctermbg=bg ctermfg=79 gui=bold guibg=bg guifg=#ffffff
    CSAHi LineNr term=underline cterm=NONE ctermbg=80 ctermfg=16 gui=NONE guibg=#404040 guifg=#000000
    CSAHi cCppParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cMulti term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=67 gui=undercurl guibg=bg guifg=fg guisp=#ff00ff
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=31 gui=undercurl guibg=bg guifg=fg guisp=#00ffff
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=84 ctermfg=16 gui=NONE guibg=#aaaaaa guifg=#000000
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=58 ctermfg=79 gui=NONE guibg=#cccccc guifg=#ffffff
    CSAHi PmenuSbar term=NONE cterm=NONE ctermbg=85 ctermfg=fg gui=NONE guibg=#bebebe guifg=fg
    CSAHi PmenuThumb term=NONE cterm=NONE ctermbg=79 ctermfg=fg gui=NONE guibg=#ffffff guifg=fg
    CSAHi TabLine term=underline cterm=underline ctermbg=84 ctermfg=fg gui=underline guibg=#a9a9a9 guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=81 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi Function term=NONE cterm=NONE ctermbg=bg ctermfg=25 gui=NONE guibg=bg guifg=#33cc99
    CSAHi CursorLineNr term=bold cterm=bold ctermbg=58 ctermfg=16 gui=bold guibg=#cccccc guifg=#000000
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=76 gui=bold guibg=bg guifg=#ffff00
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=21 ctermfg=79 gui=NONE guibg=#00aaaa guifg=#ffffff
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=85 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VertSplit term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=79 gui=bold guibg=bg guifg=#ffffff
    CSAHi Visual term=reverse cterm=NONE ctermbg=85 ctermfg=16 gui=NONE guibg=#bbbbbb guifg=#000000
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=76 gui=NONE guibg=bg guifg=#ffff00
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=76 ctermfg=16 gui=NONE guibg=#ffff00 guifg=#000000
    CSAHi cCppBracket term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cUserCont term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cBadBlock term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=81 ctermfg=fg gui=NONE guibg=#666666 guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=32 ctermfg=fg gui=NONE guibg=#8b0000 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=28 ctermfg=16 gui=NONE guibg=#44ff44 guifg=#000000
    CSAHi lCursor term=NONE cterm=NONE ctermbg=84 ctermfg=80 gui=NONE guibg=#a8aaaa guifg=#333333
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=21 ctermfg=fg gui=NONE guibg=#008b8b guifg=fg
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=19 gui=NONE guibg=bg guifg=#4444ff
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=21 gui=NONE guibg=bg guifg=#00aaaa
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=39 gui=bold guibg=bg guifg=#6666ff
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=79 gui=NONE guibg=bg guifg=#ffffff
    CSAHi cCppInIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppOutElse term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi cCppInSkip term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Folded term=NONE cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#000000 guifg=#000088
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=85 ctermfg=31 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=17 ctermfg=76 gui=NONE guibg=#080888 guifg=#ffff00
    CSAHi DiffChange term=bold cterm=NONE ctermbg=16 ctermfg=79 gui=NONE guibg=#080808 guifg=#ffffff
    CSAHi DiffDelete term=bold cterm=bold ctermbg=16 ctermfg=80 gui=bold guibg=#080808 guifg=#444444
    CSAHi DiffText term=reverse cterm=bold ctermbg=16 ctermfg=48 gui=bold guibg=#080808 guifg=#bb0000
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=85 ctermfg=31 gui=NONE guibg=#bebebe guifg=#00ffff
    CSAHi Conceal term=NONE cterm=NONE ctermbg=84 ctermfg=86 gui=NONE guibg=#a9a9a9 guifg=#d3d3d3
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=64 gui=undercurl guibg=bg guifg=fg guisp=#ff0000
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=19 gui=undercurl guibg=bg guifg=fg guisp=#0000ff
endif

if 1
    delcommand CSAHi
endif
