//
//  faXianModel.h
//  SocialMall
//
//  Created by MC on 16/1/30.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface like_list : NSObject
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimgurl;


@end




@interface faXianModel : NSObject
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * msg_id;

@property(nonatomic,strong)NSArray * like_list;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * image;
@property(nonatomic,copy)NSString * add_time;
@property(nonatomic,copy)NSString * style_id;
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * comments;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * like;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * style_name;
@property(nonatomic,assign)BOOL isFans;
@property(nonatomic,assign)BOOL islike;



@property(nonatomic,strong)NSMutableArray *like_listArray;


-(void)addlike_listDic:(NSDictionary*)dic;
@end
