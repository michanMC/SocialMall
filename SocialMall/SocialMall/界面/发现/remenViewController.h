//
//  remenViewController.h
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface remenViewController : BaseViewController
@property(nonatomic,strong)NSMutableArray *dataArray;
-(void)load_Data:(BOOL)Refresh;

@end
