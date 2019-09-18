//
//  PersistencyManager.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/9/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Movie.h"

@interface PersistencyManager : NSObject
- (void)saveImage:(UIImage *)image filename:(NSString *)filename;
- (UIImage *)getImage:(NSString*)filename;
@end
