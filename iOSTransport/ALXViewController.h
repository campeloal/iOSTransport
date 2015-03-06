//
//  ViewController.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALXTransportInfoAccess.h"

@interface ALXViewController : UITableViewController<TransportInformationDataSource>

@property (strong, nonatomic) IBOutlet UITableView *routesTableView;

@end

