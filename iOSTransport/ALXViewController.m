//
//  ViewController.m
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXViewController.h"
#import "ALXRouteDetailViewController.h"
#import "ALXRoutesList.h"

@interface ALXViewController ()

@property (nonatomic,strong) ALXTransportInfoAccess *transportInfo;
@property (strong, nonatomic) NSMutableArray *routes;
@property (nonatomic) ALXRoutesList *routesList;

@end

@implementation ALXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _transportInfo = [[ALXTransportInfoAccess alloc] init];
    _transportInfo.delegate = self;
    
    _routes = [[NSMutableArray alloc] init];
    _routesList = [ALXRoutesList sharedRouteList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Implementation of protocol's method that warns that wasn't possible to
 *  request the data
 */
-(void) couldNotConnect
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"It wasn't possible to connect" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

/**
 *  Implementation of protocol's method that warns that the information
 *  is available
 */
-(void) newTransportInfoArrived
{
    [_routes removeAllObjects];
    
    int routesListSize = [_routesList getRoutesListSize];
    
    if (routesListSize > 0)
    {
        for (int i = 0; i < [_routesList getRoutesListSize]; i++)
        {
            [_routes addObject:[_routesList getRouteNameIndex:i]];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Not Found" message:@"It wasn't possible to find a route" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    
    [_routesTableView reloadSections:[NSIndexSet indexSetWithIndex:0 ] withRowAnimation: UITableViewRowAnimationAutomatic];
    

}

#pragma mark - Search bar

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

#pragma mark - Table view data source

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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showRouteDetail" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showRouteDetail"])
    {
        
        //ALXRouteDetailViewController *detail = (ALXRouteDetailViewController*)[segue destinationViewController];
        
        //NSIndexPath *index = [self.routesTableView indexPathForSelectedRow];
        

    
    }
}


@end
