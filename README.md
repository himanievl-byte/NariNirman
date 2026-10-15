# 🌻 NariNirman

**Seekho. Kamao. Aage Badho.** (Learn. Earn. Grow.)

An affordable, multilingual mobile app that helps rural women turn the skills they already have into income, by connecting **learning**, **selling** and **local earning opportunities** in one place.

Built for the theme **Affordable Tech for Rural Women Entrepreneurs**.
Supports UN SDG 5, 8, 9 and 10.

## Who is it for?

- **Primary users:** rural and semi-urban women (about 18-50) such as self-help group members, home-based artisans, tailors, bakers and beauty-parlour owners, with basic smartphone use and limited digital literacy.
- **Beginners:** women with no specific skill yet get guided starter courses.
- **Secondary users:** local event organisers, mela committees, NGOs, and customers looking for handmade products and services.

## The problem

Rural women with skills in handicrafts, stitching, cooking and beauty services struggle to earn sustainably. They lack business training, digital tools, wider markets and local opportunities, and find pricing and marketing hard.

## What the app does

| Pillar | Features in this MVP |
|---|---|
| **Learn** | Skill and Business courses, short lessons, quiz, completion certificate, recommendations based on your skills |
| **Sell** | Free product and service listings, voice-style "speak about your product" drafting, suggested description, WhatsApp message to share |
| **Participate** | Local opportunity board (events, stalls, jobs), filters for distance and skills, verified-organizer labels, safety tips, apply button |
| **Grow** | Badges, progress dashboard, price calculator (cost + profit = suggested price) |
| **Everywhere** | Onboarding that personalises the home screen, English / Hindi / Punjabi labels, large buttons |

## Run it

Requires [Flutter](https://docs.flutter.dev/get-started/install) 3.22 or newer.

```bash
git clone <your-repo-url>
cd narinirman
flutter create .      # generates android/ios/web folders (keeps lib/ and pubspec.yaml)
flutter pub get
flutter run
flutter test
```

## Project structure

```
lib/
  main.dart          app entry, theme
  data.dart          sample courses, opportunities, translations
  state.dart         app state, recommendations, badges
  services.dart      listing parser, caption and price helpers
  screens/           onboarding, shell, home, learn, sell, participate, profile
test/
  widget_test.dart   smoke and logic tests
```

## Current status (honest scope)

This is a working **prototype** that runs fully offline with sample data.

- **Voice input:** the mic button inserts a demo sentence, and the parser turns it into a draft listing. Real speech-to-text is the next step (`speech_to_text` package).
- **AI assistance:** description and listing drafting use local rules in `lib/services.dart`. These are the hook points for an AI API.
- **Data:** courses, opportunities and verified labels are sample data. Nothing is stored after the app closes.
- **Firebase:** planned, not yet connected.

## Roadmap

1. Firebase Auth (phone OTP), Firestore for listings and opportunities, Storage for photos
2. Real voice input and AI-generated descriptions in the user's language
3. Offline downloadable lessons with audio
4. Organizer accounts with verification, reviews and reporting
5. Payments, delivery, bulk-order coordination for self-help groups
6. Impact tracking: registrations, first listing, first order, income reported

## License

MIT (add a LICENSE file before publishing).
