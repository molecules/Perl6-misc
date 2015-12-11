# Quotes using Q||
shell(Q|rsync -av --include='top-dir/' --include='top-dir-pattern/patternA' --include='top-dir/patternB' --include='top-dir/subdir/' --include='top-dir/subdir/patternX'  --exclude='*' --append-verify top-dir target-dir > rysnc.log|);
