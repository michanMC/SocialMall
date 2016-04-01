//
//  faxianCollectionViewCell.m
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "faxianCollectionViewCell.h"

@interface faxianCollectionViewCell (){
    faXianModel *_faxianmodel;
    UILabel *_titleLbl;
    
    
}

@end

@implementation faxianCollectionViewCell
-(void)prepareUI2{
    
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];

    CGRect  frame = self.contentView.frame;
   _imgView =[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 80)/2, (frame.size.height - 80)/2 - 44, 80, 80)];
    _imgView.image =[UIImage imageNamed:@"搜索-缺省页"];
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.frame.origin.y + 80 + 10, Main_Screen_Width, 20)];
    _titleLbl.textColor = AppCOLOR;
    _titleLbl.font = AppFont;
    _titleLbl.text = @"真抱歉，麻烦换一下关键词";
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLbl];

    
    
    [self.contentView addSubview:_imgView];
    
    
}

-(void)prepareUI:(faXianModel*)model{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    _faxianmodel = model;
    CGRect  frame = self.contentView.frame;

   _imgView =[[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    //imgView.image = [UIImage imageNamed:@"message_default-photo"];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        CGFloat w = model.imageSize.width;
        CGFloat h = model.imageSize.height;
        w = (Main_Screen_Width-10)/3;
        h = h * w / model.imageSize.width;
        _imgView.frame =CGRectMake(frame.origin.x, 0, w, h);
        
    }

    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"message_default-photo"]];
    
    
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES; // 裁剪边缘

    [self.contentView addSubview:_imgView];

    
    
    
}

@end
