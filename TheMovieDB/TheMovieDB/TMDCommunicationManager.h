//
//  TMDCommunicationManager.h
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDRemoteOperation.h"


typedef void (^TMDConnectionCompletionHandler) (NSError *error);
typedef void (^TMDRemoteOperationCommpletionHandler) (id operation, NSError *error);
typedef void (^RemoteOperationCommpletionHandler) (TMDRemoteOperation *data, NSError *error);


@interface TMDCommunicationManager : NSObject


+ (instancetype)sharedCommunicationManager;

@property (readonly, assign) BOOL isConnected;


- (void) connectUsingCompletionHandler:(TMDConnectionCompletionHandler)block;


//// Returns an appropriate operation object based on type.
- (TMDRemoteOperation *)operationForType:(NSString *)type;


- (void)addRemoteOperation:(id)operation usingCompletionHandler:(RemoteOperationCommpletionHandler)block;


@end
