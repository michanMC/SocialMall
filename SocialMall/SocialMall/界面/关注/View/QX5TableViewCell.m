//
//  QX5TableViewCell.m
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "QX5TableViewCell.h"
#import "UIButton+WebCache.h"
@interface QX5TableViewCell (){
    
    UILabel *_nameLbl;
    UILabel *_timeLbl;
    
    UILabel *_titleLbl;
    UIView * _lineView;
}
@end

@implementation QX5TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat width = 28;
        CGFloat height = 28;
        _headImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y,width , height)];
        [_headImgBtn setImage:[UIImage imageNamed:@"Avatar_46"] forState:0];
        [self.contentView addSubview:_headImgBtn ];
        
        
        x +=width + 10;
        width = Main_Screen_Width - x - 100;
        height = 20;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.text = @"michan";
        _nameLbl.textColor = [UIColor darkGrayColor];
        _nameLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLbl];
        
        
        
        x = Main_Screen_Width - 10 - 90;
        width = 90;
        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _timeLbl.text = @"2016.01.01";
        _timeLbl.textAlignment = NSTextAlignmentRight;
        _timeLbl.textColor = [UIColor darkGrayColor];
        _timeLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeLbl];
        

        x = 10 + 28 + 10;
        y +=height+ 10;//40
        width = Main_Screen_Width - 10 - x;
        height = 20;
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.numberOfLines = 0;
        _titleLbl.textColor = [UIColor darkTextColor];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLbl];
        y += height;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(x,y , width, 0.5)];//40 + 20 + 10 + .5
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_lineView];
        
    }
    
    
    return self;
}
-(void)setTimeStr:(NSString *)timeStr{
    _timeLbl.text = timeStr;
}
-(void)setTitleStr:(NSString *)titleStr
{
    CGFloat h = [MCIucencyView heightForString:titleStr fontSize:14 andWidth:Main_Screen_Width - 10 - 48];
    _titleLbl.text = titleStr;
    _titleLbl.frame = CGRectMake(_titleLbl.frame.origin.x, _titleLbl.frame.origin.y, _titleLbl.frame.size.width, h);
    _lineView.frame = CGRectMake(_titleLbl.frame.origin.x,_titleLbl.frame.origin.y + h + 10 , _titleLbl.frame.size.width + 10, 0.5);
    
    
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLbl.text = nameStr;
}
-(void)setImgStr:(NSString *)imgStr
{
    [_headImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_46"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
