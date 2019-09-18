//
//  Genre.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/4/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Genre.h"

@implementation Genre

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"idGenre" : @"id"
             };
}

@end
