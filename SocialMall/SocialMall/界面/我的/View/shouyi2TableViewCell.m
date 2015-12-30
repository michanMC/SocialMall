//
//  shouyi2TableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "shouyi2TableViewCell.h"

@implementation shouyi2TableViewCell

- (void)awakeFromNib {
    _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bgView.layer.borderWidth = 0.5;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
