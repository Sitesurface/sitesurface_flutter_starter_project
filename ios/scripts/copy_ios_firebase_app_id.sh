# Regex to extract the scheme name from the Build Configuration
# We have named our Build Configurations as Debug-dev, Debug-prod etc.
# Here, dev and prod are the scheme names. This kind of naming is required by Flutter for flavors to work.
# We are using the $CONFIGURATION variable available in the XCode build environment to extract 
# the environment (or flavor)
# For eg.
# If CONFIGURATION="Debug-prod", then environment will get set to "prod".
if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then
environment=${BASH_REMATCH[1]}
fi

echo $environment

# Name and path of the resource we're copying
FIREBASE_APP_ID_JSON=firebase_app_id_file.json
FIREBASE_APP_ID_FILE=${PROJECT_DIR}/config/${environment}/${FIREBASE_APP_ID_JSON}

# Make sure firebase_app_id.json exists
echo "Looking for ${FIREBASE_APP_ID_JSON} in ${FIREBASE_APP_ID_FILE}"
if [ ! -f $FIREBASE_APP_ID_FILE ]
then
echo "No firebase_app_id.json found. Please ensure it's in the proper directory."
exit 1
fi

# Get a reference to the destination location for the firebase_app_id.json
DESTINATION=${PROJECT_DIR}/${FIREBASE_APP_ID_JSON}
echo "Will copy ${FIREBASE_APP_ID_JSON} to final destination: ${DESTINATION}"

# Copy over the prod firebase_app_id.json for Release builds
cp "${FIREBASE_APP_ID_FILE}" "${DESTINATION}"




