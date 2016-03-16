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
#import "xiaoxiTXModel.h"
@interface tixingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *_dingdanArray;
    NSMutableArray *_zijinArray;
    NSMutableArray *_tongziArray;

    
    
    BOOL _isdingdan;
    
    BOOL _iszijin;
    BOOL _istongzhi;

    
    
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;

    
    

}

@end

@implementation tixingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    _dingdanArray = [NSMutableArray array];
    _zijinArray = [NSMutableArray array];
    _tongziArray = [NSMutableArray array];

    [self prepareUI];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //2:zijin  0:通知
    [self loadDataorder:0 res:YES];
    
}
-(void)loadDataorder:(NSInteger)pagenum  res:(BOOL)isres{

    NSDictionary * Parameterdic = @{
                                    @"page":@(pagenum)
                                    };
    
    
    [self showLoading:isres AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/newOrder" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"list"];
        
        
        for (NSDictionary * dic in messageList) {
            xiaoxiTXModel * model = [xiaoxiTXModel mj_objectWithKeyValues:dic];
                [_dingdanArray addObject:model];
            
        }

        [self loadData:1 Type:2 res:YES];

        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
        
    }];
    


}
-(void)loadData:(NSInteger)pagenum Type:(NSInteger)typenum res:(BOOL)isres{
    
    [self showLoading:isres AndText:NO];

    NSDictionary * Parameterdic = @{
                                    @"type":@(typenum),
                                    @"page":@(pagenum)
                                    };
    
    [self.requestManager requestWebWithParaWithURL:@"User/getMessageList" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        if (typenum == 0)
        [self hideHud];

        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"messageList"];
        
        
        
        
        for (NSDictionary * dic in messageList) {
            xiaoxiTXModel * model = [xiaoxiTXModel mj_objectWithKeyValues:dic];
            if (typenum == 2) {
                [_zijinArray addObject:model];
            }
            else if(typenum == 0)
                [_tongziArray addObject:model];
            
        }
        if (typenum == 2) {
            [self loadData:1 Type:0 res:NO];
        }
        else if(typenum == 0){
            NSLog(@"%@",_tongziArray);
        [_tableView reloadData];
        }
        
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
            //return 1;
            return 1 + _dingdanArray.count;
        }
    }
    if (section == 1) {
        if (!_iszijin) {
            return 1;
        }
        else
        {
            //return 1;

            return 1 + _zijinArray.count;
        }
    }
    if (section == 2) {
        if (!_istongzhi) {
            return 1;
        }
        else
        {
            //return 1;
            
            return 1 + _tongziArray.count;
        }
    }


    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
    if (indexPath.section == 2) {
        if (!_istongzhi) {
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
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([[defaults objectForKey:@"Order"] isEqualToString:@"1"]) {
            cell.tixingimg.hidden = NO;
        }
        else
        {
            cell.tixingimg.hidden = YES;
            
        }


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
                cell.tixingimg.hidden = YES;

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
                
                if (_dingdanArray.count > indexPath.row-1) {
                    xiaoxiTXModel * model = _dingdanArray[indexPath.row-1];
                    
                    
                    cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                    cell.title1Lbl.text = [NSString stringWithFormat:@"共%@元",model.total];
                    cell.title2lbl.text = model.goods_name;
                    cell.dingdanLbl.text = [NSString stringWithFormat:@"订单%@",model.order_sn];
                    cell.zhifulbl.text = [NSString stringWithFormat:@"订单状态:%@",model.status];
                    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"message_default-photo"]];
                    cell.xiangqingBtn.tag = 888 + indexPath.row - 1;
                    [cell.xiangqingBtn addTarget:self action:@selector(actionxQBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            
                
                return cell;

            }
            
        }
        
  
    }
    else if(indexPath.section == 1)
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

        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([[defaults objectForKey:@"Notice"] isEqualToString:@"1"]) {
            cell.tixingimg.hidden = NO;
        }
        else
        {
            cell.tixingimg.hidden = YES;
            
        }

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
                cell.tixingimg.hidden = YES;

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
            
                
                if (_zijinArray.count > indexPath.row-1) {
                    xiaoxiTXModel * model = _zijinArray[indexPath.row-1];
                    cell.teyimgview.hidden =YES;
                    cell.shenqingLbl.hidden = YES;
                    cell.jinelbl.hidden = YES;

                    cell.tey.text = model.title;
                    cell.titleLbl.text = model.content;
                cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                    
                    

                }
                
                
                
                
                return cell;

            }
            
        }

    }
    else if(indexPath.section == 2)
    {
        if (!_istongzhi) {
            tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
            }
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            cell.titleLbl.text = @"通知";
            cell.teyImg.image = [UIImage imageNamed:@"capital_icon"];
            cell.jiantouimg.image = [UIImage imageNamed:@"arrow_down"];
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"Comment"] isEqualToString:@"1"]) {
                cell.tixingimg.hidden = NO;
            }
            else
            {
                cell.tixingimg.hidden = YES;
                
            }

            
            return cell;
        }
        if (_istongzhi) {
            if (indexPath.row == 0) {
                tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
                }
                
                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
                cell.titleLbl.text = @"通知";
                cell.teyImg.image = [UIImage imageNamed:@"capital_icon"];
                cell.jiantouimg.image = [UIImage imageNamed:@"arrow_up"];
                cell.tixingimg.hidden = YES;

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
                if (_tongziArray.count > indexPath.row-1) {
                    xiaoxiTXModel * model = _tongziArray[indexPath.row-1];
                    cell.teyimgview.hidden =YES;
                    cell.shenqingLbl.hidden = YES;
                    cell.jinelbl.hidden = YES;
                    
                    cell.tey.text = model.title;
                    cell.titleLbl.text = model.content;
                    cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                    
                    
                    
                }
                

                return cell;
                
            }
            
        }
        
    }

    
return [[UITableViewCell alloc]init];
    
}
-(void)actionxQBtn:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:NO];

    [_dagteView pushDingdan];
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    
    if (indexPath.section == 0) {
        [defaults setObject:@"0" forKey:@"Order"];

        if (!_isdingdan) {
            _isdingdan = YES;
        }
        else
        {
            if (indexPath.row == 0)
            _isdingdan = NO;
            
            
        }
  
    }
    else if (indexPath.section == 1)
    {
        [defaults setObject:@"0" forKey:@"Notice"];

        if (!_iszijin) {
            _iszijin = YES;
            
            
        }
        else
        {
            if (indexPath.row == 0)
            _iszijin = NO;
        }
 
    }
    else if (indexPath.section == 2)
    {
        [defaults setObject:@"0" forKey:@"Comment"];

        if (!_istongzhi) {
            _istongzhi = YES;
            
            
        }
        else
        {
            if (indexPath.row == 0)
                _istongzhi = NO;
        }
        
    }
    [defaults synchronize];

    
    BOOL isdingdan = NO;
    
    if ([[defaults objectForKey:@"Comment"] isEqualToString:@"1"]) {
       isdingdan = YES;
    }
    if ([[defaults objectForKey:@"Notice"] isEqualToString:@"1"]) {
        isdingdan = YES;
    }
    if ([[defaults objectForKey:@"Order"] isEqualToString:@"1"]) {
        isdingdan = YES;
    }
    if (!isdingdan) {
        [defaults setObject:@"0" forKey:@"isdingdan"];
        [defaults synchronize];
        [self.tabBarController.tabBar hideBadgeOnIte4Index:4];
        [_dagteView loadCell];
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
