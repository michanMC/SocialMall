//
//  yonghuTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "yonghuTableViewCell.h"

@implementation yonghuTableViewCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bgView.layer.borderWidth = 0.5;
    
    [_nvBtn setImage:[UIImage imageNamed:@"female_icon_not-selected"] forState:UIControlStateNormal];
    [_nvBtn setImage:[UIImage imageNamed:@"female_icon_selected"] forState:UIControlStateSelected];
    [_nanBtn setImage:[UIImage imageNamed:@"male_icon_not-selected"] forState:UIControlStateNormal];
    [_nanBtn setImage:[UIImage imageNamed:@"male_icon_selected"] forState:UIControlStateSelected];

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
