//
//  ALXSundayTableViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXSundayTableViewController.h"

@interface ALXSundayTableViewController ()

@property (nonatomic) NSMutableArray *sundayStops;
@property (nonatomic) NSMutableArray *sundayDepartures;

@end

@implementation ALXSundayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sundayStops = [[NSMutableArray alloc] init];
    _sundayDepartures = [[NSMutableArray alloc] init];
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
-(void) addRowForStop:(NSString *)row
{
    [_sundayStops addObject:row];
}

/**
 *  Add a row for the table view departure section
 *
 *  @param row Table view's row
 */
-(void) addRowForDeparture:(NSString *)row
{
    [_sundayDepartures addObject:row];
}

/**
 *  Update the table view
 */
-(void) updateData
{
    [_sundayTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Stops";
    }
    else
    {
        return @"Departures";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return _sundayStops.count;
    }
    else
    {
        return _sundayDepartures.count;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [self.sundayStops objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines = 2;
    }
    else
    {
        cell.textLabel.text = [self.sundayDepartures objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

@end
