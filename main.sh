#!/bin/bash

# Filename which contains URLs in Newsboat format
filename=$1

# Check file exists
if [[ ! -e "$filename" ]]; then
  echo "File '$filename' doesn't exist."
  exit 1
fi

# Empty list with new format URL
new_urls=()

# Read URLs from file and turn them into FreshRSS format
while IFS= read -r channel_name; do
# Line with channel name always starts with '#' if it doesn't then it's not a channel name line
  if [[ $channel_name =~ ^\#.* ]]; then
    # Remove '# ' from it.
    channel_name=$(echo "$channel_name" | sed 's/^# //g')
    IFS= read -r xml_url
    # If channel starts with '#' means it is disabled because you no longer wanted news from it so we skip it from adding it to FreshRSS.
    if [[ ! $xml_url =~ ^\#.* ]]; then
      # Take just URL (in Newsboat you could add comments after URLs)
      xml_url=$(echo "$xml_url" | awk '{print $1}')
      html_url=""  # I guess that variable should be added manually

      # Create new format text line
      new_url="      <outline text=\"$channel_name\" type=\"rss\" xmlUrl=\"$xml_url\" htmlUrl=\"$html_url\" description=\"\"/>"

      # Add new URL string to list of new URLs
      new_urls+=("$new_url")
    fi
  fi
done < "$filename"

# Print URLs in new format (stdout to file > output)
for new_url in "${new_urls[@]}"; do
  echo "$new_url"
done