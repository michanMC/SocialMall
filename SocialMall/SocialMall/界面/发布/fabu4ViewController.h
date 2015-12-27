//
//  fabu4ViewController.h
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"

@protocol fabu4Viewdelegate <NSObject>

-(void)backDic:(NSDictionary*)dic;

@end


@interface fabu4ViewController : BaseViewController
@property(nonatomic,weak)id<fabu4Viewdelegate>delegate;
@end
