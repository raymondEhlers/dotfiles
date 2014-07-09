" Fixes background if this terminal is set
" http://snk.tuxfamily.org/log/vim-256color-bce.html
" http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/402084#402084
TERM=xterm-256color
:set t_ut=
send ^L to vim

" Temporary fix for backspace
" ^V = ctrl-v and <BS> is the backspace key (^? currently)
" http://vimdoc.sourceforge.net/htmldoc/options.html#:fixdel
set t_kb=^V<BS>

# To check if is a symlink and it exists, use -L

# To update vim plugins managed by vundle, run
vim -c VundleUpdate -c quitall
or alternatively, just call VundleUpdate inside of vim (or perhaps PluginInstall)

# To install packages via aptitude
sudo aptitude install $(sed 's/^#.*//' packages | sed '/^$/d')

# To use latex in markdown documents, add to the top of the document: (Then write as `$x^2$` or with `$$x^2$$`
# From: http://stackoverflow.com/a/12979200
<style TYPE="text/css">
code.has-jax {font: inherit; font-size: 100%; background: inherit; border: inherit;}
</style>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
    tex2jax: {
        inlineMath: [['$','$'], ['\\(','\\)']],
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'] // removed 'code' entry
    }
});
MathJax.Hub.Queue(function() {
    var all = MathJax.Hub.getAllJax(), i;
    for(i = 0; i < all.length; i += 1) {
        all[i].SourceElement().parentNode.className += ' has-jax';
    }
});
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

