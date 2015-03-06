//
//  TransportAPIAccess.h
//  NSURLSession
//
//  Created by Alex De Souza Campelo Lima on 3/5/15.
//  Copyright (c) 2015 Alex De Souza Campelo Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPRequestProtocol <NSObject>

@required

/**
 *  Method that does a post request
 */
-(void) postRequest;

@end

@interface ALXHTTPRequest : NSObject

@end
