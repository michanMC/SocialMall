//
//  userDatamodel.h
//  SocialMall
//
//  Created by MC on 16/2/1.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userDatamodel : NSObject
@property(nonatomic,copy)NSString * messages;//展示
@property(nonatomic,copy)NSString * receiveLikeds;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * follows;//关注
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * likeds;//赞过
@property(nonatomic,copy)NSString * autograph;//个性签名
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * fans;//粉丝
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,assign)BOOL isFans;
@property(nonatomic,copy)NSString * city;
@property(nonatomic,copy)NSString * image;

@end
