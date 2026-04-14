---
updated: 2026-04-14 11:58
---

# 🚀 My Neovim Configuration

モダンでパワフルなNeovim開発環境です。**Flutter**、**Next.js/React**、**TypeScript**などの開発に最適化されています。

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

---

## 📦 ディレクトリ構成

```
nvim/
├── init.lua                    # エントリーポイント
├── lazy-lock.json              # プラグインバージョンロック
└── lua/
    ├── core/
    │   ├── options.lua         # Neovimの基本設定
    │   └── keymaps.lua         # キーマップ設定
    ├── plugins/
    │   ├── init.lua            # プラグイン管理 (lazy.nvim)
    │   ├── cmp.lua             # 自動補完設定
    │   ├── efficiency.lua      # 効率化プラグイン
    │   ├── flutter-tools.lua   # Flutter開発ツール
    │   ├── formatting.lua      # 自動フォーマット
    │   ├── nvim-lspconfig.lua  # LSP設定
    │   ├── nvim-tree.lua       # ファイルエクスプローラー
    │   ├── telescope.lua       # ファジーファインダー
    │   ├── theme.lua           # テーマ設定
    │   ├── treesitter.lua      # 構文解析
    │   └── ui_enhancements.lua # UI改善
    └── snippets/
        └── init.lua            # カスタムスニペット
```

---

## ✨ 主な機能

| カテゴリ | 機能 |
|---------|------|
| 🎨 **UI** | tokyonightテーマ、バッファタブ、リッチな通知、インデント可視化 |
| 📝 **補完** | LSP補完、スニペット、括弧自動補完 |
| 🔍 **検索** | ファイル検索、全文検索、高速ジャンプ |
| 🧹 **整形** | 保存時自動フォーマット (Prettier) |
| 🌲 **構文** | Treesitterによるシンタックスハイライト |
| 📂 **ファイル** | サイドバーファイルツリー、Git状態表示 |
| 💻 **ターミナル** | 内蔵ターミナル |
| ⚛️ **Flutter** | ホットリロード、デバイス管理 |
| ⚛️ **React/Next.js** | TypeScript LSP、便利なスニペット |

---

## ⚙️ 前提条件

- **Neovim** v0.9以上
- **Git**
- **Node.js** (Prettierやts_lsに必要)
- **ripgrep** (Telescope全文検索に必要)

```bash
# macOS
brew install neovim ripgrep node

# Ubuntu/Debian
sudo apt install neovim ripgrep nodejs npm
```

Flutter開発を行う場合は **Flutter SDK** も必要です。

---

## 🛠️ インストール

### 1. 既存設定のバックアップ

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

### 2. この設定をクローン

```bash
git clone https://github.com/YOUR_USERNAME/nvim.git ~/.config/nvim
```

### 3. Neovimを起動

```bash
nvim
```

初回起動時に **lazy.nvim** が自動的にプラグインをインストール。

### 4. LSPサーバーのインストール

Neovim内で `:Mason` を実行し、必要なLSPサーバーをインストール:

| 言語 | サーバー |
|------|---------|
| Lua | `lua_ls` |
| Dart/Flutter | `dartls` |
| TypeScript/JavaScript | `ts_ls` |
| ESLint | `eslint` |
| Tailwind CSS | `tailwindcss` |

---

## 🎮 キーマップ一覧

> **リーダーキー**: `Space`

### 基本操作

| キー | 説明 |
|------|------|
| `jk` | インサートモード → ノーマルモード |
| `Ctrl + n` | ファイルツリーの表示/非表示 |
| `Ctrl + \` | ターミナルの表示/非表示 |

### ファイル操作 (Telescope)

| キー | 説明 |
|------|------|
| `Space` `f` `f` | ファイル検索 |
| `Space` `f` `g` | 全文検索 (grep) |
| `Space` `f` `b` | バッファ一覧 |

### LSP操作

| キー | 説明 |
|------|------|
| `gd` | 定義へジャンプ |
| `gi` | 実装へジャンプ |
| `gr` | 参照一覧を表示 |
| `K` | ドキュメントを表示 |
| `Space` `r` `n` | 名前変更 (リネーム) |
| `Space` `c` `a` | コードアクション |

### 補完操作

| キー | 説明 |
|------|------|
| `Ctrl + j` | 次の候補を選択 |
| `Ctrl + k` | 前の候補を選択 |
| `Ctrl + Space` | 補完を強制表示 |
| `Enter` | 補完を確定 |
| `Tab` | スニペット展開 / 次のプレースホルダー |
| `Shift + Tab` | 前のプレースホルダー |

### Flutter操作

| キー | 説明 |
|------|------|
| `Space` `r` | ホットリロード |
| `Space` `R` | ホットリスタート |
| `Space` `q` | アプリ終了 |
| `Space` `d` | デバイス一覧 |

### 高速ジャンプ (flash.nvim)

| キー | 説明 |
|------|------|
| `s` | 2文字検索でジャンプ |
| `S` | Treesitterノードでジャンプ |

### 囲み文字操作 (nvim-surround)

| キー | 説明 | 例 |
|------|------|-----|
| `ys {motion} {char}` | 囲み文字を追加 | `ysiw"` → 単語を`""`で囲む |
| `ds {char}` | 囲み文字を削除 | `ds"` → `""`を削除 |
| `cs {old} {new}` | 囲み文字を変更 | `cs"'` → `""`を`''`に変更 |

