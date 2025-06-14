# Neovim キーマップ一覧

このドキュメントでは、設定されているすべてのキーマップを機能別にまとめています。各キーマップの由来となるプラグインも記載しています。

## 目次

1. [基本操作](#基本操作)
2. [ファイル操作](#ファイル操作)
3. [検索と置換](#検索と置換)
4. [ナビゲーション](#ナビゲーション)
5. [編集](#編集)
6. [LSP と補完](#lsp-と補完)
7. [デバッグ](#デバッグ)
8. [Git 操作](#git-操作)
9. [セッション管理](#セッション管理)
10. [ウィンドウとバッファ](#ウィンドウとバッファ)
11. [その他](#その他)

## 基本操作

| キー | モード | 説明 |
|------|--------|------|
| `<Space>` | Normal | リーダーキー |
| `<Esc><Esc>` | Normal | ハイライトを消去 |
| `<C-s>` | Normal, Insert | ファイルを保存 |
| `:` | Normal | コマンドモード |
| `<F1>` | Normal | ヘルプを表示 |

## ファイル操作

### Telescope

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>ff` | Normal | ファイル検索 | telescope.nvim |
| `<leader>fg` | Normal | テキスト検索（Live Grep） | telescope.nvim |
| `<leader>fb` | Normal | バッファ一覧 | telescope.nvim |
| `<leader>fh` | Normal | ヘルプタグ検索 | telescope.nvim |
| `<leader>fs` | Normal | ドキュメントシンボル検索 | telescope.nvim + nvim-lspconfig |
| `<leader>fr` | Normal | 参照検索 | telescope.nvim + nvim-lspconfig |
| `<leader>fd` | Normal | 診断一覧 | telescope.nvim + nvim-lspconfig |
| `<leader>fo` | Normal | 最近使用したファイル | telescope.nvim |
| `<leader>fc` | Normal | コマンド一覧 | telescope.nvim |
| `<leader>fk` | Normal | キーマップ一覧 | telescope.nvim |

### ファイルブラウザ

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>fe` | Normal | ファイルブラウザを開く | telescope-file-browser.nvim |
| `-` | Normal | netrw を開く | vim-vinegar |
| `<leader>e` | Normal | NvimTree を開く/閉じる | nvim-tree.lua |

ファイルブラウザ内での操作:
- `N` - 新規ファイル作成 (telescope-file-browser.nvim)
- `h` - 親ディレクトリへ移動 (telescope-file-browser.nvim)
- `/` - フィルター (telescope-file-browser.nvim)

### プロジェクト管理

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>fp` | Normal | プロジェクト一覧 | telescope-project.nvim |

## 検索と置換

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `/` | Normal | 前方検索 | Neovim 標準 |
| `?` | Normal | 後方検索 | Neovim 標準 |
| `*` | Normal | カーソル位置の単語を検索 | Neovim 標準 |
| `#` | Normal | カーソル位置の単語を後方検索 | Neovim 標準 |
| `n` | Normal | 次の検索結果へ | Neovim 標準 |
| `N` | Normal | 前の検索結果へ | Neovim 標準 |
| `<leader>s` | Normal | 検索メニュー | which-key.nvim |
| `<leader>fg` | Normal | プロジェクト全体を検索 | telescope.nvim |

## ナビゲーション

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `gd` | Normal | 定義へジャンプ | nvim-lspconfig |
| `gr` | Normal | 参照へジャンプ | nvim-lspconfig |
| `gi` | Normal | 実装へジャンプ | nvim-lspconfig |
| `<C-o>` | Normal | ジャンプリストを戻る | Neovim 標準 |
| `<C-i>` | Normal | ジャンプリストを進む | Neovim 標準 |
| `<leader><leader>` | Normal | EasyMotion | vim-easymotion |
| `<leader>fp` | Normal | プロジェクト一覧 | telescope-project.nvim |

## 編集

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `gcc` | Normal | 行をコメントアウト/解除 | Comment.nvim |
| `gc` | Visual | 選択範囲をコメントアウト/解除 | Comment.nvim |
| `ys{motion}{char}` | Normal | 囲み文字を追加 | nvim-surround |
| `cs{from}{to}` | Normal | 囲み文字を変更 | nvim-surround |
| `ds{char}` | Normal | 囲み文字を削除 | nvim-surround |
| `<C-n>` | Insert | 補完メニューを開く | nvim-cmp |
| `<Tab>` | Insert | 補完候補を選択/スニペット展開 | nvim-cmp + LuaSnip |
| `<C-j>` | Insert | スニペット内を次へ移動 | LuaSnip |
| `<C-k>` | Insert | スニペット内を前へ移動 | LuaSnip |

## LSP と補完

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `gd` | Normal | 定義へジャンプ | nvim-lspconfig |
| `gr` | Normal | 参照を検索 | nvim-lspconfig |
| `gi` | Normal | 実装へジャンプ | nvim-lspconfig |
| `K` | Normal | ホバー情報を表示 | nvim-lspconfig |
| `<leader>lr` | Normal | シンボルをリネーム | nvim-lspconfig |
| `<leader>la` | Normal | コードアクション | nvim-lspconfig |
| `<leader>lf` | Normal | ドキュメントをフォーマット | conform.nvim |
| `<leader>ld` | Normal | 診断情報を表示 | nvim-lspconfig |
| `[d` | Normal | 前の診断へ移動 | nvim-lspconfig |
| `]d` | Normal | 次の診断へ移動 | nvim-lspconfig |
| `<leader>lq` | Normal | 診断リストを表示 | trouble.nvim |
| `<leader>ls` | Normal | ドキュメントシンボルを検索 | telescope.nvim + nvim-lspconfig |
| `<leader>lw` | Normal | ワークスペースシンボルを検索 | telescope.nvim + nvim-lspconfig |

## デバッグ

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<F5>` | Normal | デバッグ実行/続行 | nvim-dap |
| `<F10>` | Normal | ステップオーバー | nvim-dap |
| `<F11>` | Normal | ステップイン | nvim-dap |
| `<F12>` | Normal | ステップアウト | nvim-dap |
| `<leader>db` | Normal | ブレークポイント切替 | nvim-dap |
| `<leader>dB` | Normal | 条件付きブレークポイント設定 | nvim-dap |
| `<leader>dl` | Normal | ログポイント設定 | nvim-dap |
| `<leader>dr` | Normal | REPL を開く | nvim-dap |
| `<leader>du` | Normal | デバッグ UI 切替 | nvim-dap-ui |
| `<leader>dc` | Normal | 続行 | nvim-dap |
| `<leader>dn` | Normal | ステップオーバー | nvim-dap |
| `<leader>ds` | Normal | ステップイン | nvim-dap |
| `<leader>do` | Normal | ステップアウト | nvim-dap |
| `<leader>dt` | Normal | 終了 | nvim-dap |
| `<leader>dw` | Normal | ウィジェット表示 | nvim-dap-ui |

## Git 操作

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>gs` | Normal | Git ステータス | vim-fugitive |
| `<leader>gc` | Normal | Git コミット | vim-fugitive |
| `<leader>gp` | Normal | Git プッシュ | vim-fugitive |
| `<leader>gl` | Normal | Git ログ | vim-fugitive |
| `<leader>gd` | Normal | Git diff | vim-fugitive |
| `<leader>gb` | Normal | Git blame | vim-fugitive |
| `]c` | Normal | 次の変更へ移動 | gitsigns.nvim |
| `[c` | Normal | 前の変更へ移動 | gitsigns.nvim |
| `<leader>gh` | Normal | 変更をプレビュー | gitsigns.nvim |
| `<leader>gu` | Normal | 変更を元に戻す | gitsigns.nvim |
| `<leader>gs` | Normal | ステージ/アンステージ | gitsigns.nvim |

## セッション管理

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>ss` | Normal | セッション一覧表示 | possession.nvim |
| `<leader>sn` | Normal | 新規セッション作成 | possession.nvim |
| `<leader>sl` | Normal | セッション読み込み | possession.nvim |
| `<leader>sd` | Normal | セッション削除 | possession.nvim |

## ウィンドウとバッファ

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<C-w>s` | Normal | 水平分割 | Neovim 標準 |
| `<C-w>v` | Normal | 垂直分割 | Neovim 標準 |
| `<C-w>h/j/k/l` | Normal | ウィンドウ間を移動 | Neovim 標準 |
| `<C-w>H/J/K/L` | Normal | ウィンドウを移動 | Neovim 標準 |
| `<C-w>+/-` | Normal | ウィンドウサイズ変更 | Neovim 標準 |
| `<C-w>=` | Normal | ウィンドウサイズを均等に | Neovim 標準 |
| `<C-w>_` | Normal | ウィンドウを最大高さに | Neovim 標準 |
| `<C-w>\|` | Normal | ウィンドウを最大幅に | Neovim 標準 |
| `<leader>bd` | Normal | バッファを閉じる | which-key.nvim |
| `<leader>bn` | Normal | 次のバッファへ | bufferline.nvim |
| `<leader>bp` | Normal | 前のバッファへ | bufferline.nvim |
| `<leader>bl` | Normal | バッファ一覧 | telescope.nvim |

## その他

| キー | モード | 説明 | プラグイン |
|------|--------|------|------------|
| `<leader>t` | Normal | トグルメニュー | which-key.nvim |
| `<leader>th` | Normal | ハイライトを切替 | Neovim 標準 |
| `<leader>tn` | Normal | 行番号表示を切替 | Neovim 標準 |
| `<leader>tw` | Normal | 折り返し表示を切替 | Neovim 標準 |
| `<leader>tc` | Normal | カーソルラインを切替 | Neovim 標準 |
| `<leader>ts` | Normal | スペルチェックを切替 | Neovim 標準 |
| `<leader>tt` | Normal | ターミナルを開く | Neovim 標準 |
| `<leader>x` | Normal | 診断/クイックフィックスメニュー | trouble.nvim |
| `<leader>z` | Normal | Zen モードを切替 | zen-mode.nvim |

## コマンド一覧

| コマンド | 説明 |
|---------|------|
| `:UpdatePlugins` | プラグインを更新 |
| `:Mason` | LSP サーバー管理を開く |
| `:Telescope` | Telescope を開く |
| `:NvimTreeToggle` | ファイルエクスプローラーを切替 |
| `:Format` | ファイルをフォーマット |
| `:LspInfo` | LSP 情報を表示 |
| `:LspRestart` | LSP サーバーを再起動 |
| `:PossessionSave` | セッションを保存 |
| `:PossessionLoad` | セッションを読み込み |
| `:PossessionDelete` | セッションを削除 |
| `:PossessionList` | セッション一覧を表示 |
| `:PossessionShow` | 現在のセッション情報を表示 |
