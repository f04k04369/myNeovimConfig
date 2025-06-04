# ✨ Neovim VSCode風開発環境構築ガイド

このリポジトリは、NeovimをVSCode風にカスタマイズするための設定集です。  
以下のような機能を実現します：

- 📁 ファイルツリー表示（`nvim-tree.lua`）
- 💻 ターミナル統合（`toggleterm.nvim`）
- 🤖 自動補完（`nvim-cmp` + `LuaSnip`）
- 🧠 LSP（言語サーバ）対応（`mason.nvim` + `lspconfig`）
- 🔍 ファジーファイル検索（`telescope.nvim`）
- 🎨 ステータスライン（`lualine.nvim`）

---

## 📦 セットアップ手順（Windows版）

### ✅ 1. Neovim をインストール

- [https://github.com/neovim/neovim/releases](https://github.com/neovim/neovim/releases) から最新版の Windows インストーラを取得し、インストールしてください。

### ✅ 2. 必要ディレクトリの作成

PowerShell で以下を実行：

```powershell
mkdir $env:LOCALAPPDATA\nvim
mkdir $env:LOCALAPPDATA\nvim\lua
mkdir $env:LOCALAPPDATA\nvim\lua\plugin_config
mkdir $env:LOCALAPPDATA\nvim\lua\lsp
### ✅ 3. このリポジトリをクローン
```powershell
コピーする
編集する
git clone https://github.com/yourname/nvim-config.git $env:LOCALAPPDATA\nvim
🚀 Neovim 起動後にやること
Neovim を起動：

powershell
コピーする
編集する
nvim
プラグインマネージャ lazy.nvim を初回自動インストール（完了メッセージが出る）

以下のコマンドを実行してLSP関連をインストール：

vim
コピーする
編集する
:Lazy
:Mason
Mason ウィンドウ内で：

i を押すとインストール

インストール推奨LSP：lua-language-server, typescript-language-server, pyright など

🔧 キー操作まとめ（主要機能）
キー	機能
<Space>e	ファイルツリー表示（nvim-tree）
<Ctrl-\>	ターミナル表示（toggleterm）
<Space>w	ファイル保存
<Space>q	ファイル終了
<Ctrl-Space>	補完表示（挿入モード中）
<Tab>/<S-Tab>	補完候補の移動
:LspInfo	LSPの状態確認

🧱 使用している主なプラグイン一覧
プラグイン名	用途
lazy.nvim	プラグイン管理
nvim-tree.lua	ファイルツリー表示
toggleterm.nvim	統合ターミナル
nvim-cmp, LuaSnip	自動補完＆スニペット
mason.nvim, lspconfig	LSPのインストール＆設定
lualine.nvim	ステータスライン
telescope.nvim	ファイル/バッファ/コマンド検索

📝 カスタマイズ例（自分好みに拡張）
lua/plugin_config/ に個別プラグイン設定を追加可能

lua/lsp/servers.lua に対応言語サーバーを追記

lua/keymaps.lua でキーバインド自由自在に変更


