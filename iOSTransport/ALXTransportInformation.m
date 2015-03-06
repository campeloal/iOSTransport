//
//  FlorianopolisTransport.m
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import "ALXTransportInformation.h"

@interface ALXTransportInformation()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic,strong) NSString* contentType,*authorization;
@property (nonatomic,strong) NSString *username,*password,*url,*paramName,*paramValue;


@end

@implementation ALXTransportInformation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _username = @"WKD4N7YMA1uiM8V";
        _password = @"DtdTtzMLQlA0hk2C1Yi5pLyVIlAQ68";
        _contentType = @"application/json";
    }
    return self;
}

-(NSString*) encodeInBase64: (NSString*) encodeString
{
    NSData *dataToEncode = [encodeString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringEncoded = [dataToEncode base64EncodedStringWithOptions:0];
    
    return stringEncoded;
}

-(NSString*) getBasicAuthorization
{
    //base64 Enconding
    NSString *authString = [NSString stringWithFormat:@"%@%@%@",_username,@":",_password];
    NSString *authEncoded = [self encodeInBase64:authString];
    
    return [NSString stringWithFormat:@"%@%@",@"Basic ",authEncoded];
}


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
            [_delegate couldNotConnect];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
        
    }];
    
    [dataTask resume];

}


-(void) findRoutesByStopName:(NSString*) name
{
    _url = @"https://api.appglu.com/v1/queries/findRoutesByStopName/run";
    _paramName = @"stopName";
    _paramValue = [NSString stringWithFormat:@"%@%@%@",@"%",name,@"%"];
    
    [self postRequest];
    
}

-(void) findStopsByRouteId: (NSString*) routeId
{
    _url = @"https://api.appglu.com/v1/queries/findStopsByRouteId/run";
    _paramName = @"routeId";
    _paramValue = routeId;
    
    [self postRequest];
}

-(void) findDepartureByRouteId: (NSString*) routeId
{
    _url = @"https://api.appglu.com/v1/queries/findDeparturesByRouteId/run";
    _paramName = @"routeId";
    _paramValue = routeId;
    
    [self postRequest];
}

-(void) filterInformation:(NSDictionary*) jsonInfo
{
    NSMutableArray *filteredInfo = [[NSMutableArray alloc] init];
    
    jsonInfo = jsonInfo[@"rows"];

    for (NSDictionary *row in jsonInfo)
    {
        [filteredInfo addObject:row[@"longName"]];
    }

    
    
    [_delegate sendTransportInformation:filteredInfo];
    
}

-(void) test
{
    [_delegate sendTransportInformation:nil];
}

@end
