//
//  HHCollectionViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "HHCollectionViewCell.h"
#import "MCbackButton.h"
@interface HHCollectionViewCell ()
{
    UILabel *_titleLbl;
    UILabel *_timeLbl;
    UIImageView * _imgView;
    
    
    
    
}

@end

@implementation HHCollectionViewCell
-(void)prepareUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];

    
    CGRect  frame = self.contentView.frame;
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, (Main_Screen_Width -15)/2 , frame.size.height - 5)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bgView.layer.borderWidth = 0.5;
    
    [self.contentView addSubview:bgView];
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.width)];
    _imgView.image = [UIImage imageNamed:@"releaes_default-photo"];
    [bgView addSubview:_imgView];
    CGFloat x = 0;
    CGFloat y = bgView.frame.size.width;
    CGFloat width = bgView.frame.size.width;
    CGFloat height = 0.5;
    UIView *lineVieww =[[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineVieww.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:lineVieww];
    
    
    y+= height + 5;
    height = 20;
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    
    _titleLbl.text = @"民族风可爱";
    _titleLbl.font = AppFont;
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    _titleLbl.textColor = [UIColor darkTextColor];
    [bgView addSubview:_titleLbl];
    
    
    
    y += height + 5;
    
    _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x+5, y, width - 5, height)];
    _timeLbl.font = [UIFont systemFontOfSize:13];
    _timeLbl.textColor = [UIColor lightGrayColor];
    _timeLbl.text = @"2016-01-04";
    [bgView addSubview:_timeLbl];
    
    y += height + 5;
    height = 0.5;
    lineVieww =[[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineVieww.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:lineVieww];
    
    
    x = width/2;
    width = 0.5;
    height =frame.size.height- y - 5;
    lineVieww =[[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineVieww.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:lineVieww];

    
   
    width = bgView.frame.size.width/2;
    x = 0;
    _aixinBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_aixinBtn setImage:[UIImage imageNamed:@"favorite_icon_normal"] forState:UIControlStateNormal];
    [_aixinBtn setTitle:@"10" forState:UIControlStateNormal];
    _aixinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_aixinBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [bgView addSubview:_aixinBtn];
    
    x += width;
    _pinglunBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_pinglunBtn setImage:[UIImage imageNamed:@"comment_icon_normal"] forState:UIControlStateNormal];
    [_pinglunBtn setTitle:@"10" forState:UIControlStateNormal];
    _pinglunBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_pinglunBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [bgView addSubview:_pinglunBtn];

    
    
    
    
    
}
-(void)setTimeStr:(NSString *)timeStr
{
    _timeLbl.text = timeStr;
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleLbl.text = titleStr;
}
-(void)setAixinStr:(NSString *)aixinStr
{
    [_aixinBtn setTitle:aixinStr forState:UIControlStateNormal];
 
    
}
-(void)setPingluStr:(NSString *)pingluStr{
    [_pinglunBtn setTitle:pingluStr forState:UIControlStateNormal];
 
}
-(void)setImgStr:(NSString *)imgStr
{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"releaes_default-photo"]];
}
@end
