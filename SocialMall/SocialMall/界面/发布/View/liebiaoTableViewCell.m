//
//  liebiaoTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "liebiaoTableViewCell.h"

@interface liebiaoTableViewCell (){
    
    UILabel * _nameLbl;
    UILabel * _pinpai_mashuLbl;
   // UILabel * _mashuLbl;

    
    
    
}

@end



@implementation liebiaoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, Main_Screen_Width - 10, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _bgView.layer.borderWidth = 0.5;
        
        [self.contentView addSubview:_bgView];
        
        CGFloat x = 15;
        CGFloat y = 0;
        CGFloat width = _bgView.frame.size.width - x - 30 - 50;
        CGFloat height = 50;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.textColor = [UIColor darkTextColor];
        _nameLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLbl];
        x = _bgView.frame.size.width - 30 - 200;
        width = 200;
        //y += height + 5;
        _pinpai_mashuLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _pinpai_mashuLbl.textColor = [UIColor grayColor];
        _pinpai_mashuLbl.font = [UIFont systemFontOfSize:13];
        _pinpai_mashuLbl.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_pinpai_mashuLbl];
        _deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width -10 - 5 - 20, (50 - 20)/2, 20, 20)];
        [_deleBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:0];
        [self.contentView addSubview:_deleBtn];
        
        
    }
    
    
    return self;
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLbl.text = nameStr;
}
-(void)setMashuStr:(NSString *)mashuStr
{
    _pinpai_mashuLbl.text = mashuStr;

    if(_deleBtn.hidden)
    {
        _pinpai_mashuLbl.frame = CGRectMake(_pinpai_mashuLbl.frame.origin.x, _pinpai_mashuLbl.frame.origin.y, Main_Screen_Width - 10 - _pinpai_mashuLbl.frame.origin.x, _pinpai_mashuLbl.frame.size.height);
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
