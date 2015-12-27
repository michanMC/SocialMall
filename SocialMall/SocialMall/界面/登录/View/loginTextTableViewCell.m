//
//  loginTextTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/22.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "loginTextTableViewCell.h"

@interface loginTextTableViewCell ()
{
    
    
    
    
}

@end


@implementation loginTextTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x  =  45;
        CGFloat width = 22;
        CGFloat height = 22;
        CGFloat y = (44 - width)/2;
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [self.contentView addSubview:_imgView];
        
        
        x += width + 5;
        width = Main_Screen_Width - x - 40;
        y = 2;
        height = 40;
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _textField.font = AppFont;
        [self.contentView addSubview:_textField];

        
       _lineView = [[UIView alloc]initWithFrame:CGRectMake(40, 43.5, Main_Screen_Width - 80, 0.5)];
        _lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineView];
        
        
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
