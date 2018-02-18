## Majestic Dotfiles(Arch Linux 64 Bits)

Arquivos da minha pasta pessoal(/home/lucas, e outras pastas...) da máquina [majestic](https://majestic.radiochat.com.br).
Sinta-se livre para usar, alterar, divulgar e comentar.

## Índice

* [i3 gaps](https://github.com/sistematico/majestic/tree/master/.config/i3/config)
* [polybar](https://github.com/sistematico/majestic/tree/master/.config/polybar)
* [i3blocks](https://github.com/sistematico/majestic/tree/master/.config/i3blocks)
* [rofi](https://github.com/sistematico/majestic/tree/master/.config/rofi)
* [dunst](https://github.com/sistematico/majestic/tree/master/.config/dunst)
* [compton](https://github.com/sistematico/majestic/tree/master/.config/compton.conf)
* [termite](https://github.com/sistematico/majestic/tree/master/.config/termite/config)
* [ncmpcpp](https://github.com/sistematico/majestic/tree/master/.config/ncmpcpp)
* [qutebrowser](https://github.com/sistematico/majestic/tree/master/.config/qutebrowser/config.py)
* [startpage](https://github.com/sistematico/majestic/tree/master/.config/startpage/)
* [~/bin](https://github.com/sistematico/majestic/tree/master/bin)
* [~/.local/bin](https://github.com/sistematico/majestic/tree/master/.local/bin)  

## Exemplos de como usar os dotfiles(não faça isso como root)
    
Usando o git:

	mkdir ~/github && cd ~/github # crie a pasta gihub(ou qualquer outro nome)
    git clone git@github.com:sistematico/majestic.git # clone o repositório
    mv ~/.config/i3/config ~/.config/i3/config.bkp # caso já exista uma config, faça o backup
    ln -s ~/github/majestic/.config/i3/config ~/.config/i3/config # linke o repositorio

Usando o curl:

    mv ~/.config/i3/config ~/.config/i3/config.bkp
    curl -s -o ~/.config/i3/config 'https://raw.githubusercontent.com/sistematico/majestic/master/.config/i3/config'

Usando o auto instalador:

    curl -s -o /tmp/install.sh 'https://raw.githubusercontent.com/sistematico/majestic/master/setup/install.sh'
    bash /tmp/install.sh

Problemas? Abra uma [issue](https://github.com/sistematico/majestic/issues/new) ;)

## ScreenShots

![Screenshot #1][screenshot1]  

[screenshot1]: https://raw.githubusercontent.com/sistematico/majestic/master/screenshot.png "Screenshot #1"