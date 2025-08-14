# dotfiles

```bash
source install.bash
```

## Install tools

### Rust

Starship を cargo で入れるために必要。Starship は Ubuntu 25+ なら apt でも入るらしい。

参考: https://www.rust-lang.org/tools/install

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec -l $SHELL # ~/.cargo/env を読むため
```

### Starship

参考: https://starship.rs/ja-JP/guide/


```bash
cargo install starship --locked
exec -l $SHELL # ~/.config/starship.toml を読むため
```

### NeoVim

参考: https://github.com/neovim/neovim/blob/master/INSTALL.md

一応 apt にもありますが、古い可能性は高い。（最低でも 0.8 はほしい）

```bash
sudo apt install neovim
```

ソースコードからビルドしましょう。Ninja があれば勝手に内部で使われるらしいです。

参考: https://github.com/neovim/neovim/blob/master/BUILD.

```bash
cd ~/repos
git clone https://github.com/neovim/neovim.git -b stable --depth 1
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

```
