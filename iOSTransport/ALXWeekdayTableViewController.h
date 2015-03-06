//
//  ALXWeekdayTableViewController.h
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALXWeekdayTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *weekdaysTableView;
@property (strong, nonatomic) NSString *routeId;
@property (weak, nonatomic) IBOutlet UILabel *routeTitle;

-(void) addRow: (NSString*) row;
-(void) updateData;

@end
