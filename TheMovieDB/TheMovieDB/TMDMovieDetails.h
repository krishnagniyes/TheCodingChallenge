//
//  TMDMovieDetails.h
//  TheMovieDB
//
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDCommunicationManager.h"


@interface TMDMovieDetails : NSObject


@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *movieGenre;
@property (nonatomic, copy) NSString *movieOverview;
@property (nonatomic, strong) NSURL *moviePosterImageURL;
@property (nonatomic, strong) NSString *movieReleaseDate;


@end
