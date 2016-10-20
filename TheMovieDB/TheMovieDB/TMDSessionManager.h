//
//  TMDSessionManager.h
//  TheMovieDB
//
//  Created by intelliswift on 10/19/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TMDSessionManager : NSObject


+ (NSURLSession *)sessionWithDefaultConfiguration;
+ (NSURLSession *)sessionWithEphemeralConfiguration;
+ (NSURLSession *)sessionWithBackgroundConfiguration;


@end
