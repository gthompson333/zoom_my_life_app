# zoom_my_life_app

A Flutter app that implements the Zoom My Life interview coding assessment requirements.

## Coding assessment requirements

Create a mobile, web app which allows for:
- Registering new users,
- Login, Logout
- List uploaded documents
- Ability to add, delete documents, name document while adding
- Use object-oriented design where all applicable
- Use Firebase, Flutter preferably
- Provide code and instructions for us to run it. You may provide a link to GitHub or tar/zip
  content by email or any other means.

## Run issues
When running the project on Android, if you see an error stating that the minimum SDK version
must be at least 23, you should change the version within your Flutter installation.

flutter-directory/packages/flutter_tools/gradle/src/main/groovy/flutter.groovy

In the flutter.groovy file you will find the below statements. 
You can set the minSdkVersion value here.

/** Sets the minSdkVersion used by default in Flutter app projects. */
public final int minSdkVersion = 23


