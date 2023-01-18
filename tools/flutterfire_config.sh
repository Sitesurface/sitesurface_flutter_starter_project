#!/bin/bash



# Delete the existing firebase_options_dev.dart,  firebase_options_prod.dart files, firebase_app_id.json file and google-services.json file
echo "Deleting existing firebase configuration files"
rm lib/flavors/config/firebase/firebase_options_dev.dart
rm lib/flavors/config/firebase/firebase_options_prod.dart
rm ios/config/dev/firebase_app_id_file.json
rm ios/config/prod/firebase_app_id_file.json
rm android/app/src/dev/google-services.json
rm android/app/src/prod/google-services.json
rm ios/config/dev/GoogleService-Info.plist
rm ios/config/prod/GoogleService-Info.plist

configure_flutter_fire() {
    local environment=$1
    local out_file=$2
    local package_name=$3
    local bundle_id=$4
    local class_name=$5
    
    echo "Configuring FlutterFire for iOS and Android for $environment environment"
    flutterfire configure --project=sitesurface-flutter-starter --platforms=ios,android --android-package-name=$package_name --ios-bundle-id=$bundle_id --yes --out=$out_file
    flutter pub run build_runner build --delete-conflicting-outputs
    
    echo "Renaming class DefaultFirebaseOptions to $class_name in $out_file"
    sed -i '' "s/DefaultFirebaseOptions/$class_name/g" $out_file
    echo "Moving generated google-services.json to android/app/src/$environment"
    mv android/app/google-services.json android/app/src/$environment/google-services.json
    echo "Moving generated GoogleService-Info.plist ios/config/$environment"
    mv ios/Runner/GoogleService-Info.plist ios/config/$environment/GoogleService-Info.plist
    echo "Moving generated firebase_app_id_file.json from ios to ios/config/$environment"
    mv ios/firebase_app_id_file.json ios/config/$environment/firebase_app_id_file.json
    echo "----------$environment Configuration done ----------"
}

new_bundle_id=$(grep bundle_id config.yaml | awk '{print $2}')

configure_flutter_fire "dev" "lib/flavors/config/firebase/firebase_options_dev.dart" "$new_bundle_id.dev" "$new_bundle_id.dev" "DevDefaultFirebaseOptions"
configure_flutter_fire "prod" "lib/flavors/config/firebase/firebase_options_prod.dart" "$new_bundle_id" "$new_bundle_id" "ProdDefaultFirebaseOptions"