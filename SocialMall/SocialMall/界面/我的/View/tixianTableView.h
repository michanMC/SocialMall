//
//  tixianTableView.h
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tixianTableView : UITableView
+ (tixianTableView *)contentTableView;
-(void)loadData;
@property(nonatomic,strong)NSDictionary * KeyDic;

@property (nonatomic,strong) NetworkManager *requestManager;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end
