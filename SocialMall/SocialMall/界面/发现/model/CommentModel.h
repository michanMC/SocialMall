//
//  CommentModel.h
//  SocialMall
//
//  Created by MC on 16/1/30.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * msg_id;
@property(nonatomic,copy)NSString * comment;
@property(nonatomic,assign)long long  add_time;
@property(nonatomic,copy)NSString * total_show;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * total_fans_like;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * total_like;
@property(nonatomic,copy)NSString * total_follow;
@property(nonatomic,assign)long long last_login_time;
@property(nonatomic,copy)NSString * autograph;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * session_id;
@property(nonatomic,copy)NSString * total_fans;
@property(nonatomic,copy)NSString * history_money;
@property(nonatomic,copy)NSString * money;


@end
