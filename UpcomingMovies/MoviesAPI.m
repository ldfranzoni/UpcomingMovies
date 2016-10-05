//
//  MoviesAPI.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//
#define kTMDBAPIKEY @"1f54bd990f1cdfb230adb312546d765d"
#define kTMDBBASEURL @"https://api.themoviedb.org/3"
#define kTMDBBASEURLIMAGES @"https://image.tmdb.org/t/p/w300"
#define kTMDBBASEURLBACKIMAGES @"https://image.tmdb.org/t/p/w500"

#import "MoviesAPI.h"
#import <AFNetworking.h>
#import "Movie.h"
#import "Genre.h"
@implementation MoviesAPI{
    NSMutableArray *movies;
    NSMutableArray *genres;

}

- (id)init
{
    self = [super init];
    if (self) {
        movies = [[NSMutableArray alloc] init];
        genres = [[NSMutableArray alloc] init];
        [self fetchGenres];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Request Methods


- (void)fetchMoviesWithCompletion:(MoviesListCompletionBlock)completionBlock{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    int pageToFetch =(int)[movies count]/20 + 1;
    NSString *urlToFetch = [NSString stringWithFormat:@"%@/movie/upcoming?api_key=%@&page=%d",kTMDBBASEURL,kTMDBAPIKEY,pageToFetch];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlToFetch parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self processResponseMoviesObject:responseObject completionBlock:completionBlock];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self errorCompletionBlock:completionBlock];
    }];
}

- (void)fetchGenres{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *urlToFetch = [NSString stringWithFormat:@"%@/genre/movie/list?api_key=%@",kTMDBBASEURL,kTMDBAPIKEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlToFetch parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self processResponseGenresObject:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark - Data Parsing

- (void)processResponseMoviesObject:(NSDictionary *)data completionBlock:(MoviesListCompletionBlock)completionBlock
{
    NSArray* auxArray = [NSArray arrayWithArray:[data objectForKey:@"results"]];
    
    for (NSDictionary* auxDictionary in auxArray){
        NSString *posterPathFull = @"";
        if ([auxDictionary objectForKey:@"poster_path"] && ![auxDictionary[@"poster_path"] isEqual:[NSNull null]]) {
            posterPathFull = [NSString stringWithFormat:@"%@%@",kTMDBBASEURLIMAGES,auxDictionary[@"poster_path"]];
        }
        
        NSString *backgroundPathFull = @"";
        if ([auxDictionary objectForKey:@"backdrop_path"] && ![auxDictionary[@"backdrop_path"] isEqual:[NSNull null]]) {
            backgroundPathFull = [NSString stringWithFormat:@"%@%@",kTMDBBASEURLBACKIMAGES,auxDictionary[@"backdrop_path"]];
        }
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *releaseDate = [dateFormatter dateFromString:auxDictionary[@"release_date"]];
        
        NSArray *genreNames = [self getGenresNames:auxDictionary[@"genre_ids"]];
        
        Movie *movie = [[Movie alloc] initWithTitle:auxDictionary[@"title"]
                                             genres:genreNames
                                        releaseDate:releaseDate
                                           overview:auxDictionary[@"overview"]
                                          posterUrl:posterPathFull
                                      backgroundUrl:backgroundPathFull];
        [movies addObject:movie];
        NSLog(@"%@",auxDictionary);
    }
    
    if ([movies count] < 50) {
        [self fetchMoviesWithCompletion:completionBlock];
    }else{
        [self sortMovies];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            completionBlock(movies, nil);
        });
    }
}

- (void)processResponseGenresObject:(NSDictionary *)data
{
    if (data)
    {
        NSArray* auxArray = [NSArray arrayWithArray:[data objectForKey:@"genres"]];
        
        for (NSDictionary* auxDictionary in auxArray)
        {
            
            NSNumber *idGenre = [NSNumber numberWithInt:[auxDictionary[@"id"]intValue]];
            Genre *genre = [[Genre alloc] initWithName:auxDictionary[@"name"]
                                               idGenre:idGenre];
            [genres addObject:genre];
        }
        
    }
}

#pragma mark - Sort Methods

- (void)sortMovies{
    NSArray *sortedArray;
    sortedArray = [movies sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *firstObject = [(Movie *)a releaseDate];
        NSDate *secondObject = [(Movie *)b releaseDate];
        return [firstObject compare:secondObject];
    }];
    movies = [NSMutableArray arrayWithArray:sortedArray];
}

- (NSArray *)getGenresNames:(NSArray *) moviesGenresArray{
    NSMutableArray *genresNamesArray = [[NSMutableArray alloc] init];
    for (NSNumber *genreID in moviesGenresArray) {
        for (Genre *genre in genres) {
            if ([genreID isEqual:genre.idGenre]) {
                [genresNamesArray addObject:genre.name];
                break;
            }
        }
    }
    return genresNamesArray;
}

- (NSArray *)filteredMoviesByText:(NSString *)filterText{
    
    if (filterText == nil) {
        return movies;
    }else{
        
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for (Movie *auxMovie in movies) {
            if ([auxMovie.name containsString:filterText] || [[auxMovie.name lowercaseString] containsString:[filterText lowercaseString]]) {
                [searchResults addObject:auxMovie];
            }
        }
        
        return searchResults;
        
    }
}


#pragma mark - Error Blocks

- (void)errorCompletionBlock:(MoviesListCompletionBlock) completionBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        completionBlock(nil, nil);
    });
}

@end
