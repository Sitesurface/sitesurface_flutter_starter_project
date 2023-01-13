#!/bin/bash

outputFile=lib/constants/assets/asset_constants.dart
echo "class AssetConstants {" > $outputFile

for file in assets/images/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
camelCase=$(echo "${fileName%.*}" | sed -r 's/(^|_|\/)([a-z])/\2/g')
  # Convert first character to lowercase
  camelCase=$(echo "$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/images/$fileName\";" >> $outputFile
done

echo "}" >> $outputFile


outputFile=lib/constants/assets/icon_constants.dart
echo "class IconConstants {" > $outputFile

for file in assets/icons/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
camelCase=$(echo "${fileName%.*}" | sed -r 's/(^|_|\/)([a-z])/\2/g')
  # Convert first character to lowercase
  camelCase=$(echo "$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/icons/$fileName\";" >> $outputFile
done

echo "}" >> $outputFile


outputFile=lib/constants/assets/lottie_constants.dart
echo "class LottieConstants {" > $outputFile

for file in assets/lottie/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
camelCase=$(echo "${fileName%.*}" | sed -r 's/(^|_|\/)([a-z])/\2/g')
  # Convert first character to lowercase
  camelCase=$(echo "$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/icons/$fileName\";" >> $outputFile
done

echo "}" >> $outputFile
