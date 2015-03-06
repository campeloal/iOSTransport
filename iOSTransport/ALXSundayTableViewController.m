//
//  ALXSundayTableViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXSundayTableViewController.h"

@interface ALXSundayTableViewController ()

@property (nonatomic) NSMutableArray *sundays;

@end

@implementation ALXSundayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sundays = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Add a row for the table view
 *
 *  @param row Table view's row
 */
-(void) addRow:(NSString *)row
{
    [_sundays addObject:row];
}

/**
 *  Update the table view
 */
-(void) updateData
{
    [_sundayTableView reloadSections:[NSIndexSet indexSetWithIndex:0 ] withRowAnimation: UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sundays.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.sundays objectAtIndex:indexPath.row];
    
    
    return cell;
}

@end
