//
//  QX5TableViewCell.h
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QX5TableViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *headImgBtn;
@property (nonatomic,copy)NSString * imgStr;
@property (nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString * timeStr;
@property(nonatomic,copy)NSString * titleStr;
@end
