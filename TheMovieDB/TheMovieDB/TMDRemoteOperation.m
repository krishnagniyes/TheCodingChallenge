//
//  TMDRemoteOperation.m
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//


#import "TMDRemoteOperation.h"


@implementation TMDRemoteOperation
// Custom Request
// Child class will have to override createRequest() method to customize the request
- (NSMutableURLRequest *)createCustomRequest {
    self.dataDirection = outboundDirection;
    return nil;
}


- (id)parseData:(NSData *)data {
    return nil;
}


- (id) initWithType:(NSString *)operationType {
    self.operationType = operationType;
    return self;
}


- (id)parseJSONData:(NSData *)data {
    return nil;
}


- (id)parseDataWithJsonObject:(id)jsonObject {
    return nil;
}


@end
