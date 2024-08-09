rm startuptime.log;nvim --startuptime startuptime.log;cat startuptime.log | tail -n 2 | head -n 1
mv startuptime.log tmp.log;cat tmp.log | sed "s/$USER/\$USER/" > startuptime.log
rm tmp.log
