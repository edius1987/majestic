## Majestic Dotfiles(Arch Linux 64 Bits)

Arquivos da minha pasta pessoal(/home/lucas, e outras pastas...) da máquina [majestic](https://majestic.radiochat.com.br).
Sinta-se livre para usar, alterar, divulgar e comentar.

## Índice

* [i3-gaps](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/i3)
* [i3blocks](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/i3blocks)
* [rofi](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/rofi)
* [dunst](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/dunst)
* [compton](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/compton.conf)
* [termite](https://github.com/sistematico/majestic/tree/master/home/lucas/.config/termite/config)
* [~/bin](https://github.com/sistematico/majestic/tree/master/home/lucas/bin)

## Exemplos de como usar os dotfiles(não faça isso como root)
    
Usando o git:

	mkdir ~/github && cd ~/github # crie a pasta gihub(ou qualquer outro nome)
    git clone git@github.com:sistematico/majestic.git # clone o repositório
    mv ~/.config/i3/config ~/.config/i3/config.bkp # caso já exista uma config, faça o backup
    ln -s ~/github/majestic/home/lucas/.config/i3/config ~/.config/i3/config # linke o repositorio ao seus arquivos de configuração

Usando o curl:

    mv ~/.config/i3/config ~/.config/i3/config.bkp
    curl -s -o ~/.config/i3/config 'https://raw.githubusercontent.com/sistematico/majestic/master/home/lucas/.config/i3/config'

Usando o auto instalador:

    Em breve...    

Problemas? Abra uma [issue](https://github.com/sistematico/majestic/issues/new) ;)

## ScreenShot

![Screenshot][screenshot]

[screenshot]: https://raw.githubusercontent.com/sistematico/majestic/master/screenshot.png "Screenshot"