//
//  ViewController.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALXTransportInformation.h"

@interface ALXViewController : UITableViewController<TransportInformationProtocol>

@property (strong, nonatomic) IBOutlet UITableView *routesTableView;

@end

