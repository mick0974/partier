curl -sL https://firebase.tools | bash
firebase login
dart pub global activate flutterfire_cli
export PATH="$PATH":"$HOME/.pub-cache/bin"

flutterfire configure
flutter run
