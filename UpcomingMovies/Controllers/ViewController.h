//
//  ViewController.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+EmptyDataSet.h>

@interface ViewController : UITableViewController <UISearchResultsUpdating,UISearchBarDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

