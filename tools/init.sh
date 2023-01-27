# Read bundle ID from config.yaml file
echo "Reading values from config.yaml file"

new_bundle_id=$(grep bundle_id config.yaml | awk '{print $2}')
new_app_name=$(grep app_name config.yaml | awk '{print $2}')

fvm flutter pub run change_app_package_name:main $new_bundle_id

echo "-----------------Updating Bundle Id -----------------"
# Update android/app/build.gradle file
echo "Updating bundle id at android/app/build.gradle file"
awk -v new_bundle_id="$new_bundle_id" '{gsub(/applicationId ".*"/, "applicationId \""new_bundle_id"\"")}1' android/app/build.gradle > android/app/build.gradle.tmp && mv android/app/build.gradle.tmp android/app/build.gradle
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


echo "-----------------Names Updated -----------------"



