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
