outputFile=lib/constants/assets/asset_constants.dart
echo "class AssetConstants {" > $outputFile

function camelCase() {
  local fileName="$1"
  local prefix="$2"
  local directory="$3"
  local camelCase=$(echo "${fileName%.*}" | awk -F_ '{for (i=1; i<=NF; i++) { $i=toupper(substr($i,1,1)) substr($i,2) } print }')
  camelCase=$(echo "$prefix$camelCase" | awk '{print tolower(substr($0,1,1)) substr($0,2)}')
  camelCase="$(echo $camelCase | awk '{gsub(/ /,"")}1')"
  echo "  static const $camelCase = \"$directory/$fileName\";" >> $outputFile
}

for file in assets/images/*; do
  fileName=$(basename "$file")
  camelCase "$fileName" "image" "assets/images"
done

for file in assets/icons/*; do
  fileName=$(basename "$file")
  camelCase "$fileName" "icon" "assets/icons"
done

for file in assets/lottie/*; do
  fileName=$(basename "$file")
  camelCase "$fileName" "lottie" "assets/lottie"
done

echo "}" >> $outputFile
