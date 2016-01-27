//
//  me1TableViewCell.h
//  SocialMall
//
//  Created by MC on 15/12/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface me1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UIButton *zanbtn;

@property (weak, nonatomic) IBOutlet UIButton *fenbtn;

@property (weak, nonatomic) IBOutlet UIButton *guanBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhanBtn;



@property (weak, nonatomic) IBOutlet UIImageView *headImgview;
@property (weak, nonatomic) IBOutlet UILabel *zongshouyiLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet UILabel *dingweiLbl;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;
@property (weak, nonatomic) IBOutlet UILabel *fensiLbl;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLbl;
@property (weak, nonatomic) IBOutlet UILabel *zhanshiLbl;
@property (weak, nonatomic) IBOutlet UILabel *shoudaoZanLbl;
@property (weak, nonatomic) IBOutlet UIButton *shoudaozanBtn;
@property (weak, nonatomic) IBOutlet UILabel *qianmingLbl;

@end
