//
//  TMDUtils.m
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDUtils.h"

@implementation TMDUtils

+ (NSString*)stringFromDate:(NSDate*)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

@end
