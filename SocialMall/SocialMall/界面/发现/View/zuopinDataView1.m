//
//  zuopinDataView1.m
//  SocialMall
//
//  Created by MC on 16/1/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zuopinDataView1.h"

@implementation zuopinDataView1

- (void)awakeFromNib {
    // Initialization code
    ViewRadius(_guanzhuBtn, 5);
    _guanzhuBtn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
    _guanzhuBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
