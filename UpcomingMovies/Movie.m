//
//  Movie.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithTitle:(NSString *)name genres:(NSArray *)genres releaseDate:(NSDate *)releaseDate overview:(NSString *)overview posterUrl:(NSString *)posterUrl backgroundUrl:(NSString *)backgroundUrl
{
    self = [super init];
    if (self)
    {
        _name = name;
        _genres = genres;
        _releaseDate = releaseDate;
        _overview = overview;
        _posterUrl = posterUrl;
        _backgroundUrl = backgroundUrl;

    }
    return self;
}


@end
