To compile tmux:
http://www.linuxquestions.org/questions/linux-software-2/installing-tmux-from-source-as-non-root-user-857098/
The key was to change the CPPFLAGS to account for a locally installed libevent
CPPFLAGS="-I$MYINSTALL/include -L$MYINSTALL/lib"

To compile vim
If it is necessary to compile vim, it should likely be configured as:
./configure --prefix=$MYINSTALL --with-features=huge --disable-gui --without-x

To install matchit (better vim bracket, etc matching), see :help matchit
