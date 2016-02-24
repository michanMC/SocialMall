//
//  NSURLRequest.m
//  WebViewJS
//
//  Created by MC on 15/12/14.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "NSURLRequest+ForSSL.h"

@implementation NSURLRequest(ForSSL)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
{
    return YES;
}

+(void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host
{
    
}
@end
