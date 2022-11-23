## 安装稳定版neovim

```bash
sudo pacman -S neovim
```

## 安装最新版neovim

方式有很多这里介绍一个, 手动下载最新release包 https://github.com/neovim/neovim/releases

找到 nvim-linux64.tar.gz 下载并解压

这里已我的下载路径为例

```bash
cd /usr/local/bin

ln -s ~/.local/src/nvim-linux64/bin/nvim nvim

nvim --version
```

> 如果使用这种方式直接安装最新版，缺少依赖可先安装稳定版 `sudo pacman -S neovim` 再进行替换
