//
//  ALXRoutesFromRouteList.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALXStopsFromRouteList : NSObject

-(void) addRouteName: (NSString*) name;
-(NSString*) getRouteNameIndex: (int) index;
-(int) getRoutesListSize;
-(void) newRoute;
+ (id)sharedRouteList;

@end
