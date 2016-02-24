//
//  tixianTableView.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "tixianTableView.h"
#import "shouyiTableViewCell.h"
#import "shouyiModel.h"
@interface tixianTableView ()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation tixianTableView
+ (tixianTableView *)contentTableView {
    tixianTableView *contentTV = [[tixianTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    // contentTV.backgroundColor = [UIColor yellowColor];
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTV.requestManager = [NetworkManager instanceManager];
    contentTV.requestManager.needSeesion = YES;
    contentTV.dataArray = [NSMutableArray array];
    contentTV.KeyDic = @{
                         @"1":@"资金增加",
                         @"2":@"申请提现",
                         @"3":@"提现成功",
                         @"4":@"提现失败"
                         };

    return contentTV;
}
-(void)loadData{
    
    
    
    [self.requestManager requestWebWithParaWithURL:@"User/getWithdrawRecord" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"withdrawRecord"];
        for (NSDictionary * dic in messageList) {
            shouyiModel * model = [shouyiModel mj_objectWithKeyValues:dic];
            
            [_dataArray addObject:model];
            
        }
        [self reloadData];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        
        
    }];
    
    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    shouyiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyiTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyiTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count > indexPath.row) {
        shouyiModel * modle = _dataArray [indexPath.row];
        if ([modle.change_type isEqualToString:@"1"]) {
            cell.tey.text = @"收入";
            cell.jinelbl.text = [NSString stringWithFormat:@"+%@",modle.change_price];
        }
        else
        {
            cell.tey.text = @"支出";
            cell.jinelbl.text = [NSString stringWithFormat:@"-%@",modle.change_price];
            
            
        }
        
        cell.titleLbl.text = modle.cause;
        cell.shenqingLbl.text = _KeyDic[modle.change_type];
        
        cell.timeLbl.text = [CommonUtil getStringWithLong:[modle.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];//@"2016-01-04";
        
    }

    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
//-(NSInteger)numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
