//
//  Movie.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface Movie : MTLModel <MTLJSONSerializing>

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

@end
