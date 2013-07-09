Install:

  git clone git@github.com:simonrobson/dotfiles.git
  cd dotfiles
  git submodule init
  git submodule update
  cd vim/bundle/vimproc.vim && make

  cd dotfiles/vim/bundle/command-t/ruby/command-t
  ruby extconf.rb
  make

  cd ~
  ln -s dotfiles/vim .vim
  ln -s dotfiles/vimrc .vimrc

Add new vim bundles as submodules:

  git submodule add http://github.com/tpope/vim-unimpaired vim/bundle/vim-unimpaired


