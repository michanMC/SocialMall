//
//  faXianModel.m
//  SocialMall
//
//  Created by MC on 16/1/30.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "faXianModel.h"

@implementation like_list



@end

@implementation faXianModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _like_listArray = [NSMutableArray array];
    }
    return self;
}
-(void)addlike_listDic:(NSDictionary*)dic{
    
   like_list * model = [like_list mj_objectWithKeyValues:dic];
    
    [_like_listArray addObject:model];
}

@end
