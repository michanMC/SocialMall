//
//  oadMessageModel.m
//  SocialMall
//
//  Created by MC on 16/3/9.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "oadMessageModel.h"

@implementation oadMessageModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"Order" : @"newOrder",
             @"Notice" : @"newNotice",
             @"Comment" : @"newComment",
             
             };
}
@end
