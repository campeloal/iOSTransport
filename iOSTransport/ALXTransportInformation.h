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

@protocol TransportInformationProtocol

@required

-(void) sendTransportInformation: (NSMutableArray*) info;

@optional
-(void) couldNotConnect;

@end

@interface ALXTransportInformation : NSObject<HTTPRequestProtocol>

@property (nonatomic, assign) id delegate;

-(void) findDepartureByRouteId: (NSString*) routeId;
-(void) findStopsByRouteId: (NSString*) routeId;
-(void) findRoutesByStopName: (NSString*) name;
-(void) test;


@end
