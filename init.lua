-- init.lua

-- 基本設定
require("core.options")
-- キーマップ
require("core.keymaps")
-- プラグインのロード
require("plugins")

-- クリップボードをOSと共有する（ヤンクしたものをシステムのクリップボードに入れる）
vim.opt.clipboard = "unnamedplus"
