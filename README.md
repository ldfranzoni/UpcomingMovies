# UpcomingMovies
List of upcoming movies ordered by release date. 
Info obtained by The Movie Database.
[TheMovieDB](https://www.themoviedb.org/)

## App Demo:
![Demo](demo.gif)

## Libraries:
To run the project just open the UpcomingMovies.xcworkspace.
If the workspace gets the libraries not found error. Go to Terminal on the project root an run `pod install` and reopen UpcomingMovies.xcworkspace.

Libraries added using Cocoapods

'Cocoapods'
Dependency manager. 

'AFNetworking'
Library to handle http request to The Movie Database API.

'FTIndicator'
Library to display indicators. Used to show a loading indicator when downloading the movie list and an error indicator if no connection available.

'DZNEmptyDataSet' 
Library to handle empty data sets of movies. Used to show a message to the user in case the movie list is empty and handles a refresh tap.


## Requirements
- iOS 7.0+
- Xcode 6.0
