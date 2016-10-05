//
//  MoviesAPI.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MoviesListCompletionBlock)(NSArray* _Nullable moviesArray, NSString* _Nullable errorString);

@interface MoviesAPI : NSObject


/*
 * @discussion Returns a 'MoviesApi' shared instance
 * @return 'MoviesApi' instance
 */
+ (MoviesAPI*)sharedInstance;

/*
 * @discussion Method to fetch upcoming movie lists
 * @param MoviesListCompletionBlock A block object to be executed when the request operation finishes. Returns a NSArray of upcoming movies
 */
- (void)fetchMoviesWithCompletion:(MoviesListCompletionBlock)completionBlock;

/*
 * @discussion Method to get array of upcomingmovies filtered by a search text
 * @param filterText text to search in title
 * @return NSArray filtered upcoming movies that matches the search text
 */
- (NSArray *)filteredMoviesByText:(NSString *)filterText;
@end
NS_ASSUME_NONNULL_END
