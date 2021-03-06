# github login here
class people::hussfelt {
    # apps
    include dropbox
    include github_for_mac
#    include git-flow
    include iterm2::stable
    include onepassword
    include skype
    include chrome
    include firefox
#    include spotify
#    include charles
    include sublime_text_2
    include things
    include tower
    include phpstorm
    include transmission
    include vlc

    include oh-my-zsh

    # osx settings
    include osx::dock::autohide
    include osx::dock::dim_hidden_apps

    $dotfiles = "/Users/hussfelt/src/dotfiles"

    repository { $dotfiles:
      source => "${::github_login}/dotfiles",
      require => File["/Users/hussfelt/src/"],
    }

    exec { "install dotfiles":
      provider => shell,
      command  => "./script/install",
      cwd      => $dotfiles,
      creates  => "${home}/.zshrc",
      require  => Repository[$dotfiles],
    }

#   class {'charles::license':
#     license_name => 'Your name',
#     license_key  => '7ad6c7a6c87...',
#   }
}

