git add -N .
git reset --hard
git submodule foreach --quiet --recursive '
git add -N .
git reset --hard
'

