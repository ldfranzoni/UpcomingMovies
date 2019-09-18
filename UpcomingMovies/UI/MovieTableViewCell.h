//
//  MovieTableViewCell.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end
