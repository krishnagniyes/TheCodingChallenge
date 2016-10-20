//
//  TMDGetMovieDetailRemoteOperation.m
//  TheMovieDB
//
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDGetMovieDetailRemoteOperation.h"
#import "TMDMovieDetails.h"

@implementation TMDGetMovieDetailRemoteOperation

- (NSMutableURLRequest *)createCustomRequest {
    self.dataDirection = outboundDirection;
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{  };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/259316?api_key=e3f38e1698b0a07f2ecef0df075976ed&language=en-US"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    return request;
}


- (id)parseJSONData:(NSData *)data {
    id jsonObject = nil;
    NSError *error = nil;
    @try {
        jsonObject =
            [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        return [self parseDataWithJsonObject:jsonObject];
    } @catch (NSException *exception) {
        return error;
    }
    return jsonObject;
}


- (id)parseDataWithJsonObject:(id)jsonObject {
    if (jsonObject != nil && [jsonObject isKindOfClass:[NSDictionary class]]) {
        TMDMovieDetails *movieDetail = [[TMDMovieDetails alloc] init];
        movieDetail.movieName = [jsonObject objectForKey:@"original_title"];
        movieDetail.movieGenre = [self parseGenres:[jsonObject objectForKey:@"genres"]];
        movieDetail.movieReleaseDate = [jsonObject objectForKey:@"release_date"];
        movieDetail.moviePosterImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185_and_h278_bestv2/%@",[jsonObject objectForKey:@"poster_path"]]];
        movieDetail.movieOverview = [jsonObject objectForKey:@"overview"];
        return movieDetail;
    }
    return nil;
}


- (NSString *)parseGenres:(NSArray *)genres {
    NSMutableString *genreString = [NSMutableString new];
    for (NSDictionary *dict in genres) {
        [genreString appendString:[NSString stringWithFormat:@"%@, ", [dict objectForKey:@"name"]]];
    }
    return genreString;
}


@end
