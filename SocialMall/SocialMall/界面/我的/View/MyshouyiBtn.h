//
//  MyshouyiBtn.h
//  SocialMall
//
//  Created by MC on 16/1/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyshouyiBtn : UIButton
@property(nonatomic,strong)UILabel * titleSubLbl;
- (id)initWithFrame:(CGRect)frame TilteStr:(NSString*)tilteStr TilteSubStr:(NSString*)tilteSubStr TmgViewStr:(NSString*)imgViewStr;

@end
