//
//  TMDMovieDetailViewController.m
//  TheMovieDB
//
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDMovieDetailViewController.h"
#import "TMDMovieDetails.h"
#import "TMDRemoteOperation.h"
#import "TMDCommunicationManager.h"
#import "TMDConstants.h"


@interface TMDMovieDetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieOverviewLabel;


@end


@implementation TMDMovieDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    TMDRemoteOperation * remoteOperation = [[TMDCommunicationManager sharedCommunicationManager] operationForType:@"tmd.operation.getmoviewdetail"];
//    [[TMDCommunicationManager sharedCommunicationManager] addRemoteOperation:remoteOperation usingCompletionHandler:^(TMDRemoteOperation *operation, NSError *error) {
//        if (error != nil) {
//            // Show alert
//        }
//        else {
//            self.title = self.movieDetail.movieName;
//            self.movieDetail = operation.data;
//            self.movieNameLabel.text = self.movieDetail.movieName;
//            self.movieGenreLabel.text = self.movieDetail.movieGenre;
//            self.movieReleaseDateLabel.text = self.movieDetail.movieReleaseDate;
//            self.movieOverviewLabel.text = self.movieDetail.movieOverview;
//            dispatch_async(dispatch_get_global_queue(0,0), ^{
//                NSData * data = [[NSData alloc] initWithContentsOfURL:self.movieDetail.moviePosterImageURL];
//                if (data == nil) {
//                    return;
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.moviePosterImageView.image = [UIImage imageWithData: data];
//                });
//            });
//        }
//    }];

    
    if (self.movieDetail != nil) {
        self.title = self.movieDetail.movieName;
        self.movieNameLabel.text = self.movieDetail.movieName;
        self.movieGenreLabel.text = [NSString stringWithFormat:@"GENRE IDs - %@",self.movieDetail.movieGenre];
;
        self.movieReleaseDateLabel.text = self.movieDetail.movieReleaseDate;
        self.movieOverviewLabel.text = self.movieDetail.movieOverview;
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL:self.movieDetail.moviePosterImageURL];
            if (data == nil) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.moviePosterImageView.image = [UIImage imageWithData: data];
            });
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
