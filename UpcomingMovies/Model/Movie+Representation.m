//
//  Movie+Representation.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/5/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Movie+Representation.h"

@implementation Movie (Representation)

- (NSString *)releaseDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *releaseDateText = [NSString stringWithFormat:NSLocalizedString(@"Release date: %@",nil),[dateFormatter stringFromDate:self.releaseDate]];
    return releaseDateText;
}


- (NSString *)genresString{
    if ([self.genres count] == 0)
        return @"N/A";
    
    NSMutableString *genreString = [[NSMutableString alloc] init];;
    for (NSString *genre in self.genres) {
        [genreString appendFormat:@"%@,",genre];
    }
    [genreString replaceCharactersInRange:NSMakeRange([genreString length]-1, 1) withString:@""];
    
    return genreString;
}

- (NSString *)overviewString{
    if ([self.overview isEqualToString:@""]) {
        return NSLocalizedString(@"Synopsis not available",nil);
    }else{
        return [NSString stringWithFormat:@"Synopsis\n\n%@",self.overview];
    }
}



@end
