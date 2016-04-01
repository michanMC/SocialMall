//
//  xinxiTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "xinxiTableViewCell.h"

@implementation xinxiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_swBtn setImage:[UIImage imageNamed:@"Switch-Off"] forState:UIControlStateNormal];
    [_swBtn setImage:[UIImage imageNamed:@"Switch-On"] forState:UIControlStateSelected];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
