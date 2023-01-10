# sitesurface_flutter_starter_project


# Getting Started

### App icon and Splash Icons
    Change the app_logo in the assets/icons/app_logo.png
    run the script in tools/gen-icons.sh to generate app_icon and splash icons.

### Generate AssetConstants
    Generate asset constants file by running script in tools/gen-assets.sh

### App Name and application id
    Change app name and application id from android/app/build.gradle
    //TODO : Add script 

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
### 
