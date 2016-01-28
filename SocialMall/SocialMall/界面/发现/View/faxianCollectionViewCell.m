//
//  faxianCollectionViewCell.m
//  SocialMall
//
//  Created by MC on 16/1/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "faxianCollectionViewCell.h"

@implementation faxianCollectionViewCell
-(void)prepareUI{
    for (UIView* obj in self.contentView.subviews)
        [obj removeFromSuperview];
    CGRect  frame = self.contentView.frame;

    UIImageView * imgView =[[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
    imgView.image = [UIImage imageNamed:@"message_default-photo"];
  
    [self.contentView addSubview:imgView];

    
    
    
}

@end
