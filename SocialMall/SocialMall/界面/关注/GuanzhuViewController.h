//
//  GuanzhuViewController.h
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "MCBannerFooter.h"

@interface GuanzhuViewController : BaseViewController
@property (nonatomic, strong) JT3DScrollView *scrollView;
@property (nonatomic, strong) MCBannerFooter *McFooter;
@property(nonatomic,assign)NSInteger index;

@end
