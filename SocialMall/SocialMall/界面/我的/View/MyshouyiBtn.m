//
//  MyshouyiBtn.m
//  SocialMall
//
//  Created by MC on 16/1/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyshouyiBtn.h"

@implementation MyshouyiBtn
- (id)initWithFrame:(CGRect)frame TilteStr:(NSString*)tilteStr TilteSubStr:(NSString*)tilteSubStr TmgViewStr:(NSString*)imgViewStr

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat width = 25;
        CGFloat height = 25;

        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        imgView.image =[UIImage imageNamed:imgViewStr];
        [self addSubview:imgView];
        x+=width + 5;
        width = frame.size.width - x;
    
        
        UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        titleLbl.text = tilteStr;
        titleLbl.textColor = [UIColor darkGrayColor];
        titleLbl.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLbl];
        x = 0;
        y = 60 - height;
        width = Main_Screen_Width / 3;
        UILabel * titleSubLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        titleSubLbl.text =tilteSubStr;
        titleSubLbl.textColor = [UIColor darkGrayColor];
        titleSubLbl.font = [UIFont systemFontOfSize:13];
        titleSubLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleSubLbl];

        
        
    }
    
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
