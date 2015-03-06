//
//  StoredInformation.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALXRoutesList : NSObject

-(void) addRouteName: (NSString*) name Id: (NSString*) identification;
-(NSString*) getRouteNameIndex: (int) index;
-(NSString*) getRouteIdIndex: (int) index;
-(int) getRoutesListSize;
-(void) newRoute;
+ (id)sharedRouteList;

@end
