//
//  ALXDeparturesFromRoute.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXDeparturesFromRoute.h"
#import "ALXRoute.h"

@interface ALXDeparturesFromRoute()


@end

@implementation ALXDeparturesFromRoute

/**
 *  Singleton implementation, to the same information be accessed by
 *  any class.
 *
 *  @return its instance
 */
+ (id)sharedRouteList
{
    static ALXDeparturesFromRoute *sharedRoutList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRoutList = [[self alloc] initPrivate];
    });
    return sharedRoutList;
}

/**
 *  Private instantiation (Singleton implementation)
 *
 *  @return its instance
 */
- (instancetype) initPrivate
{
    if (self = [super init])
    {
        _routes = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  Since it follows a Singleton pattern, if it's a new set of
 *  routes, remove the old ones.
 */
-(void) newRoute
{
    [_routes removeAllObjects];
}

/**
 *  It adds a new route
 *
 *  @param calendar           Route's calendar
 *  @param time Route's time
 */
-(void) addRouteCalendar:(NSString *)calendar Time:(NSString *)time
{
    ALXRoute *route = [[ALXRoute alloc] init];
    route.calendar = calendar;
    route.time = time;
    
    [_routes addObject:route];
}


/**
 *  It returns a route name based on index
 *
 *  @param index Route's index
 *
 *  @return Route's name
 */
-(NSString*) getRouteCalendarIndex:(int)index
{
    ALXRoute *route = [_routes objectAtIndex:index];
    return route.calendar;
}

/**
 *  It returns a route id based on index
 *
 *  @param index Route's index
 *
 *  @return Route's id
 */
-(NSString*) getRouteTimeIndex:(int)index
{
    ALXRoute *route = [_routes objectAtIndex:index];
    return route.time;
}

/**
 *  It returns the list of routes size
 *
 *  @return Routes size
 */
-(int) getRoutesListSize
{
    return (int) _routes.count;
}


@end
