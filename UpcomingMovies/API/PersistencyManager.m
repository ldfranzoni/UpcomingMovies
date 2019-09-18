//
//  PersistencyManager.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/9/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager

- (void)saveImage:(UIImage*)image filename:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage*)getImage:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

@end
