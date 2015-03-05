//
//  ViewController.m
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ViewController.h"
#import "TransportAccess.h"

@interface ViewController ()

@property (nonatomic,strong) TransportAccess *transportAcc;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic,strong) NSString *street;
@property (nonatomic,strong) NSString* contentType,*authorization;
@property (nonatomic,strong) NSString *username,*password,*url,*paramName,*paramValue;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _transportAcc = [[TransportAccess alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)findRoutes:(id)sender
{
    [_transportAcc findRoutesByStopName:@"lauro linhares"];
    
}

-(IBAction)findStops:(id)sender
{
    [_transportAcc findStopsByRouteId:@"35"];
}

-(IBAction)findDepartures:(id)sender
{
    [_transportAcc findDepartureByRouteId:@"17"];
}

@end
