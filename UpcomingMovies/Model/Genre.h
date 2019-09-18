//
//  Genre.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/4/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface Genre : MTLModel <MTLJSONSerializing>

/*
 * @brief The Genre class' name object.
 */
@property (nonatomic, strong) NSString *name;

/*
 * @brief The Genre class' id object.
 */
@property (nonatomic, strong) NSNumber *idGenre;


@end
