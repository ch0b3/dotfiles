set number

" --------------------
" 検索
" --------------------

" 検索するときに大文字小文字を区別しない
set ignorecase

" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch

" 検索結果をハイライト表示
set hlsearch

" --------------------
" 表示設定
" --------------------

" シンタックスハイライトの有効化
syntax enable

" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells

" 対応する括弧やブレースを表示
set showmatch matchtime=1

" 不可視文字を可視化
set list
set listchars=tab:>.,trail:-,eol:↲,extends:>,precedes:<,nbsp:%

" コメントの色を変更
hi Comment ctermfg=6

" 対応する括弧を強調表示
set showmatch

" 現在の行を強調表示
set cursorline

" 現在の行を強調表示（縦）
set cursorcolumn
