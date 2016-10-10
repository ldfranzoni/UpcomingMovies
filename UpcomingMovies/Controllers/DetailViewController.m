//
//  DetailViewController.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/5/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface DetailViewController () <UIGestureRecognizerDelegate>{
    BOOL isFullScreen;
    CGRect prevFrame;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.movieDetailed.name;
    self.genreLabel.text = self.movieDetailed.genresString;
    self.releaseDateLabel.text = self.movieDetailed.releaseDateString;
    self.overviewTextView.text = self.movieDetailed.overviewString;

    [self.posterImageView setImageWithURL:[NSURL URLWithString:self.movieDetailed.posterUrl]];
    if ([self.movieDetailed.backgroundUrl isEqualToString:@""]) {
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.movieDetailed.posterUrl]];
    }else{
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.movieDetailed.backgroundUrl]];
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.backgroundImageView.layer.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithWhite:0.0f alpha:0.0f].CGColor,
                            (id)[UIColor colorWithWhite:0.1f alpha:0.9f].CGColor,
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:0.2f],
                               nil];

    [self.backgroundImageView.layer addSublayer:gradientLayer];
    
    [self.overviewTextView sizeToFit];
    [self.overviewTextView layoutIfNeeded];

    [self.overviewTextView setScrollEnabled:NO];
    
    isFullScreen = FALSE;
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen:)];
    tapper.numberOfTapsRequired = 1;
    [_posterImageView addGestureRecognizer:tapper];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imgToFullScreen:(UITapGestureRecognizer*)sender {
    if (!isFullScreen) {
        [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
            prevFrame = _posterImageView.frame;
            CGRect frame =[[UIScreen mainScreen] bounds];
            frame.size.height -=60;
            [_posterImageView setFrame:frame];
        }completion:^(BOOL finished){
            isFullScreen = TRUE;
        }];
        return;
    }
    else{
        [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
            [_posterImageView setFrame:prevFrame];
        }completion:^(BOOL finished){
            isFullScreen = FALSE;
        }];
        return;
    }
}

@end
