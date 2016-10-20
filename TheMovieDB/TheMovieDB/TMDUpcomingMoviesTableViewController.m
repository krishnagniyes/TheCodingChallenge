//
//  TMDUpcomingMoviesTableViewController.m
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//


#import "TMDConstants.h"
#import "TMDCommunicationManager.h"
#import "TMDCustomMovieDetailsCell.h"
#import "TMDMovieDetails.h"
#import "TMDMovieDetailViewController.h"
#import "TMDRemoteOperation.h"
#import "TMDUpcomingMoviesTableViewController.h"
#import "TMDUtils.h"


@interface TMDUpcomingMoviesTableViewController ()


@property (nonatomic, strong)NSArray *upcomingMoviesList;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end


@implementation TMDUpcomingMoviesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Upcoming Movies";
    [self.activityIndicator startAnimating];

    TMDRemoteOperation * remoteOperation = [[TMDCommunicationManager sharedCommunicationManager] operationForType:@"tmd.operation.upcomingmovieslist"];
    [[TMDCommunicationManager sharedCommunicationManager] addRemoteOperation:remoteOperation usingCompletionHandler:^(TMDRemoteOperation *operation, NSError *error) {
        if (error != nil) {
            // Show alert
        } else {
            [self.activityIndicator stopAnimating];
            self.upcomingMoviesList = (NSArray*)operation.data;
            [self.tableView reloadData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.upcomingMoviesList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMDCustomMovieDetailsCell *cell = (TMDCustomMovieDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    TMDMovieDetails *movie = [self.upcomingMoviesList objectAtIndex:indexPath.row];
    
    cell.movieNameLabel.text = movie.movieName;
    // Need to know the API to get genre from genre ID
    cell.movieGenreLabel.text =
        [NSString stringWithFormat:@"GENRE IDs - %@",movie.movieGenre];
    //movie.movieGenre;
    cell.movieReleaseDateLabel.text = movie.movieReleaseDate;
    cell.moviePreviewLabel.text = movie.movieOverview;
    [cell.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:movie.moviePosterImageURL];
        if ( data == nil ) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData: data];
            [cell.activityIndicator stopAnimating];
            [cell setNeedsLayout];
        });
    });
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showmoviedetails"]) {
        TMDMovieDetailViewController *contoller =
            (TMDMovieDetailViewController*) [segue destinationViewController];
        contoller.movieDetail = [self.upcomingMoviesList objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    };
    
}

@end
