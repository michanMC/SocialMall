//
//  CLAnimationView.m
//  弹出视图
//
//  Created by 李 红宝 on 16/1/16.
//  Copyright © 2016年 陈林. All rights reserved.
//

#import "CLAnimationView.h"
#import "CLView.h"
#define  HH  200
#define SCREENWIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height


@interface CLAnimationView ()
@property (nonatomic,strong) UIView *largeView;
@property (nonatomic) CGFloat count;

@property (nonatomic,strong) UIButton *chooseBtn;


@end



@implementation CLAnimationView



- (id)initWithTitleArray:(NSArray *)titlearray picarray:(NSArray *)picarray
{
    
    
    
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        self.largeView = [[UIView alloc]init];
        [_largeView  setFrame:CGRectMake(0, SCREENHEIGHT ,SCREENWIDTH,HH)];
        _largeView.backgroundColor = [UIColor whiteColor];
       // [_largeView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        [self addSubview:_largeView];
        
        __weak typeof (self) selfBlock = self;
        
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HH - 40, SCREENWIDTH, 40)];
        [_chooseBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_chooseBtn setBackgroundColor:[UIColor whiteColor]];
        [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.largeView addSubview:_chooseBtn];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
        lbl.text = @"分享这个页面";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor darkGrayColor];
        lbl.font = [UIFont systemFontOfSize:17];
        [self.largeView addSubview:lbl];

        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, HH -41, Main_Screen_Width - 20, 0.5)];
        lineView.backgroundColor =[UIColor groupTableViewBackgroundColor];
        [self.largeView addSubview:lineView];

        
        for (int i = 0; i < picarray.count; i ++) {
            CLView *rr = [[CLView alloc]initWithFrame:CGRectMake(i %4 *(SCREENWIDTH / 4),HH , SCREENWIDTH/4, 90)];
           // rr.backgroundColor = [UIColor redColor];
            rr.tag = 10 + i;
            rr.sheetBtn.tag = i + 1;
            [rr.sheetBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picarray[i]]] forState:UIControlStateNormal];
            [rr.sheetLab setText:[NSString stringWithFormat:@"%@",titlearray[i]]];
            
            [rr selectedIndex:^(NSInteger index) {
                [self dismiss];
                self.block(index);
        
            }];
            
            [self.largeView addSubview:rr];
            
            
            
        }
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:selfBlock action:@selector(dismiss)];
        [selfBlock addGestureRecognizer:dismissTap];
    }
    return self;
}

- (void)selectedWithIndex:(CLBlock)block
{
    self.block = block;
}


//- (void)btnClick:(UIButton *)btn
//{
    //self.block(self.sheetBtn.tag);
//}

//- (void)selectedIndex:(RRBlock)block
//{
    //self.block = block;
//}



- (void)CLBtnBlock:(CLBtnBlock)block
{
    self.btnBlock = block;
}


- (void)chooseBtnClick:(UIButton *)sender
{
    self.btnBlock(sender);
     [self dismiss];
}


-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    _largeView.transform = CGAffineTransformMakeTranslation(0, -HH);
    
    
    
    for (int i = 0; i < 2; i ++) {
        
        CGPoint location ;//= CGPointMake(SCREENWIDTH/4* (i%4) + (SCREENWIDTH/8) + 70, HH - 40 - 45);
        if (i == 0) {
            location = CGPointMake(SCREENWIDTH/4* (i%4) + (SCREENWIDTH/8) + 50, HH - 40 - 50);
        }
        else
        {
            location = CGPointMake(SCREENWIDTH/4* (i%4) + (SCREENWIDTH/8) + 90, HH - 40 - 50);
 
        }
        CLView *rr =  (CLView *)[self viewWithTag:10 + i];
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                rr.center=location; //CGPointMake(160, 284);
            } completion:nil];
            
        });
    }
//
//    [UIView animateWithDuration:0.2 animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        _largeView.transform = CGAffineTransformMakeTranslation(0, -HH);
//    } completion:^(BOOL finished) {
//        for (int i = 0; i < 2; i ++) {
//            
//            CGPoint location = CGPointMake(SCREENWIDTH/4* (i%4) + (SCREENWIDTH/8) + 70, 45);
//            
//            CLView *rr =  (CLView *)[self viewWithTag:10 + i];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    rr.center=location; //CGPointMake(160, 284);
//                } completion:nil];
//  
//            });
//        }
//    }];
    
    
    
}

- (void)tap:(UITapGestureRecognizer *)tapG {
    [self dismiss];
}



- (void)dismiss {
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        _largeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
