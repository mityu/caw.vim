" vim:foldmethod=marker:fen:
scriptencoding utf-8

let s:Vim9context = vital#caw#import('Vim.Vim9context')
function! s:get_oneline_comment(_) abort
  let context = caw#context()
  let col = 1
  if context.action ==# 'dollarpos'
    let col = col([context.firstline, '$'])
  endif

  if s:Vim9context.get_context_pos(context.firstline, col) ==
        \ s:Vim9context.context().vim9_script
    return '#'
  endif
  return '"'
endfunction

let b:caw_oneline_comment = funcref('s:get_oneline_comment')
function! s:linecont_sp(lnum) abort
  return getline(a:lnum) =~# '^\s*\\' ? '' : ' '
endfunction
let b:caw_hatpos_sp = function('s:linecont_sp')
let b:caw_zeropos_sp = b:caw_hatpos_sp
let b:caw_hatpos_ignore_syngroup = 1
let b:caw_zeropos_ignore_syngroup = 1

if !exists('b:did_caw_ftplugin')
  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= ' | '
  else
    let b:undo_ftplugin = ''
  endif
  let b:undo_ftplugin .= 'unlet! b:caw_oneline_comment b:caw_wrap_oneline_comment b:caw_wrap_multiline_comment b:did_caw_ftplugin'
  let b:did_caw_ftplugin = 1
endif
