//
//  MCNoMuiscView.h
//  LoveQ OCL
//
//  Created by michan on 15/3/14.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCNoMuiscViewDelgate <NSObject>

-(void)beginRefresh;
-(void)beginShouye;

@end



@interface MCNoMuiscView : UIView
@property(nonatomic,copy)NSString*label_Str;
@property(nonatomic,copy)NSString*btn_Str;

@property(nonatomic,assign)BOOL isImghidden;
@property(nonatomic,assign)BOOL isbtnhidden;
@property(nonatomic,strong)    UIButton *btn;
@property(nonatomic,weak)id<MCNoMuiscViewDelgate>delegate;
@end
