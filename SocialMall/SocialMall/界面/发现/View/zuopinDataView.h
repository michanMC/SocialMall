//
//  zuopinDataView.h
//  SocialMall
//
//  Created by MC on 16/1/6.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faXianModel.h"
@interface zuopinDataView : UIView
@property(nonatomic,strong) faXianModel *homeModel;

@property(nonatomic,strong)UITableView*tableView;
@property (nonatomic,weak)BaseViewController *delegate;
-(void)prepareUI:(faXianModel*)model;
-(void)ActionDianzan;

@end
