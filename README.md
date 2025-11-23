# Game Catalogue App

## Authors

* [@adedwi1808](https://www.github.com/adedwi1808)

---

## Installation

1. Clone repositori ini:

   ```bash
   git clone [<repo-url>](https://github.com/adedwi1808/game-catalogue-uikit.git)
   ```
2. Buka file `.xcodeproj` di Xcode.
3. Pastikan Swift Package Manager (SPM) mengunduh semua *dependency*:
   * Kingfisher
   * RealmSwift
   * SkeletonVIew
4. Masukkan API_KEY di NetworkFactory  
5. Jalankan proyek (Build & Run).

---

## Design

* [https://www.figma.com/design/rFCOJn3KDmnavRXY7xKHxh/Tourism-APP?m=auto&t=mRekcYQUOk53ZGRe-6](https://www.figma.com/design/A43jN3aNoW9EuMhDYXuh7x/RAWG?node-id=3-601&t=FrEKWyt06hfDl3XX-1)

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

| Parameter | Type   | Location    | Description                        |
| --------- | ------ | ----------- | ---------------------------------- |
| key       | String | Query Param | API Key                            |
| page      | String | Query Param | Current Page                       |
| page_size | String | Query Param | Number of element in one page      |
| search    | String | Query Param | Search Query                       |


### GET Game Detail

**Endpoint:**

```
GET /api/games/{{GAME_ID}}
```

| Parameter | Type   | Location    | Description                        |
| --------- | ------ | ----------- | ---------------------------------- |
| key       | String | Query Param | API Key                            |
| game_id   | String | Query Param | Game ID                            |

---

## Tech Stack

**Client:**

* **UI:** UIKit
* **Arsitektur:** MVVM (Model-View-ViewModel)
* **Networking:** URLSession + Async/Await
* **Image Loading:** Kingfisher
* **Local Database** Realm
* **Skeleton** SkeletonView
* **Dependency Manager:** Swift Package Manager (SPM)
