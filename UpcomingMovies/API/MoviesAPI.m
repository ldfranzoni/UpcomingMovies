//
//  MoviesAPI.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "MoviesAPI.h"
#import <AFNetworking.h>
#import "Config.h"
#import "Movie.h"
#import "Genre.h"
#import <Mantle.h>
#import "PersistencyManager.h"
#import <UIImage+AFNetworking.h>

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

#pragma mark - Getters Methods

- (NSArray *)getGenres{
    return genres;
}

- (NSArray *)getMovies
{
    return movies;
}

#pragma mark - Request Methods


- (void)fetchMoviesWithCompletion:(MoviesListCompletionBlock)completionBlock{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    int pageToFetch =(int)[movies count]/20 + 1;
    NSString *urlToFetch = [NSString stringWithFormat:kTMDBURLMOVIES,pageToFetch];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlToFetch parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self processResponseMoviesObject:responseObject completionBlock:completionBlock];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self errorCompletionBlock:completionBlock];
    }];
}

- (void)fetchGenres{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *urlToFetch = [NSString stringWithFormat:kTMDBURLGENRES];
    
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
        Movie *movie = [MTLJSONAdapter modelOfClass:[Movie class] fromJSONDictionary:auxDictionary error:nil];
        [movies addObject:movie];
        NSLog(@"%@",auxDictionary);
    }
    
    if ([movies count] < 50) {
        [self fetchMoviesWithCompletion:completionBlock];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            completionBlock(movies, nil);
        });
    }
}

- (void)processResponseGenresObject:(NSDictionary *)data
{
    NSArray* auxArray = [NSArray arrayWithArray:[data objectForKey:@"genres"]];
    for (NSDictionary* auxDictionary in auxArray){
        Genre *genre = [MTLJSONAdapter modelOfClass:[Genre class] fromJSONDictionary:auxDictionary error:nil];
        [genres addObject:genre];
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
