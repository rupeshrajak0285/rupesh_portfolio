# Rupesh Rajak · Portfolio

Senior Flutter Developer portfolio built with **Flutter Web** and **Firebase**.
Live: https://rupeshflutter.web.app

## Features
- Fully responsive (mobile / tablet / desktop) with a single codebase
- Animated particle constellation background with pointer parallax
- Typewriter hero, 3D-tilt profile, floating badges, scroll-reveal sections
- Smooth section navigation with active-link tracking and scroll progress bar
- Filterable project grid with store badges and detail dialogs
- Expandable experience timeline, animated stat counters
- Contact form saved to Cloud Firestore (falls back to `mailto:` when Firebase is not configured)
- Firebase Analytics events, SEO meta tags, HTML loading splash

## Structure
```
lib/
  core/          theme, responsive helpers, url utils
  data/          models + all résumé content (portfolio_data.dart)
  services/      Firebase wrapper + firebase_options.dart
  presentation/  providers, reusable widgets, sections, pages
```

## Firebase setup (one-time)
```bash
firebase login                      # account that owns the rupeshflutter project
dart pub global activate flutterfire_cli
flutterfire configure --project=rupeshflutter --platforms=web
```
That regenerates `lib/services/firebase_options.dart` with real keys. Then enable **Firestore** in the console and deploy the rules in `firestore.rules`.

## Run / deploy
```bash
flutter run -d chrome
./deploy.sh
```
