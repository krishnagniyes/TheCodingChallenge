//
//  TMDSessionManager.m
//  TheMovieDB
//
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDSessionManager.h"

@implementation TMDSessionManager


+ (NSURLSession *)sessionWithDefaultConfiguration {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}


+ (NSURLSession *)sessionWithEphemeralConfiguration {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}


+ (NSURLSession *)sessionWithBackgroundConfiguration {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"Background Session" ]];
}


@end
