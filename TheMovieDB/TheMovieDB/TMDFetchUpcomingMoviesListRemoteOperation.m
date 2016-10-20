//
//  TMDFetchUpcomingMoviesListRemoteOperation.m
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDFetchUpcomingMoviesListRemoteOperation.h"
#import "TMDMovieDetails.h"
#import "TMDConstants.h"


@interface TMDFetchUpcomingMoviesListRemoteOperation()


@property (nonatomic, strong) NSMutableArray<TMDMovieDetails *> *upcomingMoviesList;


@end


@implementation TMDFetchUpcomingMoviesListRemoteOperation


- (NSMutableURLRequest *)createCustomRequest {
    self.dataDirection = outboundDirection;
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{  };
    NSData *postData =
        [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *urlString = [NSString stringWithFormat:kGetUpcomingMoviesList,kAPIKey];
    NSMutableURLRequest *request =
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                            timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    return request;
}


- (id)parseJSONData:(NSData *)data {
    NSString *jsonString = nil;
    NSError *error = nil;
    @try {
        jsonString =
            [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        return [self parseDataWithJsonObject:jsonString];
    } @catch (NSException *exception) {
        return error;
    }
    return jsonString;
}


- (id)parseDataWithJsonObject:(id)jsonObject {
    self.upcomingMoviesList = [NSMutableArray new];
    NSArray *result = [jsonObject objectForKey:@"results"];
    for (NSDictionary *dict in result) {
        TMDMovieDetails *movieDetail = [[TMDMovieDetails alloc] init];
        movieDetail.movieName = [dict objectForKey:@"original_title"];
        
        // Setting Genre id instead of genre Name..
        movieDetail.movieGenre = [self parseGenres:[dict objectForKey:@"genre_ids"]];
        //[dict objectForKey:@"original_title"];
        
        movieDetail.movieReleaseDate = [dict objectForKey:@"release_date"];
        movieDetail.moviePosterImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185_and_h278_bestv2/%@",[dict objectForKey:@"poster_path"]]];
        movieDetail.movieOverview = [dict objectForKey:@"overview"];
        [self.upcomingMoviesList addObject:movieDetail];
    }

    // Sort the movie List based on Release date.
    NSArray *sortedArray;
    sortedArray = [self.upcomingMoviesList
                   sortedArrayUsingComparator:^NSComparisonResult(TMDMovieDetails *obj1, TMDMovieDetails *obj2) {
           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
           // this is imporant - we set our input date format to match our input string
           // if format doesn't match you'll get nil from your string, so be careful
           [dateFormatter setDateFormat:@"yyyy-MM-dd"];
           NSDate * first = [dateFormatter dateFromString:[obj1 movieReleaseDate]];
           NSDate * second = [dateFormatter dateFromString:[obj2 movieReleaseDate]];
            return [first compare:second];
    }];
    return sortedArray;
}


- (NSString *)parseGenres:(NSArray *)genres {
    NSMutableString *genreString = [NSMutableString new];
    // Uncomment following lines for Genre API. - Need to discuss.

//    for (NSDictionary *dict in genres) {
//        [genreString appendString:[NSString stringWithFormat:@"%@, ", [dict   objectForKey:@"name"]]];
//    }
    
    for (int index = 0; index < genres.count; index++) {
        [genreString appendString:[NSString stringWithFormat:@"%@",genres[index]]];
        [genreString appendString:@", "];
    }
    
    return genreString;
}


@end
