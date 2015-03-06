//
//  ViewController.m
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXViewController.h"

@interface ALXViewController ()

@property (nonatomic,strong) ALXTransportInformation *transportInfo;
@property (strong, nonatomic) NSMutableArray *routes;

@end

@implementation ALXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _transportInfo = [[ALXTransportInformation alloc] init];
    _transportInfo.delegate = self;
    
    _routes = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)findStops
{
    [_transportInfo findStopsByRouteId:@"35"];
}

-(void)findDepartures
{
    [_transportInfo findDepartureByRouteId:@"17"];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.routes.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.routes objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO];
    [searchBar resignFirstResponder];
    [_transportInfo findRoutesByStopName:searchBar.text];
    searchBar.text = @"";
}

-(void) couldNotConnect
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"It wasn't possible to connect" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}


-(void) sendTransportInformation:(NSMutableArray *)info
{
    [_routes removeAllObjects];
    
    _routes = info;
    
    if (info.count > 0)
    {
        _routes = info;
    }
    else
    {
        [_routes addObject:@"No Results"];
    }
    
    
    [_routesTableView reloadData];
    

}


@end
