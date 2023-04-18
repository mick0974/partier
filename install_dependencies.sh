curl -sL https://firebase.tools | bash
firebase login
dart pub global activate flutterfire_cli
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub add firebase_core
flutter pub add cloud_firestore
flutter pub add firebase_auth
flutter pub add google_sign_in
flutter pub add google_maps_flutter
flutter pub add google_maps_flutter_web
flutter pub add map_launcher
flutterfire configure
flutter run
