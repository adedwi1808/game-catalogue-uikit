# Game Catalogue App

## Build Status

![Codemagic Build Status](Docs/codemagic_build_status.png)

> **Note**: Build successfully passed on Codemagic (iOS Workflow).

## Authors

- [@adedwi1808](https://www.github.com/adedwi1808)

---

## Installation

1. Clone repositori ini:

   ```bash
   git clone https://github.com/adedwi1808/game-catalogue-uikit.git
   ```

2. Buka file `.xcodeproj` di Xcode.
3. Pastikan Swift Package Manager (SPM) mengunduh semua _dependency_:
   - Kingfisher
   - RealmSwift
   - SkeletonView
4. **Konfigurasi API Key**:
   - Masuk ke folder `Application/Config`.
   - Duplicate `Sample.xcconfig` menjadi dua file: `Debug.xcconfig` dan `Release.xcconfig`.
   - Masukkan API_KEY RAWG Anda ke dalam kedua file tersebut: `API_KEY = your_key`.
   - Di Xcode, buka Project Info -> Configurations, set Debug ke `Debug.xcconfig` dan Release ke `Release.xcconfig`.
5. Jalankan proyek (Build & Run).

---

## Design

- [Figma Design](https://www.figma.com/design/A43jN3aNoW9EuMhDYXuh7x/RAWG?node-id=0-1&t=ypNmkMDpIBHwynML-1)

---

## API Reference

Seluruh API menggunakan `baseURL`:

```
https://api.rawg.io
```

### GET List Of Game

**Endpoint:**

```
GET /api/games
```

| Parameter | Type   | Location    | Description                   |
| --------- | ------ | ----------- | ----------------------------- |
| key       | String | Query Param | API Key                       |
| page      | String | Query Param | Current Page                  |
| page_size | String | Query Param | Number of element in one page |
| search    | String | Query Param | Search Query                  |

### GET Game Detail

**Endpoint:**

```
GET /api/games/{{GAME_ID}}
```

| Parameter | Type   | Location    | Description |
| --------- | ------ | ----------- | ----------- |
| key       | String | Query Param | API Key     |
| game_id   | String | Query Param | Game ID     |

---

## Tech Stack

**Client:**

- **UI:** UIKit (Programmatic & XIB)
- **Arsitektur:** VIPER + Modularization
  - **Features:** [`Home`](https://github.com/adedwi1808/game-catalogue-Home-package), [`Favorite`](https://github.com/adedwi1808/game-catalogue-Favorite-package), [`GameDetail`](https://github.com/adedwi1808/game-catalogue-GameDetail-package), [`About`](https://github.com/adedwi1808/game-catalogue-About-package)
  - **Core:** [`Core`](https://github.com/adedwi1808/game-catalogue-Core-package), [`Common`](https://github.com/adedwi1808/game-catalogue-Common-package), [`Components`](https://github.com/adedwi1808/game-catalogue-Components-package)
- **Networking:** URLSession + Async/Await
- **Reactive Programming:** Combine
- **Image Loading:** Kingfisher
- **Local Database:** Realm
- **Skeleton:** SkeletonView
- **Dependency Manager:** Swift Package Manager (SPM)
- **Localization:** English & Indonesian
