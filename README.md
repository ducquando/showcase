#Showcase

*Showcase* is an application for students to browse and read research articles. This idea originates from the UX project called [Project Gallery](https://www.behance.net/gallery/120240899/Project-Gallery/modules/684326629) from CS303 Human-Computer Interaction at Fulbright University Vietnam.

Some basic features of *Showcase*:
- Article showcasing on a user-centric GUI
- Article recommendation based on the users' histories comparison algorithm
- Article interaction such as saved and flagged

Additionally, *Showcase* is a native-iOS app that supports:
- Color mode (light and dark) switching

On top of that, *Showcase* should also stores and fetchs data from the database, which adds these functions to the program:
- New article's updation
- Article searching by titles
- User's sign-in

That is all for the first version of our first app built with Swift.

Since our app will communicate with a database, we decide to use the small, fast, and free SQL database engine called [SQLite](https://www.sqlite.org). This database holds all users' profiles along with associated articles, reading history, and direct messages. For the scope of this project, this database will be faked. The raw database can be found at [showcase-dataset](https://github.com/ducquando/showcase-dataset).

To wrap SQLite query easiler, we will use a framework developed by Stephen Celis called [SQLite.swift](https://github.com/stephencelis/SQLite.swift). Their repository will be cloned directly onto our repository.

Additionally, we will use SwiftUI, an Apple's declarative UI framework from Apple that enables developers to build native user interfaces for IOS apps. Since SwiftUI is a built-in framework, we must import it first. The importing syntax is: `import SwiftUI`.

That's all. Below is a peak of what will our app look like *(designed using Figma)*.

![alt text](https://github.com/ducquando/learn-swift/blob/main/images/app_preview.png "Showcase app preview")

For a closer look, let's watch this Youtube video: [Showcase App Preview](https://youtu.be/XA_s9ia5n2s).

If you are interested and have cloned this repository to your computer, use any of these profiles to log-in to the app:

email | password 
--- | ---
user1@showcase.quannz | quannz
user2@showcase.quannz | quannz
user3@showcase.quannz | quannz
user4@showcase.quannz | quannz
user5@showcase.quannz | quannz
