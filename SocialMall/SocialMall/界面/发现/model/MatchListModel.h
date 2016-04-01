//
//  MatchListModel.h
//  SocialMall
//
//  Created by MC on 16/2/16.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchListModel : NSObject
@property(nonatomic,copy)NSString * msg_id;
@property(nonatomic,copy)NSString * brand_name;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * model;//型号
@property(nonatomic,copy)NSString * brand_id;
@property(nonatomic,copy)NSString * goods_name;
@property(nonatomic,copy)NSString * goods_id;

@property(nonatomic,copy)NSString * url;

@end
