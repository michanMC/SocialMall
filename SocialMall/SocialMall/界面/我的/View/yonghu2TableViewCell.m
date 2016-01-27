//
//  yonghu2TableViewCell.m
//  SocialMall
//
//  Created by MC on 16/1/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "yonghu2TableViewCell.h"

@implementation yonghu2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 20, 120)];
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 0.5;
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        lbl.textColor = [UIColor darkTextColor];
        lbl.text = @"个性签名:";
        lbl.font = [UIFont systemFontOfSize:14];
        [view addSubview:lbl];
        
        _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, 30, Main_Screen_Width - 40, 120 - 30 - 10)];
      //  _textView.placeholder = @"天昔日";
        _textView.textColor = [UIColor darkTextColor];
        _textView.font = AppFont;
        [view addSubview:_textView];
        [self.contentView addSubview:view];
        
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
