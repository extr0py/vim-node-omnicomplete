" Start.vim
" Entry point for the vim-electrify plugin

if exists("g:loaded_vim_node_plugins") 
    finish
endif

if !has("clientserver")
    echom "vim-electrify requires +clientserver"
    finish
endif

if !has("python")
    echom "vim-electrify requires python"
    finish
endif

if !exists("g:electrify_nodejs_enabled")
    let g:electrify_nodejs_enabled = 1
endif

let g:electrify_nodeplugins_debugmode = 0

augroup ElectrifyBufferUpdates
    autocmd! CursorHold * :call electrify#js#notifyBufferUpdated()
    autocmd! CursorHoldI * :call electrify#js#notifyBufferUpdated()
    autocmd! InsertEnter * :call electrify#js#notifyBufferUpdated()
    autocmd! InsertChange * :call electrify#js#notifyBufferUpdated()
    autocmd! InsertLeave * :call electrify#js#notifyBufferUpdated()
    autocmd! CursorMoved * :call electrify#js#notifyBufferUpdated()
    autocmd! CursorMovedI * :call electrify#js#notifyBufferUpdated()
augroup END

augroup ElectrifyEventListeners
    autocmd!
    autocmd! BufEnter * :call electrify#js#notifyBufferEvent("BufEnter")
    autocmd! VimLeave * :call electrify#js#notifyBufferEvent("VimLeave")
    autocmd! CursorMoved * :call electrify#js#notifyBufferEvent("CursorMoved")
    autocmd! CursorMovedI * :call electrify#js#notifyBufferEvent("CursorMovedI")
augroup END

augroup ElectrifyLifecycleListeners
    autocmd!
    autocmd! CursorHold * :call electrify#command#flushIncomingCommands()
    autocmd! CursorMoved * :call electrify#command#flushIncomingCommands()
    autocmd! CursorHoldI * :call electrify#command#flushIncomingCommands()
    autocmd! CursorMovedI * :call electrify#command#flushIncomingCommands()
    autocmd! VimLeave * :call electrify#js#disconnectTcp()
augroup END

call electrify#js#start()
call electrify#omnicomplete#initializeCompletion()
call electrify#command#startWatcher()
