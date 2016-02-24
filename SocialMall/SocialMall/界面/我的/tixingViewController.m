//
//  tixingViewController.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "tixingViewController.h"
#import "tixing1TableViewCell.h"
#import "shouyi2TableViewCell.h"
#import "tixing2TableViewCell.h"

@interface tixingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    BOOL _isdingdan;
    
    BOOL _iszijin;

}

@end

@implementation tixingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    [self prepareUI];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self loadData];
    
}
-(void)loadData{
    
    [self showHudInView:self.view hint:nil];

    NSDictionary * Parameterdic = @{
                                    @"Type":@(2),
                                    @"Page":@(1)
                                    };
    

    
    [self.requestManager requestWebWithParaWithURL:@"User/getMessageList" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];

        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"messageList"];
//        for (NSDictionary * dic in messageList) {
//            shouyiModel * model = [shouyiModel mj_objectWithKeyValues:dic];
//            
//            [_dataArray addObject:model];
//            
//        }
//        [self reloadData];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        
        [self hideHud];
        [self showHint:description];
        NSLog(@"失败");

    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (!_isdingdan) {
            return 1;
        }
        else
        {
            return 1 + 10;
        }
    }
    if (section == 1) {
        if (!_iszijin) {
            return 1;
        }
        else
        {
            return 1 + 10;
        }
    }

    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (!_isdingdan) {
            return 44;
        }
        else
        {
            if (indexPath.row == 0) {
                return 44;
            }
            return 180;
        }
    }
    if (indexPath.section == 1) {
        if (!_iszijin) {
            return 44;
        }
        else
        {
            if (indexPath.row == 0) {
                return 44;
            }
            return 100;
        }
    }

    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{//订单
    if (indexPath.section == 0) {
        
//未展示
    if (!_isdingdan) {
    tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
    }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.titleLbl.text = @"你有新的订单";
        cell.teyImg.image = [UIImage imageNamed:@"mine_order_icon"];
        cell.jiantouimg.image = [UIImage imageNamed:@"arrow_down"];

    return cell;
    }
        //展示
        if (_isdingdan) {
            if (indexPath.row == 0) {//第一行
               
                tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
                }

                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
                cell.titleLbl.text = @"你有新的订单";
                cell.teyImg.image = [UIImage imageNamed:@"mine_order_icon"];
                cell.jiantouimg.image = [UIImage imageNamed:@"arrow_up"];
                return cell;

                
                
            }
            else
            {
                
                tixing2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing2TableViewCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing2TableViewCell" owner:self options:nil]lastObject];
                }
                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                return cell;

            }
            
        }
        
  
    }
    else
    {
    if (!_iszijin) {
        tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = @"资金变动通知";
        cell.teyImg.image = [UIImage imageNamed:@"capital_icon"];
        cell.jiantouimg.image = [UIImage imageNamed:@"arrow_down"];


        return cell;
    }
        if (_iszijin) {
            if (indexPath.row == 0) {
                tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
                }

                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
                cell.titleLbl.text = @"资金变动通知";
                cell.teyImg.image = [UIImage imageNamed:@"capital_icon"];
                cell.jiantouimg.image = [UIImage imageNamed:@"arrow_up"];
                return cell;
            }
            else
            {
                shouyi2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyi2TableViewCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyi2TableViewCell" owner:self options:nil]lastObject];
                }
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;

            }
            
        }

    }
    
return [[UITableViewCell alloc]init];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        if (!_isdingdan) {
            _isdingdan = YES;
        }
        else
        {
            if (indexPath.row == 0)
            _isdingdan = NO;
            
            
        }
  
    }
    else
    {
        if (!_iszijin) {
            _iszijin = YES;
            
            
        }
        else
        {
            if (indexPath.row == 0)
            _iszijin = NO;
        }
 
    }
    

    [tableView reloadData];
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
