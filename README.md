# nvim
neovim configuration for myself

# Install 
package management: [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)  
1. Install packer.nvim first: 
```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

2. Clone the repo
```sh
git clone https://github.com/tenfyzhong/nvim ~/.config/nvim
```

3. Setup plugins in vim
```vim
PackerInstall
PackerCompile
```
