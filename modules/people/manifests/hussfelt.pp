# github login here
class people::hussfelt {
    # apps
    include dropbox
    include github_for_mac
    include iterm2::stable
    include onepassword
    include skype
    include spotify
    include sublime_text_2
    include things
    include phpstorm
    include transmission
    include vlc

    # osx settings
    include osx::dock::autohide
    include osx::dock::dim_hidden_apps

    $dotfiles = "${boxen::config::srcdir}/dotfiles"

    repository { $dotfiles:
      source => "${::github_login}/dotfiles",
      require => File[${boxen::config::srcdir}],
    }

    exec { "install dotfiles":
      provider => shell,
      command  => "./script/install",
      cwd      => $dotfiles,
      creates  => "${home}/.zshrc",
      require  => Repository[$dotfiles],
    }
}
