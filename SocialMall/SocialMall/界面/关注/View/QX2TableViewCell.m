//
//  QX2TableViewCell.m
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "QX2TableViewCell.h"

@interface QX2TableViewCell (){
    
    
    
    UILabel * _titleLbl;
}

@end

@implementation QX2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width - 20, 20)];
        _titleLbl.numberOfLines = 0;
        _titleLbl.font = AppFont;
        _titleLbl.textColor = [UIColor darkTextColor];
        [self.contentView addSubview:_titleLbl];
    }
    return self;
}
-(void)setTitleStr:(NSString *)titleStr
{
   CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 20];
    
    _titleLbl.frame = CGRectMake(10, 5, Main_Screen_Width - 20, h);
    _titleLbl.text = titleStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
