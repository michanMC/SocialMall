//
//  MCBannerFooter.h
//  SocialMall
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ZYBannerFooterState) {
    ZYBannerFooterStateIdle = 0,    // 正常状态下的footer提示
    ZYBannerFooterStateTrigger,     // 被拖至触发点的footer提示
};

@interface MCBannerFooter : UIView
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) ZYBannerFooterState state;
@property (nonatomic, copy) NSString *idleTitle;
@property (nonatomic, copy) NSString *triggerTitle;

@end
