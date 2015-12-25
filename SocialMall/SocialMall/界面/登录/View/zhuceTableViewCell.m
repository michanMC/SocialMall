//
//  zhuceTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhuceTableViewCell.h"

@interface zhuceTableViewCell (){
    
    
    
    
    
}

@end


@implementation zhuceTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x  =  40;
        CGFloat width = Main_Screen_Width - 2 * x  - 80;
        CGFloat height = 44;
        CGFloat y = 0;
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _textField.font = AppFont;
        [self.contentView addSubview:_textField];
        
        
        _fasongBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 40 - 80, 0, 80, 44)];
        [_fasongBtn setTitle:@"发送验证码" forState:0 ];
        [_fasongBtn setTitleColor:[UIColor orangeColor] forState:0];
        _fasongBtn.titleLabel.font = AppFont;
        [self.contentView addSubview:_fasongBtn];
        
        
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(40, 43.5, Main_Screen_Width - 80, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
