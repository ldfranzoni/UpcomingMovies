//
//  Genre.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/4/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Genre.h"

@implementation Genre

- (id)initWithName:(NSString *)name idGenre:(NSNumber *)idGenre;
{
    self = [super init];
    if (self)
    {
        _name = name;
        _idGenre = idGenre;
        
    }
    return self;
}

@end
