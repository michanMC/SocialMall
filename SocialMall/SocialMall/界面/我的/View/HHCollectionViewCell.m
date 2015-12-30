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
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, (Main_Screen_Width -15)/2 , frame.size.height)];
    
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
    _titleLbl.textColor = [UIColor darkTextColor];
    [bgView addSubview:_titleLbl];
    
    
    
    y += height + 5;
    
    _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _timeLbl.font = [UIFont systemFontOfSize:13];
    _timeLbl.textColor = [UIColor lightGrayColor];
    [bgView addSubview:_timeLbl];
    
    y += height + 5;
    height = 0.5;
    lineVieww =[[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    lineVieww.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgView addSubview:lineVieww];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



@end
