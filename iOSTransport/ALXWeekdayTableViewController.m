//
//  ALXWeekdayTableViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXWeekdayTableViewController.h"

@interface ALXWeekdayTableViewController ()

@property (nonatomic) NSMutableArray *weekdayStops;
@property (nonatomic) NSMutableArray *weekdayDepartures;

@end

@implementation ALXWeekdayTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _weekdayStops = [[NSMutableArray alloc] init];
    _weekdayDepartures = [[NSMutableArray alloc] init];

}

-(void) viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Add a row for the table view stop section
 *
 *  @param row Table view's row
 */
-(void) addRowForStop:(NSString *)row
{
    [_weekdayStops addObject:row];
}

/**
 *  Add a row for the table view departure section
 *
 *  @param row Table view's row
 */
-(void) addRowForDeparture:(NSString *)row
{
    [_weekdayDepartures addObject:row];
}


/**
 *  Update the table view
 */
-(void) updateData
{
    [_weekdaysTableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _weekdayStops.count;
    }
    else
    {
        return _weekdayDepartures.count;
    }
    
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
        cell.textLabel.text = [self.weekdayStops objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines = 2;
    }
    else
    {
        cell.textLabel.text = [self.weekdayDepartures objectAtIndex:indexPath.row];
    }
    
    
    
    return cell;
}

@end