---

## 📝 スニペット

`.tsx`, `.jsx`, `.ts`, `.js` ファイルで使用可能なスニペット一覧です。

### React スニペット

| スニペット | 説明 |
|-----------|------|
| `rfc` | React Function Component (named export) |
| `rfce` | React Function Component (default export) |
| `rafc` | React Arrow Function Component (シンプル版) |

### React Hooks

| スニペット | 説明 |
|-----------|------|
| `us` | useState |
| `ue` | useEffect |
| `ucb` | useCallback |
| `um` | useMemo |
| `ur` | useRef |
| `ucon` | useContext |

### Next.js スニペット

| スニペット | 説明 |
|-----------|------|
| `npage` | Page Component (App Router) |
| `nlayout` | Layout Component |
| `nloading` | Loading Component |
| `nerror` | Error Component |
| `nsc` | Server Component (async) |
| `ncc` | Client Component ('use client') |
| `napi` | API Route (GET/POST) |
| `nmeta` | Metadata export |
| `ngmeta` | generateMetadata |
| `nimg` | Next/Image |
| `nlink` | Next/Link |
| `nrouter` | useRouter |
| `npathname` | usePathname |
| `nsearch` | useSearchParams |

### TypeScript 共通

| スニペット | 説明 |
|-----------|------|
| `int` | interface 定義 |
| `typ` | type 定義 |
| `afn` | async function |
| `tc` | try-catch |
| `cl` | console.log |
| `cll` | console.log (with label) |
| `imp` | import { } from |
| `impd` | import default |

### スニペットの使い方

1. スニペットのトリガー (例: `rfc`) を入力
2. 補完メニューに表示されたら `Enter` で確定
3. `Tab` で次のプレースホルダーに移動
4. `Shift + Tab` で前のプレースホルダーに戻る

---

## 🔧 カスタマイズ

### テーマを変更する

`lua/plugins/theme.lua` を編集:

```lua
return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme("tokyonight-night") -- night, storm, day, moon
    end,
  },
}
```

### キーマップを追加する

`lua/core/keymaps.lua` に追加:

```lua
local map = vim.keymap.set

-- 例: バッファ切り替え
map("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous Buffer" })
```

### 新しいスニペットを追加する

`lua/snippets/init.lua` に追加:

```lua
s("mysnip", fmt([[
-- Your snippet template here
{}
]], {
  i(1, "placeholder"),
})),
```

---

## ⚠️ トラブルシューティング

<details>
<summary><strong>LSPが動作しない</strong></summary>

1. `:LspInfo` でLSPの状態を確認
2. `:Mason` でサーバーがインストールされているか確認
3. 必要なサーバーを `i` キーでインストール

</details>

<details>
<summary><strong>スニペットが展開されない</strong></summary>

1. 対応するファイルタイプか確認 (`.tsx`, `.jsx`, `.ts`, `.js`)
2. `:Lazy sync` でプラグインを更新
3. Neovimを再起動

</details>

<details>
<summary><strong>フォーマットが効かない</strong></summary>

1. Prettierがインストールされているか確認:
   ```bash
   npm install -g prettier
   ```
2. プロジェクトに `.prettierrc` があるか確認

</details>

<details>
<summary><strong>動作がおかしい</strong></summary>

キャッシュをクリアして再インストール:

```bash
# 1. Neovimを終了
# 2. キャッシュを削除
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/mason

# 3. Neovimを再起動
nvim
```

</details>

---

## 📚 使用プラグイン一覧

| プラグイン | 説明 |
|-----------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | プラグインマネージャー |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP設定 |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSPサーバー管理 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 自動補完 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | スニペットエンジン |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | VSCode互換スニペット |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 括弧自動補完 (`()`, `[]`, `{}`, `""`, `''`, `<>`) |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | 囲み文字操作 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 構文解析 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ファジーファインダー |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | ファイルエクスプローラー |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git状態表示 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | バッファタブ |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | ステータスライン |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | カラースキーム |
| [noice.nvim](https://github.com/folke/noice.nvim) | リッチなUI |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | キーバインドヘルプ |
| [flash.nvim](https://github.com/folke/flash.nvim) | 高速ジャンプ |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | フォーマッター |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | ターミナル |
| [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim) | Flutter開発ツール |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | コメント操作 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | インデント可視化 |

---

## 📄 ライセンス

MIT License
