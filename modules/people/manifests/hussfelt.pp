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
    include osx::global::enable_keyboard_control_access
    include osx::global::expand_print_dialog
    include osx::global::expand_save_dialog
    include osx::dock::2d
    include osx::dock::autohide
    include osx::dock::clear_dock
    include osx::dock::dim_hidden_apps
    include osx::finder::empty_trash_securely
    include osx::finder::unhide_library
    include osx::disable_app_quarantine
    include osx::no_network_dsstores
}
