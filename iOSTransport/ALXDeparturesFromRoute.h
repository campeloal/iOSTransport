//
//  ALXDeparturesFromRoute.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALXDeparturesFromRoute : NSObject

@property (nonatomic) NSMutableArray *routes;

-(void) addRouteCalendar: (NSString*) calendar Time: (NSString*) time;
-(NSString*) getRouteCalendarIndex: (int) index;
-(NSString*) getRouteTimeIndex: (int) index;
-(int) getRoutesListSize;
-(void) newRoute;
+ (id)sharedRouteList;

@end
