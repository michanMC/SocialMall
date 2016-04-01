//
//  Fabu7TableViewCell.m
//  SocialMall
//
//  Created by MC on 16/3/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Fabu7TableViewCell.h"

@implementation Fabu7TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _view1.layer.borderWidth = .5;
    
    _view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _view2.layer.borderWidth = .5;
    _view3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _view3.layer.borderWidth = .5;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
