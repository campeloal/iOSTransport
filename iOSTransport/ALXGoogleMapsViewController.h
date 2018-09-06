//
//  ALXGoogleMapsViewController.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/7/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<GoogleMaps/GoogleMaps.h>
#import <GoogleMaps/GMSGeocoder.h>

@protocol RouteFromMapDataSource

@required

-(void) routeFromMapInfo:(NSString*) route;

@end


@interface ALXGoogleMapsViewController : UIViewController<GMSMapViewDelegate>

@property (nonatomic, assign) id delegate;

@end
