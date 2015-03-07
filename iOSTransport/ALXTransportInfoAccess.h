//
//  FlorianopolisTransport.h
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALXHTTPRequest.h"
#define STOPS_FROM_ROUTE 0
#define ROUTES_FROM_STOP 1
#define DEPART_FROM_ROUTE 2

@protocol TransportInformationDataSource

@required

/**
 *  A method that warns when the data requested was accessed
 */
-(void) newTransportInfoArrived;

@optional

/**
 *  If wasn't possible to access the data, let the user know it.
 */
-(void) couldNotConnect;

@end

@interface ALXTransportInfoAccess : NSObject<HTTPRequestProtocol>

@property (nonatomic, assign) id delegate;

- (instancetype)initWithTransportType:(int) transType;
-(void) findDepartureByRouteId: (NSString*) routeId;
-(void) findStopsByRouteId: (NSString*) routeId;
-(void) findRoutesByStopName: (NSString*) name;
-(void) cancelRequest;


@end
