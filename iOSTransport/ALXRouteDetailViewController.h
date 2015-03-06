//
//  ALXRouteDetailViewController.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALXTransportInfoAccess.h"

@interface ALXRouteDetailViewController : UITabBarController<UITabBarControllerDelegate,TransportInformationDataSource>

@property (nonatomic) NSString* chosenRouteId;
@property (nonatomic) NSString* routeTitle;

@end
