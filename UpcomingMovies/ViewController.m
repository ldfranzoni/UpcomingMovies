//
//  ViewController.m
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/3/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "Movie+Representation.h"
#import "MoviesAPI.h"
#import "DetailViewController.h"
#import <AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FTIndicator.h>

@interface ViewController (){
    NSArray *moviesArray;
    NSArray *moviesFilteredArray;
}

@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Upcoming Movies",nil);

    [self setupTableView];
    [self requestMovies];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup Methods

- (void)setupTableView
{
    if (!self.refreshControl)
    {
        self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -44, 320, 50)];
        self.refreshControl.tintColor = [UIColor blackColor];
        [self.refreshControl addTarget:self action:@selector(requestMovies) forControlEvents:UIControlEventValueChanged];
        [self.moviesTableView addSubview:self.refreshControl];
    }
    if (!self.searchController) {
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        self.searchController.searchBar.barTintColor = [UIColor blackColor];
        self.searchController.searchBar.tintColor = [UIColor whiteColor];
        self.searchController.searchResultsUpdater = self;
        self.searchController.dimsBackgroundDuringPresentation = NO;
        self.searchController.searchBar.delegate = self;
        self.moviesTableView.tableHeaderView = self.searchController.searchBar;
        [self.searchController.searchBar sizeToFit];
        [self.searchController setActive:NO];
        [self.moviesTableView setContentOffset:CGPointMake(0,44) animated:YES];
    }
    
    
    self.moviesTableView.emptyDataSetSource = self;
    self.moviesTableView.emptyDataSetDelegate = self;
}

#pragma mark - Requests methods

- (void)requestMovies
{
    [FTProgressIndicator showProgressWithmessage:NSLocalizedString(@"Loading movies...",nil)];

    MoviesListCompletionBlock completionBlock = ^(NSArray* dataArray, NSString* errorString){
        [FTIndicator dismissProgress];
        if (dataArray != nil){
            moviesArray = dataArray;
            [self.moviesTableView reloadData];
        }else{
            [self showErrorConnection];
        }
    };
    
    [[MoviesAPI sharedInstance] fetchMoviesWithCompletion:completionBlock];
}


#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (![self.searchController.searchBar.text isEqualToString: @""]) {
        return [moviesFilteredArray count];
    }else{
        return [moviesArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = (MovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCellIdentifier"];

    Movie *movieCell;
    if (![self.searchController.searchBar.text isEqualToString: @""]) {
        movieCell = [moviesFilteredArray objectAtIndex:indexPath.row];
    }else{
        movieCell = [moviesArray objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = movieCell.name;
    cell.genreLabel.text = movieCell.genresString;
    cell.releaseDateLabel.text = movieCell.releaseDateString;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    [cell.posterImageView setImage:placeholderImage];
    [cell.backgroundImageView setImage:placeholderImage];
    if(![movieCell.posterUrl isEqualToString:@""]){
        [cell.posterImageView setImageWithURL:[NSURL URLWithString:movieCell.posterUrl]];
        [cell.backgroundImageView setImageWithURL:[NSURL URLWithString:movieCell.posterUrl]];
    }
    cell.posterImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.posterImageView.layer.borderWidth = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movieCell;
    if (![self.searchController.searchBar.text isEqualToString: @""]) {
        movieCell = [moviesFilteredArray objectAtIndex:indexPath.row];
    }else{
        movieCell = [moviesArray objectAtIndex:indexPath.row];
    }
    
    self.searchController.active = false;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *viewController = (DetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"detailMovieVC"];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    viewController.movieDetailed = movieCell;
    
    [self.moviesTableView reloadData];
}

#pragma mark - SearchView Methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = searchController.searchBar.text;
    if (![searchText isEqualToString:@""]) {
        moviesFilteredArray = [[MoviesAPI sharedInstance] filteredMoviesByText:searchText];
        [self.moviesTableView reloadData];
    }else{
        [self.moviesTableView reloadData];
    }
    
}

#pragma mark - EmptyDataSet Methods


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = NSLocalizedString(@"No movies found",nil);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = NSLocalizedString(@"Tap to refresh",nil);
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self requestMovies];
}


#pragma mark - Alerts Methods

- (void)showErrorConnection{
    [FTIndicator showErrorWithMessage:NSLocalizedString(@"It appears there is no internet connection, please check your connection and try it again.", nil)];
}


@end
