//
//  ALXRoutesFromRouteList.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXStopsFromRouteList.h"
#import "ALXRoute.h"

@interface ALXStopsFromRouteList()

@property (nonatomic) NSMutableArray *routes;

@end

@implementation ALXStopsFromRouteList

/**
 *  Singleton implementation, to the same information be accessed by
 *  any class.
 *
 *  @return its instance
 */
+ (id)sharedRouteList
{
    static ALXStopsFromRouteList *sharedRoutList = nil;
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
 *  @param name           Route's name
 */
-(void) addRouteName: (NSString*) name
{
    ALXRoute *route = [[ALXRoute alloc] init];
    route.name = name;
    
    [_routes addObject:route];
}


/**
 *  It returns a route name based on index
 *
 *  @param index Route's index
 *
 *  @return Route's name
 */
-(NSString*) getRouteNameIndex: (int) index
{
    ALXRoute *route = [_routes objectAtIndex:index];
    return route.name;
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
