# Overview: TheMovie (Flutter app)

Welcome to TheMovieDB, a Flutter application that
consumes [The Movie Database](https://developer.themoviedb.org/docs) to retrieve up-to-date
information about popular movies, enabling an exploration of the cinematic world.

## What's included

1. A Flutter app with _modular architecture_, clean architecture, SOLID principles and BLoC state
   management.

![app_architectural_pattern](docs/images/architecture.drawio.png)

2. Besides, libraries and frameworks such as:

- **animate_do**: for widget animation purposes.
- **dartz**: for Either wrapper.
- **dio**: for network requests.
- **flutter_dotenv**: for reading .env config files.
- **get_it**: for service locator feature.
- **go_router**: for navigation purposes.
- **intl**: for texts internationalization.
- **json_annotation**: for json mappers creation.
- **bloc**: for state management.
- **cached_network_image**: for image caching.

3. The project structure is divided into three layers:

- **presentation**: this layer contains UI, widgets, and defined BLoC interactions that serve as
  entry point for the users.
- **domain**: here, you can find the core of the app. All business rules related to the problem to
  be solved are included. Entities and UseCases will indicate what this movies app is about.
- **infrastructure**: this layer defines the access to external services such as TheMovieDB and the
  local database.

### Demo:

<img src="docs/gifs/demo_themoviedb.gif" width="350" height="650"/>

### Without internet connection:

<img src="docs/gifs/data_with_no_internet.gif" width="350" height="650"/>

# Installation

1. Clone this repository and import in into **Android Studio**:

```bash  
git clone https://github.com/JorgeDiazz/TheMovieFlutter.git
```  

2. To download required dependencies

```
flutter pub get
```

3. Rename .env.template to .env and set the following key:

```
THE_MOVIE_DB_API_KEY=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYmI2NDlhNDg5MDJjZmZlNTJkOTYwMmY3MTM0MGEzYSIsIm5iZiI6MTY2NzY3Mjc5OC4xNjcsInN1YiI6IjYzNjZhYWRlNjY1NjVhMDA4YWMxM2U2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z1xmorvBxbvzdtAANeg1DO1wTkUxASNN4P0DElcTdn0```
```

4. To generate files:

```
dart run build_runner build --delete-conflicting-outputs
```

5. To run the app:

```
flutter run -d [device_id]
```

- To format the project source code:

1. dart analyze .
2. dart format .

--

**Flutter version: 3.27.1**

--

# Missing features

To meet the project deadline, the following features were not implemented:

1. Golden tests & Widget tests (presentation layer), Unit tests (For BLoC, use cases, repositories
   and datasources), and Integration tests (to automate the movies listing and routing testing
   process).
2. Specific widgets for error handling and loading states.
3. A more detailed error handling mechanism.
4. A DIO interceptor to handle network errors and inject API KEYS.
5. Cache mechanism for movie details.
