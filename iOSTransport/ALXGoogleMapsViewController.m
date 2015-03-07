//
//  ALXGoogleMapsViewController.m
//  iOSTransport
//
//  Created by Alex De Souza Campelo Lima on 3/7/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXGoogleMapsViewController.h"

@interface ALXGoogleMapsViewController ()

@property (nonatomic) GMSMapView *mapView;
@property (nonatomic) GMSMarker *marker;
@property (nonatomic) GMSGeocoder *geocoder;
@property (nonatomic) NSString *route;
@property (nonatomic) BOOL infoProcessed;

@end

@implementation ALXGoogleMapsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set camera on Florianopolis
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-27.590968
                                                            longitude: -48.521780
                                                                 zoom:18];
    
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera: camera];
    
    
    self.view = _mapView;
    _mapView.delegate = self;
    _mapView.mapType = kGMSTypeNormal;
    
    _marker = [[GMSMarker alloc] init];
    _geocoder = [[GMSGeocoder alloc] init];
    
    _infoProcessed = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStylePlain target:self action:@selector(sendRoute)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
    //If the user pressed the back button, stop indicator
    if (!_infoProcessed)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark - Google maps delegate
-(void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    _infoProcessed = NO;
    
    //Creates a marker at tap position
    _marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    _marker.title = @"Desired Route";
    _marker.map = _mapView;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_geocoder reverseGeocodeCoordinate:coordinate completionHandler: ^(GMSReverseGeocodeResponse *response, NSError *error)
     {
         
         NSString *address = response.firstResult.thoroughfare;
         
         [self filterAddress:address];
         
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         
         _infoProcessed = YES;
         
     }];
}

/**
 *  Filter the street or avenue name
 *  Format: NNNN R. Street name  Or NNNN Av. Avenue name
 *
 *  @param address Complete Adress
 */
-(void) filterAddress:(NSString*) address
{
    if (address.length > 0)
    {
        
        NSString *expression = [NSString stringWithFormat:@"R. | Av. "];
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSArray *matches = [regex matchesInString:address
                                          options:0
                                            range:NSMakeRange(0, [address length])];
        
        if (matches.count > 0)
        {
            //There's gonna be one match because it's one street or one avenue
            NSRange matchRange = [matches[0] range];
            _route = [address substringFromIndex:matchRange.location + matchRange.length];
            
        }
    }
}


/**
 *  Send the route information back to the main controller
 */
- (void)sendRoute
{
    if (_infoProcessed)
    {
        [_delegate routeFromMapInfo:_route];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Information Available" message:@"Still processing the information or no information received" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
}


@end
