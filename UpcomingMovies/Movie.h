//
//  Movie.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject


/*
 * @brief The Movie class' name object.
 */
@property (nonatomic, strong) NSString *name;

/*
 * @brief The Movie class' overview object.
 */
@property (nonatomic, strong) NSString *overview;

/*
 * @brief The Movie class' posterUrl object.
 */
@property (nonatomic, strong) NSString *posterUrl;

/*
 * @brief The Movie class' backgroundUrl object.
 */
@property (nonatomic, strong) NSString *backgroundUrl;

/*
 * @brief The Movie class' releaseDate object.
 */
@property (nonatomic, strong) NSDate *releaseDate;

/*
 * @brief The Movie class' genres object.
 */
@property (nonatomic, strong) NSArray *genres;

/*
 * @discussion init method for class movie
 * @param name  a NSString for movie title name
 * @param genres a NSArray for movie genres
 * @param name a NSDate for movie release date
 * @param name a NSString for movie overview/synopsis
 * @param name a NSString for movie poster image url
 * @param name a NSString for movie background image url
 */
- (id)initWithTitle:(NSString *)name genres:(NSArray *)genres releaseDate:(NSDate *)releaseDate overview:(NSString *)overview posterUrl:(NSString *)posterUrl backgroundUrl:(NSString *)backgroundUrl;

@end
