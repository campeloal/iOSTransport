//
//  StoredInformation.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXRoutesList.h"
#import "ALXRoute.h"

@interface ALXRoutesList()

@property (nonatomic) NSMutableArray *routes;

@end

@implementation ALXRoutesList


/**
 *  Singleton implementation, to the same information be accessed by
 *  any class.
 *
 *  @return its instance
 */
+ (id)sharedRouteList
{
    static ALXRoutesList *sharedRoutList = nil;
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
 *  @param identification Route's id
 */
-(void) addRouteName: (NSString*) name Id: (NSString*) identification
{
    ALXRoute *route = [[ALXRoute alloc] init];
    route.name = name;
    route.identification = identification;
    
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
 *  It returns a route id based on index
 *
 *  @param index Route's index
 *
 *  @return Route's id
 */
-(NSString*) getRouteIdIndex: (int) index
{
    ALXRoute *route = [_routes objectAtIndex:index];
    return route.identification;
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
