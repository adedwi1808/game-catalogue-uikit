//
//  Game.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//


struct Game {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String?
    let rating: Double?
    let platforms: [PlatformElement]
    let genres: [Genre]
}

struct Genre {
    let id: Int
    let name: String
}

struct PlatformElement {
    let id: Int
    let name: String
    let slug: String
}

let dummyGames: [Game] = [
    Game(
        id: 1,
        name: "God of War: Ragnarök",
        released: "2022-11-09",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.9,
        platforms: [
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventure")
        ]
    ),
    Game(
        id: 2,
        name: "The Legend of Zelda: Tears of the Kingdom",
        released: "2023-05-12",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.8,
        platforms: [
            PlatformElement(id: 3, name: "Nintendo", slug: "nintendo")
        ],
        genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "RPG")
        ]
    ),
    Game(
        id: 3,
        name: "Cyberpunk 2077",
        released: "2020-12-10",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.4,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 3, name: "Sci-Fi"),
            Genre(id: 4, name: "Open World")
        ]
    ),
    Game(
        id: 4,
        name: "Elden Ring",
        released: "2022-02-25",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.9,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 5, name: "Soulslike"),
            Genre(id: 6, name: "RPG")
        ]
    ),
    Game(
        id: 5,
        name: "Resident Evil Village",
        released: "2021-05-07",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.5,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 7, name: "Horror"),
            Genre(id: 1, name: "Action")
        ]
    ),
    Game(
        id: 6,
        name: "Spider-Man 2",
        released: "2023-10-20",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.8,
        platforms: [
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 8, name: "Superhero")
        ]
    ),
    Game(
        id: 7,
        name: "Hogwarts Legacy",
        released: "2023-02-10",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.6,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation"),
        ],
        genres: [
            Genre(id: 2, name: "Adventure"),
            Genre(id: 4, name: "Open World")
        ]
    ),
    Game(
        id: 8,
        name: "Gears 5",
        released: "2019-09-10",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.2,
        platforms: [
            PlatformElement(id: 5, name: "Xbox", slug: "xbox")
        ],
        genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 9, name: "Shooter")
        ]
    ),
    Game(
        id: 9,
        name: "Halo Infinite",
        released: "2021-12-08",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.3,
        platforms: [
            PlatformElement(id: 5, name: "Xbox", slug: "xbox"),
            PlatformElement(id: 4, name: "PC", slug: "pc")
        ],
        genres: [
            Genre(id: 9, name: "Shooter"),
            Genre(id: 10, name: "Sci-Fi")
        ]
    ),
    Game(
        id: 10,
        name: "Animal Crossing: New Horizons",
        released: "2020-03-20",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.7,
        platforms: [
            PlatformElement(id: 3, name: "Nintendo", slug: "nintendo")
        ],
        genres: [
            Genre(id: 11, name: "Simulation")
        ]
    ),
    Game(
        id: 11,
        name: "Final Fantasy XVI",
        released: "2023-06-22",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.8,
        platforms: [
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 6, name: "RPG"),
            Genre(id: 1, name: "Action")
        ]
    ),
    Game(
        id: 12,
        name: "Death Stranding",
        released: "2019-11-08",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.4,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 2, name: "Adventure")
        ]
    ),
    Game(
        id: 13,
        name: "The Witcher 3: Wild Hunt",
        released: "2015-05-19",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.9,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation"),
            PlatformElement(id: 5, name: "Xbox", slug: "xbox")
        ],
        genres: [
            Genre(id: 6, name: "RPG"),
            Genre(id: 4, name: "Open World")
        ]
    ),
    Game(
        id: 14,
        name: "Forza Horizon 5",
        released: "2021-11-05",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.7,
        platforms: [
            PlatformElement(id: 5, name: "Xbox", slug: "xbox"),
            PlatformElement(id: 4, name: "PC", slug: "pc")
        ],
        genres: [
            Genre(id: 12, name: "Racing"),
            Genre(id: 4, name: "Open World")
        ]
    ),
    Game(
        id: 15,
        name: "Ghost of Tsushima",
        released: "2020-07-17",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.8,
        platforms: [
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 1, name: "Action")
        ]
    ),
    Game(
        id: 16,
        name: "Ori and the Blind Forest",
        released: "2015-03-11",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.6,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 5, name: "Xbox", slug: "xbox")
        ],
        genres: [
            Genre(id: 2, name: "Adventure"),
            Genre(id: 13, name: "Platformer")
        ]
    ),
    Game(
        id: 17,
        name: "Stardew Valley",
        released: "2016-02-26",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.9,
        platforms: [
            PlatformElement(id: 3, name: "Nintendo", slug: "nintendo"),
            PlatformElement(id: 4, name: "PC", slug: "pc")
        ],
        genres: [
            Genre(id: 11, name: "Simulation"),
            Genre(id: 13, name: "Indie")
        ]
    ),
    Game(
        id: 18,
        name: "Red Dead Redemption 2",
        released: "2018-10-26",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.9,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation"),
            PlatformElement(id: 5, name: "Xbox", slug: "xbox")
        ],
        genres: [
            Genre(id: 4, name: "Open World"),
            Genre(id: 6, name: "RPG")
        ]
    ),
    Game(
        id: 19,
        name: "It Takes Two",
        released: "2021-03-26",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.7,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation")
        ],
        genres: [
            Genre(id: 2, name: "Adventure"),
            Genre(id: 14, name: "Co-op")
        ]
    ),
    Game(
        id: 20,
        name: "Overwatch 2",
        released: "2022-10-04",
        backgroundImage: "https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg",
        rating: 4.1,
        platforms: [
            PlatformElement(id: 4, name: "PC", slug: "pc"),
            PlatformElement(id: 1, name: "PlayStation", slug: "playstation"),
            PlatformElement(id: 5, name: "Xbox", slug: "xbox"),
            PlatformElement(id: 3, name: "Nintendo", slug: "nintendo")
        ],
        genres: [
            Genre(id: 9, name: "Shooter"),
            Genre(id: 15, name: "Multiplayer")
        ]
    )
]
