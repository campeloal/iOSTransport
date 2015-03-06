//
//  ALXRouteDetailViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXRouteDetailViewController.h"

@interface ALXRouteDetailViewController ()

@property (nonatomic,strong) ALXTransportInfoAccess *transportInfo;

@end

@implementation ALXRouteDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _transportInfo = [[ALXTransportInfoAccess alloc] init];
    _transportInfo.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) newTransportInfoArrived
{
    
}

-(void)findStops
{
    [_transportInfo findStopsByRouteId:@"35"];
}

-(void)findDepartures
{
    [_transportInfo findDepartureByRouteId:@"17"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
