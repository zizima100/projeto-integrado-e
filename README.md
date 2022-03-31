# The Spot Installation
Current SDK version: 2.10.4
## Windows
https://docs.flutter.dev/get-started/install/windows

## Linux
https://docs.flutter.dev/get-started/install/linux

# Run
## Dependencies
> flutter pub get
## Build runner
Let this command run in a terminal while developing mobx code related stuff
> flutter pub run build_runner watch --delete-conflicting-outputs

# Common issues
## Error signing in with Google SSO
> PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)
    
In terminal, run:

(Windows)
> keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore

(Mac/Linux)
> keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
  
Copy SHA-1 and SHA-256 outputs codes and send to repository owner add it to Firebase project configuration.

Source: [Add Fingerprints SHA-1 & SHA256](https://youtu.be/1k-gITZA9CI?t=213)