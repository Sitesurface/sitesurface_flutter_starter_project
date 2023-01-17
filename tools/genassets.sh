outputFile=lib/constants/assets/asset_constants.dart
echo "class AssetConstants {" > $outputFile

for file in assets/images/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
camelCase=$(echo "${fileName%.*}" | tr -d '_' | awk '{ for (i=1; i<=NF; i++) { $i=toupper(substr($i,1,1)) substr($i,2) } print }')
# Convert first character to lowercase
  camelCase=$(echo "image$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/images/$fileName\";" >> $outputFile
done

for file in assets/icons/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
camelCase=$(echo "${fileName%.*}" | tr -d '_' | tr '[:upper:]' '[:lower:]' | awk '{ for (i=1; i<=NF; i++) { $i=toupper(substr($i,1,1)) substr($i,2) } print }')
  # Convert first character to lowercase
  camelCase=$(echo "icon$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/icons/$fileName\";" >> $outputFile
done

for file in assets/lottie/*; do
  fileName=$(basename "$file")
  # Convert file name to camel case
 camelCase=$(echo "${fileName%.*}" | tr -d '_' | awk '{ for (i=1; i<=NF; i++) { $i=toupper(substr($i,1,1)) substr($i,2) } print }')
  # Convert first character to lowercase
  camelCase=$(echo "lottie$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  echo "  static const $camelCase = \"assets/lottie/$fileName\";" >> $outputFile
done

echo "}" >> $outputFile