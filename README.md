# Neovim for Flutter Development: Setup Guide

Neovim (v0.8以降) を使って、軽量かつモダンでパワフルなFlutter開発環境を構築するためのガイドです。
lazy.nvimをプラグインマネージャとして使用し、LSP、自動補完、Flutterホットリロードなどの必須機能を統合します。

---

## ✨ 主な機能
- **賢いコード補完**: nvim-cmpとdartlsによる文脈に応じた強力な補完
- **LSP連携**: エラーチェック、定義ジャンプ、ホバー表示などのIDEライクな機能
- **Flutterホットリロード**: `:FlutterReload` コマンドでNeovimを離れずにホットリロード/リスタート
- **ファイルツリー**: NvimTreeによるサイドバーでのファイル操作
- **高速なファイル検索**: Telescopeによるファジーファインダー
- **見やすいUI**: tokyonightテーマとインデントの可視化

---

## ⚙️ 前提条件
この設定を始める前に、以下のソフトウェアがインストールされていることを確認してください。

- Neovim (v0.8以上)
- Git
- Flutter SDK

ターミナルで `flutter doctor` を実行し、Flutterの項目に大きな問題がないことを確認してください。

---

## 🚀 インストール手順

### 1. 設定ファイルのバックアップ
既存のNeovim設定がある場合は、バックアップを取っておきましょう。

```bash
# Linux/macOS
mv ~/.config/nvim ~/.config/nvim.bak

# Windows
move %USERPROFILE%\AppData\Local\nvim %USERPROFILE%\AppData\Local\nvim.bak
```

### 2. 設定ファイルの配置
以下のファイル構造を `~/.config/nvim/`（Windowsの場合は `%USERPROFILE%\AppData\Local\nvim\`）の配下に作成し、各ファイルを配置します。

```
nvim
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua
    │   └── keymaps.lua
    └── plugins/
        ├── init.lua
        ├── cmp.lua
        ├── flutter-tools.lua
        ├── nvim-lspconfig.lua
        ├── nvim-tree.lua
        ├── telescope.lua
        └── theme.lua
