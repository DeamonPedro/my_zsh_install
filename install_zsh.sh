#!/usr/bin/sh
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git  ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/amstrad/oh-my-matrix ~/.oh-my-zsh/custom/plugins/oh-my-matrix
sudo mkdir "/usr/share/fonts/truetype/Hack Nerd Font"
cp "Hack Regular Nerd Font Complete.ttf" "/usr/share/fonts/truetype/Hack Nerd Font/"
mv ~/.zshrc ~/.zshrc_old
cp .zshrc ~/.zshrc
cp p10k.zsh ~/.oh-my-zsh/custom/themes/powerlevel10k/internal/