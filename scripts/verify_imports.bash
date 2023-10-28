#!/usr/bin/env bash

# check if the directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

directory="$1"

# check if the specified directory exists
if [ ! -d "$directory" ]; then
  echo "The directory '$directory' does not exist."
  exit 1
fi

# check if the default.nix file exists in the specified directory
if [ -e "$directory/default.nix" ]; then
  # Change to the specified directory
  cd "$directory" || exit 1

  # get the list of files in the directory, 
  # excluding those starting with . or _
  expected_files=($(find "." -type f -not -name '.*' -not -name '_*' -not -name "default.nix" -exec basename {} \;))

  # extract the list of exported files from the default.nix file
  exported_files=($(grep -oE '\./[^"]+' default.nix | sed 's/\.\///'))

  # check if all files in the directory are exported
  missing_files=()
  for file in "${expected_files[@]}"; do
    if ! [[ "${exported_files[@]}" =~ "${file}" ]]; then
      missing_files+=("$file")
    fi
  done

  # Display the results
  if [ ${#missing_files[@]} -eq 0 ]; then
    echo "All nix config files in the directory are imported in default.nix."
  else
    echo "Some nix config files are not imported in default.nix:"
    for missing_file in "${missing_files[@]}"; do
      echo "- $missing_file"
    done
  fi
else
  echo "The default.nix file does not exist in the '$directory' directory."
fi