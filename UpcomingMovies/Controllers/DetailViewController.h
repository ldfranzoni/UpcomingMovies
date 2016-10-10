//
//  DetailViewController.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/5/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie+Representation.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (strong, nonatomic) Movie *movieDetailed;

@end
