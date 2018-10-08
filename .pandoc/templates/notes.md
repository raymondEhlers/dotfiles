# Beamer template

Beamer and latex share the same template - see [here](https://tex.stackexchange.com/a/405524). So we modify
the latex template to add an argument to the short author. This template should be updated from time to time
to receive the latest `pandoc` improvements. The only modification to the template is to add the `shortAuthor`
option (as configured in the YAML metadata) via the following change:

```
$if(author)$
\author$if(shortAuthor)$[$shortAuthor$]$endif${$for(author)$$author$$sep$ \and $endfor$}
$endif$
```

Note that by naming the template `default.latex`, it will be picked up by default by `pandoc`.
