//
//  TMDCommunicationManager.m
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import "TMDCommunicationManager.h"
#import "Reachability.h"
#import "IGCustomAlertView.h"

@interface TMDCommunicationManager()
@property (nonatomic, strong) TMDConnectionCompletionHandler communicationCompletionBlock;

@property (strong, nonatomic) dispatch_queue_t theQueue;

@end


@implementation TMDCommunicationManager


+ (instancetype)sharedCommunicationManager {
    static TMDCommunicationManager *theSharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedInstance = [[TMDCommunicationManager alloc] init];
    });
    return theSharedInstance;
}


- (void)addRemoteOperation:(id)operation usingCompletionHandler:(RemoteOperationCommpletionHandler)completionBlock {
    
    if (![self hasConnectivity]) {
        IGCustomAlertView *alert =
            [IGCustomAlertView alertWithTitle:@"Offline"
                                      message:@"There is no internet connection"];
        [alert addButtonWithTitle:@"OK" action:^{
        }];
        [alert show];
        return;
    }
    
    __block TMDRemoteOperation *ope = operation;
    NSMutableURLRequest* request = [operation createCustomRequest];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            ope.data = [operation parseJSONData:data];
            ope.dataDirection = inboundDirection;
            if ([ope.data isKindOfClass:[NSError class]]) {
                error = ope.data;
                completionBlock(nil, error);
            }
            else {
                completionBlock(ope, nil);
            }
        }
        else {
            completionBlock(nil, error);
        }
    }];
    [dataTask resume];
}


- (void)connectUsingCompletionHandler:(TMDConnectionCompletionHandler)block {
    @try {
        self.theQueue = dispatch_queue_create("SerialQueue", NULL);
    }
    @catch (NSException *exception) {
    }
}


- (TMDRemoteOperation *)operationForType:(NSString *)type {
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"RemoteOperations"
                                                                           ofType:@"plist"];
    NSDictionary *remoteOperationsList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [[NSClassFromString([remoteOperationsList objectForKey:type]) alloc] initWithType:type];
}


- (BOOL)hasConnectivity {
    BOOL value = NO;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        value = YES;
    }

    
    return value;
}


@end
