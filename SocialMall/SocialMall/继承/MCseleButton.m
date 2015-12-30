//
//  MCseleButton.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MCseleButton.h"

@implementation MCseleButton
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
       // self.titleLabel.font=[UIFont systemFontOfSize:10.0];
        //self.titleLabel.adjustsFontSizeToFitWidth = YES;
       // self.imageView.contentMode=UIViewContentModeCenter;
        
    }
    
    return self;
    
}
//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = contentRect.origin.x;
    
    CGFloat titleY = contentRect.origin.y ;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}
//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    CGFloat imageX = (contentRect.size.width - 40) / 2;

    CGFloat imageW = 40;
    
    CGFloat imageH = 2;
    
    
    CGFloat imageY = contentRect.size.height - 2 ;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
