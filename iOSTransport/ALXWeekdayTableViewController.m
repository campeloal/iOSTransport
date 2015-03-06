//
//  ALXWeekdayTableViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/6/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXWeekdayTableViewController.h"

@interface ALXWeekdayTableViewController ()

@property (nonatomic) NSMutableArray *weekdays;

@end

@implementation ALXWeekdayTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _weekdays = [[NSMutableArray alloc] init];

}

-(void) viewWillAppear:(BOOL)animated
{

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
    [_weekdays addObject:row];
}

/**
 *  Update the table view
 */
-(void) updateData
{
    [_weekdaysTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _weekdays.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.weekdays objectAtIndex:indexPath.row];
    
    
    return cell;
}

@end