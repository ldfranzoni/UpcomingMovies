//
//  UpcomingMoviesTests.m
//  UpcomingMoviesTests
//
//  Created by Luis Ojeda on 10/10/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MoviesAPI.h"
@interface UpcomingMoviesTests : XCTestCase

@end

@implementation UpcomingMoviesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [[MoviesAPI sharedInstance] fetchMoviesWithCompletion:nil];

    }];
}

@end
