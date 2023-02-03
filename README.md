# sitesurface_flutter_starter_project


# Getting Started


### Scripts Available
1. init.sh - Renames the bundle id and App name to required places
2. flutterfire_config.sh - Configures the firebase project vy appropriate bundle id and project
3. gen_freezed.sh - Generates freezed documents
4. genassets.sh - Generated all assets in asset_constants.dart as static variables.
5. gen_icons.sh - Generated app icon and splash screen icon

### App icon and Splash Icons
    Change the app_logo in the assets/icons/app_logo.png
    run the script in tools/gen-icons.sh to generate app_icon and splash icons.

### Generate AssetConstants
    Generate asset constants file by running script in tools/gen-assets.sh

### App Name and application id
    Run init.sh - (Works in mac only for now)
#### Android
    Change app name and application id from android/app/build.gradle

#### iOS
    Change app name and bundle id in ios/flutter/*
    Debug-dev.xcconfig -> Add dev configuration
    Release-dev.xcconfig -> Add dev configuration
    Debug-prod.xcconfig -> Add prod configuration
    Release-prod.xcconfig -> Add prod configuration

### Add Facebook Client token and id
    Change your facebook keys in /android/app/src/main/res/values/strings.xml

    If not using facebook , remove the following code from AndroidManifest.xml
```
        <meta-data
           android:name="com.facebook.sdk.ApplicationId"
           android:value="@string/facebook_app_id" />
        <meta-data 
           android:name="com.facebook.sdk.ClientToken" 
           android:value="@string/facebook_client_token"/>
```
### Firebase setup
    change variable values in tools/flutterfire_config.sh

### Change TextTheme Fonts
    change your textTheme font by changing the fontstyle in lib/util/styles/theme/themes/text_theme.dart



### Do native configuration for  
#### Google_sign_in
    https://pub.dev/packages/google_sign_in
#### Facebook Sign in
    https://facebook.meedu.app/docs/5.x.x/intro

#### Notifications
#### Firebase Dynamic Links
    https://pub.dev/packages/firebase_dynamic_links



Roadmap => 
1. Generate Keystore file automatically
2. Sign debug build using release keys so that we wont need to add sha keys of every system
    


    




