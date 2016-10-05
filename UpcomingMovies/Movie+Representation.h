//
//  Movie+Representation.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/5/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Movie.h"

@interface Movie (Representation)

/*
 * @discussion method to get a NSString from genres array
 * @return NSString genres separated by commas
 */
- (NSString *)genresString;

/*
 * @discussion method to get a NSString in dd-MM-YYYY format from release date
 * @return NSString release date
 */
- (NSString *)releaseDateString;

/*
 * @discussion method to get a NSString format overview
 * @return NSString overview
 */
- (NSString *)overviewString;

@end
