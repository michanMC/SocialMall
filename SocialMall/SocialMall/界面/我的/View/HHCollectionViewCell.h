//
//  HHCollectionViewCell.h
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhanshiModel.h"

@interface HHCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIButton* aixinBtn;
@property(nonatomic,strong)UIButton* pinglunBtn;
@property(nonatomic,copy)NSString * titleStr;
@property(nonatomic,copy)NSString * timeStr;
@property(nonatomic,copy)NSString * aixinStr;
@property(nonatomic,copy)NSString * pingluStr;
@property(nonatomic,copy)NSString * imgStr;









-(void)prepareUI:(zhanshiModel*)model;








@end
