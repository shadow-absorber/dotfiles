#!/usr/bin/env sh

LOGFILE="$HOME/.config/mpd/mpd.log"
OUTFILE="$HOME/.config/rmpc/genre_counts.txt"
TMPFILE="$(mktemp)"

# Extract and accumulate genres to tmpfile
grep "player: played" "$LOGFILE" | while read -r line; do
  filepath=$(echo "$line" | sed -n 's/.*player: played "\(.*\)"/\1/p')
  fullpath="$HOME/beets/music/$filepath"

  if [ -f "$fullpath" ]; then
    genre=$(exiftool -s -s -s -Genre "$fullpath" )
    # echo $genre
    IFS=';' 
    for g in $genre; do
      clean_genre=$(echo "$g" | xargs)
      [ -n "$clean_genre" ] && echo "$clean_genre" >> "$TMPFILE"
    done
  fi
done

# Count and sort genres
sort "$TMPFILE" | uniq -c | sort -k1 -nr | awk '{ $1=$1; print substr($0, index($0,$2)) " " $1 }' > "$OUTFILE"

rm "$TMPFILE"
echo "✅ Genre frequency list saved to $OUTFILE"

