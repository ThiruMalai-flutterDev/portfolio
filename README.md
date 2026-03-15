# 🚀 Flutter Developer Portfolio

A modern, responsive **Flutter Web** portfolio website for **Thirumalai S**, a Flutter developer with 3 years of experience building cross-platform Android & iOS applications.

---

## ✨ Features

- **Fully Responsive** — Mobile, Tablet & Desktop layouts using `LayoutBuilder` / `MediaQuery`
- **Dark Theme** — Deep space aesthetic with cyan & purple accents
- **Smooth Animations** — Hero entrance, fade-in sections, hover effects, orbiting blobs
- **Smooth Scroll Navigation** — Section-aware active nav, scroll-to-section
- **Floating Navbar** — Transparent on top, frosted glass on scroll
- **Interactive Skills** — Filterable skill cards with proficiency bars
- **Project Showcase** — Alternating left/right cards with hover glow effects
- **Timeline Experience** — Visual career timeline
- **Contact Section** — Mailto and social links with hover cards
- **PWA Ready** — `manifest.json` + custom `index.html` with preloader

---

## 🗂️ Project Structure

```
lib/
├── main.dart                    # Entry point
├── app/
│   └── app.dart                 # MaterialApp + ThemeData
├── screens/
│   └── home_screen.dart         # Main scroll controller, section keys
├── sections/
│   ├── hero_section.dart        # Hero with animated blobs + grid
│   ├── about_section.dart       # About me + highlights
│   ├── skills_section.dart      # Filterable skill grid
│   ├── projects_section.dart    # Project cards (alternating layout)
│   ├── experience_section.dart  # Timeline experience cards
│   └── contact_section.dart     # Contact cards + CTA
├── widgets/
│   ├── nav_bar.dart             # Floating responsive navbar
│   ├── animated_button.dart     # Gradient + outline buttons
│   ├── section_title.dart       # Reusable title + FadeInSection
│   ├── skill_chip.dart          # Hoverable skill chip
│   └── footer.dart              # Footer
├── models/
│   ├── project_model.dart       # ProjectModel + project data
│   └── skill_model.dart         # SkillModel + skill data
└── utils/
    ├── constants.dart            # Colors, sizes, strings
    └── responsive.dart           # Responsive helpers + breakpoints
web/
├── index.html                   # Custom HTML with preloader
└── manifest.json                # PWA manifest
```

---

## 🎨 Design Tokens

| Token | Value |
|---|---|
| Background | `#0A0A0F` |
| Surface | `#111118` |
| Surface Elevated | `#1A1A24` |
| Accent Cyan | `#00D4FF` |
| Accent Purple | `#7B2FBE` |
| Text Primary | `#FFFFFF` |
| Text Secondary | `#B0B0C0` |
| Heading Font | Syne (Google Fonts) |
| Body Font | Space Grotesk (Google Fonts) |

---

## 🛠 Tech Stack

- **Flutter 3.x** (Flutter Web)
- **Dart 3.x**
- **google_fonts** — Syne + Space Grotesk
- **animate_do** — Entrance animations
- **url_launcher** — Social/email links
- **visibility_detector** — Scroll-triggered animations

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Chrome browser

### Run locally

```bash
# Get dependencies
flutter pub get

# Run in Chrome
flutter run -d chrome

# Build for production
flutter build web --release --web-renderer canvaskit
```

### Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login & init
firebase login
firebase init hosting

# Build & deploy
flutter build web --release
firebase deploy
```

---

## 📱 Responsive Breakpoints

| Device | Max Width |
|---|---|
| Mobile | < 600px |
| Tablet | 600px – 1023px |
| Desktop | ≥ 1024px |

---

## 📬 Contact

- **Email:** tomasz.gajda@dev.com
- **GitHub:** [github.com/tomaszgajda](https://github.com/tomaszgajda)
- **LinkedIn:** [linkedin.com/in/tomaszgajda](https://linkedin.com/in/tomaszgajda)

---

*Built with Flutter Web ❤️*
