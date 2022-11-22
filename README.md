# nvim-start

这是一个用`lua`组织的`noevim`模块化配置非常适合前端开发，我把使用 vim 3年整理的配置重构整理git教程
根据 git commit 一步步学习，配置文件的搭建过程，包含设置，快捷键，插件模块式管理，启动时间优化, tmux
结合，和终端下一些命令的结合， 持续更新中...

## 先来一张成品图
![](./assets/sample.png)

![](./assets/pluginmanager.png)

小白用户可能需要先了解一些基础知识，推荐一些学习资料

[w3cschool vim](https://www.w3cschool.cn/vim/)

[nvim-lua-guide-zh](https://github.com/glepnir/nvim-lua-guide-zh)

> 由于本人使用的arch linux，所以该配置目前考虑在linux良好运行

## 安装稳定neovim

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

> 如果使用这种方式直接安装最新版，缺少依赖可先安装稳定版 `sudo pacman -S neovim` 在进行替换

## 快捷键
在 `lua/general/keymap.lua`
