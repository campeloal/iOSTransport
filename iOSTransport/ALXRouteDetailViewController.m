//
//  ALXRouteDetailViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXRouteDetailViewController.h"
#import "ALXWeekdayTableViewController.h"
#import "ALXSaturdayTableViewController.h"
#import "ALXSundayTableViewController.h"
#import "ALXStopsFromRouteList.h"
#import "ALXDeparturesFromRoute.h"
#import "ALXRoute.h"

@interface ALXRouteDetailViewController ()

@property (nonatomic,strong) ALXTransportInfoAccess *transportInfoStops,*transportInfoDepart;
@property (nonatomic) ALXWeekdayTableViewController *weekdayVC;
@property (nonatomic) ALXSaturdayTableViewController *saturdayVC;
@property (nonatomic) ALXSundayTableViewController *sundayVC;
@property (nonatomic) ALXStopsFromRouteList *stopsFromRoute;
@property (nonatomic) ALXDeparturesFromRoute *departFromRoute;
@property (nonatomic) BOOL stopsLoaded;

@end

@implementation ALXRouteDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.title = @"Stops/Departures";
    
    //Instantiate both access for the stops and depart
    _transportInfoStops = [[ALXTransportInfoAccess alloc] initWithTransportType:STOPS_FROM_ROUTE];
    _transportInfoStops.delegate = self;
    _transportInfoDepart = [[ALXTransportInfoAccess alloc] initWithTransportType:DEPART_FROM_ROUTE];
    _transportInfoDepart.delegate = self;
    
    //Get the view controllers that represents each tab bar
    _weekdayVC = [self.viewControllers objectAtIndex:0];
    _saturdayVC = [self.viewControllers objectAtIndex:1];
    _sundayVC = [self.viewControllers objectAtIndex:2];
    
    //Singleton with the list of stops and departures
    _stopsFromRoute = [ALXStopsFromRouteList sharedRouteList];
    _departFromRoute = [ALXDeparturesFromRoute sharedRouteList];
    
    _stopsLoaded = NO;
    
    //Change to the other tabs to be able to update them
    self.selectedIndex = 1;
    self.selectedIndex = 2;
    self.selectedIndex = 0;
    
    //Set each view controller title
    _weekdayVC.routeTitle.text = _routeTitle;
    _saturdayVC.routeTitle.text = _routeTitle;
    _sundayVC.routeTitle.text = _routeTitle;
    
    //Get the stops first
    [_transportInfoStops findStopsByRouteId:_chosenRouteId];
    

}

-(void) viewWillDisappear:(BOOL)animated
{
    //Check if the back button wasl pressed
    [self backButtonPressed];
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
 *  If the back button was pressed, cancel the requests (if they are running)
 */
-(void) backButtonPressed
{
    [_transportInfoDepart cancelRequest];
    [_transportInfoStops cancelRequest];
}

/**
 *  Implementation of protocol's method. First, it fills the table view with the
 *  stops, then it will be called again and fill with the schedule
 *
 */

-(void) newTransportInfoArrived
{
    if (!_stopsLoaded)
    {
        [self fillWeekdayStops];
        [_transportInfoDepart findDepartureByRouteId:_chosenRouteId];
        _stopsLoaded = YES;
    }
    else
    {        
        [self fillWeekdaySchedule];

    }
    
}

/**
 *  Fill the view controllers' arrays with the stops and then update
 *  their table views
 */
-(void) fillWeekdayStops
{
    for (int i = 0; i < [_stopsFromRoute getRoutesListSize]; i++)
    {
        NSString *row = [_stopsFromRoute getRouteNameIndex:i];
        
        [_weekdayVC addRow:row];
        [_sundayVC addRow:row];
        [_saturdayVC addRow:row];

    }
    
    [_weekdayVC updateData];
    [_saturdayVC updateData];
    [_sundayVC updateData];
}

/**
 *  Fill the view controllers' with the schedule based on the
 *  calendar and the update their table views
 */
-(void) fillWeekdaySchedule
{
    for (int i = 0; i < [_departFromRoute getRoutesListSize]; i++)
    {
        NSString *calendar = [_departFromRoute getRouteCalendarIndex:i];
        NSString *time = [_departFromRoute getRouteTimeIndex:i];
        
        
        if ([calendar isEqualToString:@"WEEKDAY"])
        {
            [_weekdayVC addRow:time];
        }
        else if ([calendar isEqualToString:@"SATURDAY"])
        {
            [_saturdayVC addRow:time];
        }
        else if ([calendar isEqualToString:@"SUNDAY"])
        {
            [_sundayVC addRow:time];
        }
    }
    
    [_weekdayVC updateData];
    [_sundayVC updateData];
    [_saturdayVC updateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