```

### 3. 各設定ファイルの内容
各ファイルの内容を下記に記載しています。コピーして対応するファイルに貼り付けてください。

<details>
<summary>init.lua</summary>

```lua
-- nvim/init.lua
require("core.options")
require("core.keymaps")
require("plugins")
```
</details>

<details>
<summary>lua/core/options.lua</summary>

```lua
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.scrolloff = 8
opt.undofile = true
opt.swapfile = false
opt.backup = false
```
</details>

<details>
<summary>lua/core/keymaps.lua</summary>

```lua
local map = vim.keymap.set
map("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
```
</details>

<details>
<summary>lua/plugins/init.lua</summary>

```lua
-- nvim/lua/plugins/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "plugins.theme",
  "plugins.nvim-lspconfig",
  "plugins.cmp",
  "plugins.flutter-tools",
  "plugins.telescope",
  "plugins.nvim-tree",
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        direction = "horizontal",
        size = 15,
    }
  },
})
```
</details>

<details>
<summary>lua/plugins/nvim-lspconfig.lua</summary>

```lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc })
      end
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "gr", require("telescope.builtin").lsp_references, "Go to References")
    end
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "dartls" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      },
    })
  end,
}
```
</details>

<details>
<summary>lua/plugins/cmp.lua</summary>

```lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
```
</details>

<details>
<summary>lua/plugins/flutter-tools.lua</summary>

```lua
return {
  "akinsho/flutter-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  config = function()
    require("flutter-tools").setup({
      lsp = {
        color = {
          enabled = true,
        },
      },
    })
    local map = vim.keymap.set
    map("n", "<leader>r", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
    map("n", "<leader>R", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
    map("n", "<leader>q", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
    map("n", "<leader>d", "<cmd>FlutterDevices<cr>", { desc = "Flutter Devices" })
  end,
}
```
</details>

<details>
<summary>lua/plugins/nvim-tree.lua</summary>

```lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
    })
  end,
}
```
</details>

<details>
<summary>lua/plugins/telescope.lua</summary>

```lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- Your default settings go here
      },
    })
  end,
}
```
</details>

<details>
<summary>lua/plugins/theme.lua</summary>

```lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "tokyonight"
  end,
}
```
</details>

---

### 4. 起動とプラグインインストール
すべてのファイルを配置したら、Neovimを起動します。

```bash
nvim
```

lazy.nvimが自動的に起動し、足りないプラグインをすべてインストールします。初回起動時は少し時間がかかります。
インストール完了後、Neovimを再起動すれば環境の構築は完了です。

---

## 🎮 主な操作方法

| 機能             | キーマップ/コマンド         | 説明                                      |
|------------------|-----------------------------|-------------------------------------------|
| ファイルツリー    | `<C-n>`                     | NvimTreeの表示/非表示を切り替えます       |
| ファイル検索      | `<leader>ff` (Space + f + f)| Telescopeでプロジェクト内のファイル検索    |
| 全文検索         | `<leader>fg` (Space + f + g)| Telescopeでプロジェクト内を全文検索        |
| ターミナル        | `<C-\>`                     | ToggleTermでターミナルを開閉               |
| ホットリロード    | `<leader>r` (Space + r)     | Flutterアプリをホットリロード              |
| ホットリスタート  | `<leader>R` (Space + R)     | Flutterアプリをホットリスタート            |
| デバイス一覧      | `:FlutterDevices`           | 利用可能なデバイスの一覧を表示             |
| アプリ実行        | `:FlutterRun`               | Flutterアプリを実行                        |
| 定義へジャンプ    | `gd`                        | 変数や関数の定義元へジャンプ               |
| ドキュメント表示  | `K`                         | カーソル下の要素のドキュメントを表示        |
| 補完候補の選択    | `<C-j>` / `<C-k>`           | 補完メニューで候補を上下に選択             |
| 補完候補の確定    | `<CR>` (Enter)              | 選択した補完候補で確定                      |

---

## ⚠️ トラブルシューティング

> **Q: コード補完や定義ジャンプが機能しない**
> - LSPサーバー(dartls)が起動しているか確認します。
> - `.dart`ファイルを開いた状態でコマンド `:LspInfo` を実行。
> - dartlsが `1 client(s) attached` と表示されていれば正常です。
> - 表示されていない場合、コマンド `:Mason` を開き、dartlsがインストール済み（✅マーク）か確認。されていなければ `i` キーでインストール。

> **Q: dartlsがMasonで見つからない、またはLSPが起動しない**
> - `flutter doctor` コマンドを実行し、Flutter/Dartの環境に問題がないか確認。
> - 複数のDart SDKがインストールされている場合、Flutter付属のものではないSDKのパスが優先されているとこの問題が発生します。
> - システムの環境変数PATHを正しく設定してください。

> **Q: なんだか動作がおかしい**
> - プラグインのキャッシュが原因かもしれません。以下の手順でキャッシュをクリアしてください。
>   1. Neovimを終了
>   2. nvim-dataフォルダ（Windows: `%USERPROFILE%\AppData\Local\nvim-data`、Linux/macOS: `~/.local/share/nvim`）の中にある `lazy` や `mason` フォルダを削除
>   3. Neovimを再起動すると、プラグインが再インストールされクリーンな状態になります。

---

> このREADMEをコピーして `README.md` として保存すれば、誰でも同じ環境を再現できます。

---

## ⚡️ 追加機能の使い方

### ⌨️ 入力効率化 (Input Efficiency)

- **自動括弧閉じ (nvim-autopairs)**
  - `(` や `"` などを入力すると、自動で閉じ括弧が入力されます。

- **囲み文字操作 (nvim-surround)**
  - `ys<motion><char>`: 囲み文字を追加 (例: `ysiw"` で単語を `"` で囲む)
  - `ds<char>`: 囲み文字を削除 (例: `ds"` で `"` を削除)
  - `cs<char_old><char_new>`: 囲み文字を変更 (例: `cs"'` で `"` を `'` に変更)

- **高速ジャンプ (flash.nvim)**
  - `s`: 画面内の検索モードを起動。2文字入力すると、ジャンプ先のラベルが表示されます。表示されたキーを押すとその位置にジャンプします。

### 🎨 UI改善 (UI Enhancements)

- **Git状態表示 (gitsigns.nvim)**
  - 行番号の左側に、Gitの状態が文字（A, M, D, Uなど）で表示されます。
  - **ファイルエクスプローラー (nvim-tree)**
    - ファイル名がGitの状態に応じて色分けされ、アイコンもA, M, Uなどで表示されます。

- **バッファタブ (bufferline.nvim)**
  - 画面上部に、現在開いているファイル（バッファ）がタブのように表示されます。

- **リッチな通知 (noice.nvim)**
  - コマンドラインが画面中央にフロート表示され、通知も右上にリッチなUIで表示されます。

- **キーバインドヘルパー (which-key.nvim)**
  - スペースキーなどのプレフィックスキーを押して少し待つと、利用可能なキーバインドの一覧がポップアップ表示されます。
  - 何を押せばいいか迷ったときに便利です。

### ⌨️ キーマップの追加 (Extra Keymaps)

- **Insertモードからの脱出**
  - `jk`: Insertモード中に素早く `jk` と入力すると、`<Esc>` と同様にNormalモードに戻ります。

### 🧹 自動フォーマット (Formatting)

- **conform.nvim**
  - ファイル保存時に自動的にフォーマットが実行されます。
  - 対応言語: JavaScript, TypeScript, React, CSS, HTML, JSON, Markdown (Prettierを使用)

### ⚛️ Next.js / React 開発

- **LSPサポート**
  - `.tsx` や `.ts` ファイルを開くと、`ts_ls` (TypeScript) と `eslint` が自動的に起動します。
  - Tailwind CSSを使用している場合、`tailwindcss` サーバーも起動し、クラス名の補完が効きます。
