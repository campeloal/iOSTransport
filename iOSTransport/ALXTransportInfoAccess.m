//
//  FlorianopolisTransport.m
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXTransportInfoAccess.h"
#import "ALXRoutesList.h"

@interface ALXTransportInfoAccess()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic,strong) NSString* contentType,*authorization;
@property (nonatomic,strong) NSString *username,*password,*url,*paramName,*paramValue;
@property (nonatomic) ALXRoutesList *routes;


@end

@implementation ALXTransportInfoAccess

- (instancetype)init
{
    self = [super init];
    if (self) {
        _username = @"WKD4N7YMA1uiM8V";
        _password = @"DtdTtzMLQlA0hk2C1Yi5pLyVIlAQ68";
        _contentType = @"application/json";
        
        _routes = [ALXRoutesList sharedRouteList];
    }
    return self;
}

/**
 *  Encode a string to the base 64.
 *
 *  @param encodeString String to be encoded
 *
 *  @return 64-encoded string
 */
-(NSString*) encodeInBase64: (NSString*) encodeString
{
    NSData *dataToEncode = [encodeString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringEncoded = [dataToEncode base64EncodedStringWithOptions:0];
    
    return stringEncoded;
}

/**
 *  Transform the username and password into the basic authorization format
 *  to be encoded.
 *
 *  @return encoded string in the right format
 */
-(NSString*) getBasicAuthorization
{
    //base64 Enconding
    NSString *authString = [NSString stringWithFormat:@"%@%@%@",_username,@":",_password];
    NSString *authEncoded = [self encodeInBase64:authString];
    
    return [NSString stringWithFormat:@"%@%@",@"Basic ",authEncoded];
}

/**
 *  Protocol's method implementation that does a post request using NSURLSession and uses
 *  JSON format. If it's necessary to implement another type of format, it's done here.
 *  This method uses global variables because it's intention is to be generic as possible.
 *  It also triggers the filtering method, to filter the data requested.
 */
-(void) postRequest
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    _authorization = [self getBasicAuthorization];
    
    config.HTTPAdditionalHeaders = @{
                                     @"Authorization" : _authorization,
                                     @"X-AppGlu-Environment"       : @"staging",
                                     @"Content-Type"  : _contentType
                                     };
    
    config.timeoutIntervalForRequest = 20;
    config.timeoutIntervalForResource = 20;
    
    _session = [NSURLSession sessionWithConfiguration:config];
    
    
    NSURL *url = [NSURL URLWithString:_url];
    NSString *params = [NSString stringWithFormat:@"%@%@%@%@%@",@"{\"params\": { \"",_paramName,@"\": \"",_paramValue,@"\" } }"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask * dataTask =[_session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
                                          
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        
        if((error == nil) && (httpResp.statusCode == 200))
        {
            NSError *jsonError;
            NSDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingAllowFragments
                                              error:&jsonError];
            
            [self performSelectorInBackground:@selector(filterInformation:) withObject:jsonInfo];
            
        }
        else
        {
            [self performSelectorInBackground:@selector(couldNotConnect) withObject:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
        
    }];
    
    [dataTask resume];

}

/**
 *  Find the routes by stop name using the post method and setting the parameters
 *  accordingly
 *
 *  @param name Stop name
 */
-(void) findRoutesByStopName:(NSString*) name
{
    _url = @"https://api.appglu.com/v1/queries/findRoutesByStopName/run";
    _paramName = @"stopName";
    _paramValue = [NSString stringWithFormat:@"%@%@%@",@"%",name,@"%"];
    
    [self postRequest];
    
}

/**
 *  Find the stops by route id using the post method and setting the parameters
 *  accordingly
 *
 *  @param routeId The route identification
 */
-(void) findStopsByRouteId: (NSString*) routeId
{
    _url = @"https://api.appglu.com/v1/queries/findStopsByRouteId/run";
    _paramName = @"routeId";
    _paramValue = routeId;
    
    [self postRequest];
}


/**
 *  Find departure by route id using the post method and setting the parameters
 *  accordingly
 *
 *  @param routeId The route identification
 */
-(void) findDepartureByRouteId: (NSString*) routeId
{
    _url = @"https://api.appglu.com/v1/queries/findDeparturesByRouteId/run";
    _paramName = @"routeId";
    _paramValue = routeId;
    
    [self postRequest];
}

/**
 *  This method receives a dictionary and filter the desired information
 *
 *  @param jsonInfo The dictionary with the info to be filtered
 */
-(void) filterInformation:(NSDictionary*) jsonInfo
{
    jsonInfo = jsonInfo[@"rows"];
    
    [_routes newRoute];

    for (NSDictionary *row in jsonInfo)
    {
        [_routes addRouteName:row[@"longName"] Id:row[@"id"]];
    }

    [_delegate newTransportInfoArrived];
    
}

/**
 *  If wasn't possible to access the data, let the user know it.
 */
-(void) couldNotConnect
{
    [_delegate couldNotConnect];
}

@end
