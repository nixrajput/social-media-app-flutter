# Rippl! - A Social Media App

Rippl! is a social media app that allows users to share their photos and videos
with other users. Users can also follow other users and like and comment on
their posts.

[<img src='screenshots/download.png' height='50' alt='Download' title='Download'>][releases]

- The app is developed using Flutter and GetX state management. The app is
currently in development and is not yet ready for production.

- Right now, the app is only available for Android devices.

- We are open to contributions. If you would like to contribute, please read the
[contribution guidelines](CONTRIBUTING.md).

- We are also looking for UI/UX designers. If you would like to contribute as a UI/UX designer,
please read the [contribution guidelines](CONTRIBUTING.md) and then contact the project [owner][github].

- We are also open to design suggestions. If you would like to suggest a design, feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues).

- We are also open to feature requests. If you would like to request a feature, please feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues). We will try to implement the feature as soon as possible.

- We are also open to bug reports. If you would like to report a bug, please feel free to open an [issue](https://github.com/nixrajput/social-media-app-flutter/issues). We will try to fix the bug as soon as possible.

## Setup

- Create `secrets.dart` file in constants folder.
- Add the following code to the file.

```dart
abstract class AppSecrets {
  static const uploadPreset = 'XXX-XXX-XXX-XXX';
  static const cloudinaryCloudName = 'XXX-XXX-XXX-XXX';
  static const githubToken = 'XXX-XXX-XXX-XXX';
}
```

- Replace XXX-XXX-XXX-XXX with your values in the file.
- Now run the following commands:

```dart
flutter clean
flutter pub get packages
```

## Screenshots

Created with [previewed.app](https://previewed.app).

### Row `1`

<img src='screenshots/image1.png' height='720' align='left' alt='Welcome Screen' title='Welcome Screen'>

<img src='screenshots/image2.png' height='720' alt='Login Screen' title='Login Screen'>

### Row `2`

<img src='screenshots/image3.png' height='720' align='left' alt='About Screen' title='About Screen'>

<img src='screenshots/image4.png' height='720' alt='Home Screen' title='Home Screen'>

### Row `3`

<img src='screenshots/image5.png' height='720'  alt='Profile Screen' title='Profile Screen'>

## Download

You can download the app from the [releases page][releases].

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of
conduct, and the process for submitting pull requests to us.

## Authors

- **[Nikhil Rajput][portfolio]** - *Owner & Lead Developer*

## Features

- [x] User Authentication
- [x] Post Feed
- [x] Post Creation
- [x] Post Editing
- [x] Post Deletion
- [x] Post Liking
- [x] Post Commenting
- [ ] Post Sharing
- [x] Post Searching
- [ ] Post Filtering
- [ ] Post Sorting
- [ ] Post Reporting
- [ ] Post Blocking
- [ ] Post Muting
- [x] Profile Creation
- [x] Profile Editing
- [x] Profile Deactivation
- [x] User Following
- [x] User Unfollowing
- [ ] User Blocking
- [ ] User Muting
- [x] User Searching
- [ ] User Filtering
- [x] Trending Posts
- [ ] Hashtag Searching
- [ ] Post Tagging
- [ ] User Mentioning
- [x] Recommendations
- [ ] Search Suggestions
- [x] Settings
- [x] Support
- [x] Dynamic Theme

## Upcoming Features

- [ ] P2P Messaging
- [ ] Group Messaging
- [ ] Push Notifications
- [ ] End-to-End Encryption

## License

This project is licensed under the GPL-3.0 License - see the
[LICENSE.md](LICENSE.md) file for details

## Connect With Me

[<img align="left" alt="nixrajput | Website" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/globe-icon.svg" />][website]

[<img align="left" alt="nixrajput | GitHub" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/github-brands.svg" />][github]

[<img align="left" alt="nixrajput | Instagram" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/instagram-brands.svg" />][instagram]

[<img align="left" alt="nixrajput | Facebook" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/facebook-brands.svg" />][facebook]

[<img align="left" alt="nixrajput | Twitter" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/twitter-brands.svg" />][twitter]

[<img align="left" alt="nixrajput | LinkedIn" width="24px" src="https://raw.githubusercontent.com/nixrajput/nixlab-files/master/images/icons/linkedin-in-brands.svg" />][linkedin]

[github]: https://github.com/nixrajput
[website]: https://nixlab.co.in
[facebook]: https://facebook.com/nixrajput07
[twitter]: https://twitter.com/nixrajput07
[instagram]: https://instagram.com/nixrajput
[linkedin]: https://linkedin.com/in/nixrajput
[portfolio]: https://nixrajput.nixlab.co.in
[releases]: https://github.com/nixrajput/social-media-app-flutter/releases
