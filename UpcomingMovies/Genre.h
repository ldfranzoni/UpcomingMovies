//
//  Genre.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/4/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

/*
 * @brief The Genre class' name object.
 */
@property (nonatomic, strong) NSString *name;

/*
 * @brief The Genre class' id object.
 */
@property (nonatomic, strong) NSNumber *idGenre;

/*
 * @discussion init method for class genre
 * @param name  a NSString for genre name
 * @param genres a NSNumber for genre id
 */
- (id)initWithName:(NSString *)name idGenre:(NSNumber *)idGenre;
@end
