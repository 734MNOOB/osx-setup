#!/usr/bin/env sh

# NOTE: Before running this script, make sure that XCode commandline tools are installed and its terms/conditions accepted.
# xcode-select --install

brew_get_head() {
  brew update && brew upgrade
  brew cleanup && brew cask cleanup
}

brew_install() {
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Tap sources
  local taps=(
    'homebrew/services'
    'homebrew/php'
    'caskroom/cask'
    'caskroom/versions'
  ); for i in ${taps[@]}; do brew tap ${i}; done

  # Update & cleanup
  brew_get_head

  # Install Kegs
  local kegs=(
    'aws-cli'
    'bash-completion'
    'brew-cask-completion'
    'calc'
    'curl'
    'direnv'
    'docker'
    'dockutil'
    'ffmpeg'
    'firebase-cli'
    'flow'
    'emacs'
    'gdbm'
    'gettext'
    'git'
    'gmp'
    'gnupg'
    'gnutls'
    'go'
    'google-cloud-sdk'
    'googler'
    'gpg2'
    'grep'
    'hub'
    'mongodb'
    'mongoose'
    'mysql'
    'nettle'
    'nvm'
    'open-completion'
    'openssl'
    'openssl@1.1'
    'perl'
    'python'
    'readline'
    'ruby'
    's3cmd'
    'speedtest-cli'
    'sqlite'
    'the_silver_searcher'
    'tig'
    'tmux'
    'trash'
    'tree'
    'vim'
    'watch'
    'wget'
    'yarn'
  ); for i in ${kegs[@]}; do brew install ${i}; done

  # Install Casks
  local casks=(
    'adobe-acrobat-reader'
    'atom'
    'bettertouchtool'
    'ccleaner'
    'cloudapp'
    'dropbox'
    'gimp'
    'gitter'
    'google-chrome'
    'google-drive'
    'imageoptim'
    'iterm2-beta'
    'postman'
    'sketch'
    'skype'
    'skype-for-business'
    'slack'
    'spectacle'
    'spotify'
    'steam'
    'sublime-text'
    'twitch'
    'unity'
    'visual-studio-code'
  ); for i in ${casks[@]}; do brew cask install ${i}; done
}

install_node(){
  nvm install 8.2.1
  nvm alias default 8.2.1
  nvm use default
}

setup_git(){
  echo "Enter git user.name: "
  read name
  echo "Enter git user.email: "
  read email
  git config --global user.name "${name}"
  git config --global user.email "${email}"
  git config --global core.editor emacs
  git config --global push.default current
}

speedup_osx(){
  defaults write NSGlobalDomain NSWindowResizeTime 0.01
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write com.apple.dock springboard-show-duration -float 0.1
  defaults write com.apple.dock springboard-hide-duration -float 0.1
  # Don’t animate opening applications from the Dock
  defaults write com.apple.dock launchanim -bool false
  # Remove the auto-hiding Dock delay
  defaults write com.apple.dock autohide-delay -float 0
  # Remove the animation when hiding/showing the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0
  # Increase window resize speed for Cocoa applications
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  killall Dock && killall Finder
}

symlink_jsc() {
  ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /usr/local/bin
}

#############################
#  Main Installation Steps  #
#############################
brew_install
brew_get_head
install_node
symlink_jsc
setup_git
speedup_osx
