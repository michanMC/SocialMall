//
//  NSURLRequest.h
//  WebViewJS
//
//  Created by MC on 15/12/14.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (ForSSL)

+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

+(void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;

@end
