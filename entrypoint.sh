#!/bin/sh -l

outpath="$1"
mkdir -p "$outpath"
printf "Got path: %s\n" "$outpath"

shift $(( OPTIND - 1 ))

for file in "$@"; do
  if [ -f "$file" ]; then
    printf "Attempting compile of: %s\n" "$file"
    name=$(basename "$file")
    printf "Output to: %s\n" "${outpath}/${name}.png"
    /mmdc/node_modules/.bin/mmdc -p /mmdc/puppeteer-config.json -i "$file" -o "${outpath}/${name}.png"

    if [ ! -f "${outpath}/${name}.png" ]; then
      printf "Unable to create %s, exiting.." "${outpath}/${name}.png"
      exit 1
    fi
  fi
done
