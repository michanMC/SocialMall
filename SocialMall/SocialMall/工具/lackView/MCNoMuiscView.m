//
//  MCNoMuiscView.m
//  LoveQ OCL
//
//  Created by michan on 15/3/14.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MCNoMuiscView.h"


@interface MCNoMuiscView ()
{
    
    UILabel *labelStr;
    UIImageView * image_View;
}

@end



@implementation MCNoMuiscView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;//CGRectMake(0, 0, 150,170);
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self prepareUI];
        
        
    }
    return self;
}
-(void)prepareUI{
    
    
    image_View = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 100 ) / 2, 64, 100, 100 * 174 / 152)];
    image_View.image = [UIImage imageNamed:@"关注缺省页_icon-"];
    [self addSubview:image_View];
    
    labelStr = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 + 100 * 174 / 152 + 20, Main_Screen_Width, 20)];
    labelStr.textAlignment = NSTextAlignmentCenter;
    labelStr.text = @"暂时没有好友";
    labelStr.textColor = [UIColor grayColor];
    labelStr.font = [UIFont systemFontOfSize:21];
    [self addSubview:labelStr];
    UILabel *labelStr1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 + 100 * 174 / 152 + 20 + 20 + 10, Main_Screen_Width, 20)];
    labelStr1.textAlignment = NSTextAlignmentCenter;
    labelStr1.text = @"请点击“发现”寻找好友";
    labelStr1.textColor = AppTextCOLOR;
   labelStr1.font = [UIFont systemFontOfSize:16];
    [self addSubview:labelStr1];

    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
    //[self addGestureRecognizer:tap];
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(60, 64 + 100 * 174 / 152 + 20 + 20 + 10 + 20 + 20, Main_Screen_Width - 120, 40)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:0];
    [_btn setTitle:@"前进发现" forState:0];
    [_btn setTitleColor:[UIColor whiteColor] forState:0];
    _btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
    
    
}
-(void)setLabel_Str:(NSString *)label_Str
{
    labelStr.text = label_Str;
    
}
-(void)setBtn_Str:(NSString *)btn_Str
{
    [_btn setTitle:btn_Str forState:0];
}
-(void)actionBtn{
    if (_delegate)
        [_delegate beginShouye];
}
-(void)actionTap:(UITapGestureRecognizer*)tap{
    if (_delegate)
    [_delegate beginRefresh];
    
}
-(void)setIsbtnhidden:(BOOL)isbtnhidden{
    _btn.hidden = isbtnhidden;
}
-(void)setIsImghidden:(BOOL)isImghidden{
    image_View.hidden = isImghidden;
    if (isImghidden)
    labelStr.frame = CGRectMake(labelStr.frame.origin.x, (self.frame.size.height - 20) / 2, labelStr.frame.size.width, labelStr.frame.size.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
