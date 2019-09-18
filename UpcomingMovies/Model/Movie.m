//
//  Movie.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "Movie.h"
#import "Config.h"
#import "MoviesAPI.h"
#import "Genre.h"

@implementation Movie

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"title",
             @"overview" : @"overview",
             @"posterUrl" : @"poster_path",
             @"backgroundUrl" : @"backdrop_path",
             @"releaseDate" : @"release_date",
             @"genres" : @"genre_ids"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"backgroundUrl"]) {
        return [self backgroundURLJSONTransformer];
    }else if ([key isEqualToString:@"posterUrl"]) {
        return [self posterURLJSONTransformer];
    }else if ([key isEqualToString:@"genres"]) {
        return [self genresJSONTransformer];
    }
    
    return nil;
}

+ (NSValueTransformer *)releaseDateJSONTransformer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error){
        return [dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)backgroundURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error){
        NSString *backgroundPathFull = @"";
        if (![urlString isEqual:[NSNull null]] && urlString != nil) {
            backgroundPathFull = [NSString stringWithFormat:@"%@%@",kTMDBBASEURLBACKIMAGES,urlString];
        }
        return backgroundPathFull;
    } reverseBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return urlString;
    }];
}

+ (NSValueTransformer *)posterURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error){
        NSString *posterPathFull = @"";
        if (![urlString isEqual:[NSNull null]] && urlString != nil) {
            posterPathFull = [NSString stringWithFormat:@"%@%@",kTMDBBASEURLIMAGES,urlString];
        }
        return posterPathFull;
    } reverseBlock:^id(NSString *urlString, BOOL *success, NSError *__autoreleasing *error) {
        return urlString;
    }];
}

+ (NSValueTransformer *)genresJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *genreArrays, BOOL *success, NSError *__autoreleasing *error){
        NSMutableArray *genresNamesArray = [[NSMutableArray alloc] init];
        for (NSNumber *genreID in genreArrays) {
            for (Genre *genre in [[MoviesAPI sharedInstance] getGenres]) {
                if ([genreID isEqual:genre.idGenre]) {
                    [genresNamesArray addObject:genre.name];
                    break;
                }
            }
        }
        return genresNamesArray;
    } reverseBlock:^id(NSArray *genreArrays, BOOL *success, NSError *__autoreleasing *error) {
        return genreArrays;
    }];
}



@end
