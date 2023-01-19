# Read bundle ID from config.yaml file
echo "Reading values from config.yaml file"

new_bundle_id=$(grep bundle_id config.yaml | awk '{print $2}')
new_app_name=$(grep app_name config.yaml | awk '{print $2}')

echo "-----------------Updating Bundle Id -----------------"
# Update android/app/build.gradle file
echo "Updating bundle id at android/app/build.gradle file"
sed -i '' "s/applicationId \".*\"/applicationId \"$new_bundle_id\"/" android/app/build.gradle
echo "Updated bundle id at android/app/build.gradle file"

# Update ios/Flutter/Debug-dev.xcconfig
echo "Updating bundle id at ios/Flutter/Debug-dev.xcconfig file"
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER=.*/PRODUCT_BUNDLE_IDENTIFIER=$new_bundle_id.dev/" ios/Flutter/Debug-dev.xcconfig
echo "Updated bundle id at ios/Flutter/Debug-dev.xcconfig file"

# Update ios/Flutter/Debug-prod.xcconfig
echo "Updating bundle id at ios/Flutter/Debug-prod.xcconfig file"
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER=.*/PRODUCT_BUNDLE_IDENTIFIER=$new_bundle_id/" ios/Flutter/Debug-prod.xcconfig
echo "Updated bundle id at ios/Flutter/Debug-prod.xcconfig file"

# Update ios/Flutter/Release-dev.xcconfig
echo "Updating bundle id at ios/Flutter/Release-dev.xcconfig file"
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER=.*/PRODUCT_BUNDLE_IDENTIFIER=$new_bundle_id.dev/" ios/Flutter/Release-dev.xcconfig
echo "Updated bundle id at ios/Flutter/Release-dev.xcconfig file"

# Update ios/Flutter/Release-prod.xcconfig
echo "Updating bundle id at ios/Flutter/Release-prod.xcconfig file"
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER=.*/PRODUCT_BUNDLE_IDENTIFIER=$new_bundle_id/" ios/Flutter/Release-prod.xcconfig
echo "Updated bundle id at ios/Flutter/Release-prod.xcconfig file"

# Update lib/flavors/config/flavor_config.dart
echo "Updating bundle id at lib/flavors/config/flavor_config.dart file"
sed -i '' "s/packageName = '.*\.dev';/packageName = '$new_bundle_id.dev';/" lib/flavors/config/flavor_config.dart
sed -i '' "s/packageName = '.*[^(\.dev)]';/packageName = '$new_bundle_id';/" lib/flavors/config/flavor_config.dart
echo "Updated bundle id at lib/flavors/config/flavor_config.dart file"

echo "-----------------Bundle Id Updated -----------------"

echo "-----------------Updating names for dev and prod-----------------"
# Update android/app/build.gradle file
echo "Updating app name at android/app/build.gradle file"
sed -i "" "s/resValue \"string\", \"app_name\", \"Dev.*\"/resValue \"string\", \"app_name\", \"Dev $new_app_name\"/" android/app/build.gradle
sed -i "" "s/resValue \"string\", \"app_name\", \"[^(Dev)].*\"/resValue \"string\", \"app_name\", \"$new_app_name\"/" android/app/build.gradle
echo "Updated app name at android/app/build.gradle file"

# Update CFBundleDisplayName ios/Flutter/Debug-dev.xcconfig
echo "Updating app name at ios/Flutter/Debug-dev.xcconfig file"
sed -i '' "s/CFBundleDisplayName=.*/CFBundleDisplayName=Dev $new_app_name/" ios/Flutter/Debug-dev.xcconfig
echo "Updated app name at ios/Flutter/Debug-dev.xcconfig file"

# Update CFBundleDisplayName ios/Flutter/Debug-prod.xcconfig
echo "Updating app name at ios/Flutter/Debug-prod.xcconfig file"
sed -i '' "s/CFBundleDisplayName=.*/CFBundleDisplayName=$new_app_name/" ios/Flutter/Debug-prod.xcconfig
echo "Updated app name at ios/Flutter/Debug-prod.xcconfig file"

# Update CFBundleDisplayName ios/Flutter/Release-dev.xcconfig
echo "Updating app name at ios/Flutter/Release-dev.xcconfig file"
sed -i '' "s/CFBundleDisplayName=.*/CFBundleDisplayName=Dev $new_app_name/" ios/Flutter/Release-dev.xcconfig
echo "Updated app name at ios/Flutter/Release-dev.xcconfig file"

# Update CFBundleDisplayName ios/Flutter/Release-prod.xcconfig
echo "Updating app name at ios/Flutter/Release-prod.xcconfig file"
sed -i '' "s/CFBundleDisplayName=.*/CFBundleDisplayName=$new_app_name/" ios/Flutter/Release-prod.xcconfig
echo "Updated app name at ios/Flutter/Release-prod.xcconfig file"

# Update lib/flavors/config/flavor_config.dart
echo "Updating appName at lib/flavors/config/flavor_config.dart file"
sed -i '' "s/appName = 'Dev.*';/appName = 'Dev $new_app_name';/" lib/flavors/config/flavor_config.dart
sed -i '' "s/appName = '.*[^Dev]';/appName = '$new_app_name';/" lib/flavors/config/flavor_config.dart
echo "Updated appName at lib/flavors/config/flavor_config.dart file"

echo "-----------------Names Updated -----------------"

echo "-----------------Starting Firebase Setup-----------------" 
#Running flutterfire_config.sh
sh tools/flutterfire_config.sh

echo "-----------------Firebase Setup Completed-----------------"


