# dotfiles

個人用dotfiles設定集。bash版とzsh版の両方をサポートしています。

## クイックスタート

### zsh版（推奨 - macOS用）

```bash
cd dotfiles
./install_zsh.bash
```

### bash版（Ubuntu等用）

```bash
cd dotfiles
./install.bash
```

## 含まれる設定

### シェル設定
- **zshrc_base.zsh**: zsh専用設定（履歴、補完、キーバインド等）
- **bashrc_base.bash**: bash専用設定（履歴、補完等）
- **shell_common.sh**: bash/zsh共通設定（環境変数、開発ツール等）

### アプリケーション設定
- **Neovim設定（LazyVim）**: `~/.config/nvim/`
- **Starship設定**: `~/.config/starship.toml`
- **tmux設定**: `~/.tmux.conf`
- **Cargo設定**: `~/.cargo/config.toml`
- **stylua設定**: `~/.stylua.toml`

## 対応開発ツール

以下のツールが自動的に設定されます（インストールされている場合）：

- **Rust/Cargo**: 環境変数とパス設定
- **Node.js/NVM**: バージョン管理と補完
- **Python/Pyenv**: バージョン管理
- **Go**: パス設定
- **Deno**: パス設定
- **TeX Live**: パス設定（macOS/Linux対応）
- **Google Cloud SDK**: パスと補完
- **Starship**: クロスシェルプロンプト
- **direnv**: 環境変数管理
- **Homebrew**: macOS用パッケージマネージャー

## 必要ツールのインストール

### Rust

Starship を cargo で入れるために必要。

参考: https://www.rust-lang.org/tools/install

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec -l $SHELL # ~/.cargo/env を読むため
```

### Starship

参考: https://starship.rs/ja-JP/guide/

```bash
# Rustがインストール済みの場合
cargo install starship --locked

# または公式インストーラー
curl -sS https://starship.rs/install.sh | sh

# macOSの場合
brew install starship
```

### NeoVim

参考: https://github.com/neovim/neovim/blob/master/INSTALL.md

```bash
# macOS
brew install neovim

# Ubuntu
sudo apt install neovim

# または最新版をソースからビルド
cd ~/repos
git clone https://github.com/neovim/neovim.git -b stable --depth 1
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

### direnv（推奨）

```bash
# macOS
brew install direnv

# Ubuntu
sudo apt install direnv
```

## ファイル構成

```
dotfiles/
├── README.md                    # このファイル
├── install.bash                 # bash版インストーラー
├── install_zsh.bash            # zsh版インストーラー
└── config/
    ├── shell_common.sh         # bash/zsh共通設定
    ├── bashrc_base.bash        # bash専用設定
    ├── zshrc_base.zsh          # zsh専用設定
    ├── starship.toml           # Starshipプロンプト設定
    ├── tmux.conf               # tmux設定
    ├── cargo_config.toml       # Cargo設定
    ├── stylua.toml             # Lua formatter設定
    └── nvim/                   # Neovim設定（LazyVim）
```

## 移行ガイド

### bashからzshへの移行

1. zsh版をインストール：
   ```bash
   ./install_zsh.bash
   ```

2. デフォルトシェルを変更：
   ```bash
   chsh -s $(which zsh)
   ```

3. 新しいターミナルを開くか、設定を再読み込み：
   ```bash
   source ~/.zshrc
   ```

### 既存設定との共存

- bash版とzsh版は共存可能です
- 共通設定は`shell_common.sh`で管理されます
- 既存ファイルは自動的にバックアップされます（`.backup`拡張子）

## トラブルシューティング

### zshが見つからない場合

```bash
# macOS
brew install zsh

# Ubuntu
sudo apt install zsh
```

### 設定が反映されない場合

```bash
# 設定ファイルの再読み込み
source ~/.zshrc  # zshの場合
source ~/.bashrc # bashの場合

# または新しいターミナルを開く
```

### シンボリックリンクの問題

インストールスクリプトを再実行すると、既存のシンボリックリンクが修正されます：

```bash
./install_zsh.bash  # zshの場合
./install.bash      # bashの場合
