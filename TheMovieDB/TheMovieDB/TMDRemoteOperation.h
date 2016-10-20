//
//  TMDRemoteOperation.h
//  TheMovieDB
//
//  Created by intelliswift on 10/18/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>


// Indicate the flows of data.
// inboundDirection - returned from server
// outboundDirection - sending to the server
typedef enum TMDDataDirection {
    inboundDirection = 0,
    outboundDirection = 1
} DataDirection;

@interface TMDRemoteOperation : NSObject

@property(assign)DataDirection dataDirection;
// An operation type.
@property (copy,nonatomic) NSString *operationType;
// construct the data part according to the direction.
@property (strong, nonatomic) id responseData;
// a returned value after the operation is completed.
@property (strong, nonatomic) id returnedValue;

@property (strong, nonatomic) id data;


/**
 *Creates Custom Request.
 *@return Retuned custom formatted request.
 */
- (NSMutableURLRequest *)createCustomRequest;


/**
 *Initilizes the operation Type.
 *@param operationType Type of operation.
 *@return Subclass of Remote operation.
 */
- (id)initWithType:(NSString *)operationType;


/**
 *Parse data returned from server.
 *@param data data returned from server.
 *@return retuns formatted response data.
 */
- (id)parseJSONData:(NSData *)data;


/**
 *Parses data returned from json Object.
 *@param jsonObject data returned from server.
 *@return retuns formatted response data.
 */
- (id)parseDataWithJsonObject:(id)jsonObject;


@end
