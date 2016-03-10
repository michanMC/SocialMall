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
    
    
    
}

@end

@implementation faxianCollectionViewCell
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
