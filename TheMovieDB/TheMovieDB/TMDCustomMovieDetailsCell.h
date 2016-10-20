//
//  TMDCustomMovieDetailsCell.h
//  TheMovieDB
//  This class is used to show the movie details on UItableView 
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMDCustomMovieDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieOverviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *moviePreviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;

@end
