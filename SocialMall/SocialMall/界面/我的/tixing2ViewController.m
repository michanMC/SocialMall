//
//  tixing2ViewController.m
//  SocialMall
//
//  Created by MC on 16/4/1.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "tixing2ViewController.h"
#import "tixing1TableViewCell.h"
#import "tixing2TableViewCell.h"
#import "xiaoxiTXModel.h"
#import "shouyi2TableViewCell.h"
@interface tixing2ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dingdanArray;
    NSMutableArray *_zijinArray;
    NSMutableArray *_tongziArray;
    NSMutableArray *_pinglunArray;

    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSInteger _page4;

    BOOL _isdingdan;
    BOOL _iszijin;
    BOOL _istongzhi;
    BOOL _ispinglun;
    NSString * _keyStr;

}
@end

@implementation tixing2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒";
    _keyStr = @"4";//消息类型（0公告 1订单 2消息 3资金）
    //ziji 2公告 0订单 3消息 1资金
    _dingdanArray = [NSMutableArray array];
    _zijinArray = [NSMutableArray array];
    _tongziArray = [NSMutableArray array];
    _pinglunArray = [NSMutableArray array];

    [self prepareUI];

    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //ziji 2公告 0订单 3消息 1资金
   // [self loadDataorder:0 res:YES];
    [self loadDataorder:0 res:YES];

    [self loadData:1 Type:0 res:NO hideHud:NO reloadData:NO];//通知
    [self loadData:1 Type:2 res:NO hideHud:NO reloadData:NO];//评论
    [self loadData:1 Type:3 res:NO hideHud:YES reloadData:YES];//ziji

    
}
-(void)loadDataorder:(NSInteger)pagenum  res:(BOOL)isres{
    
    NSDictionary * Parameterdic = @{
                                    @"page":@(pagenum)
                                    };
    
    
    [self showLoading:isres AndText:nil];
    
    
    [self.requestManager requestWebWithGETParaWith:@"System/newOrder" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
//        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *  messageList = resultDic[@"data"][@"list"];
        
        
        for (NSDictionary * dic in messageList) {
            xiaoxiTXModel * model = [xiaoxiTXModel mj_objectWithKeyValues:dic];
            [_dingdanArray addObject:model];
            
        }
        
    
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
        
    }];
    
    
    
}

-(void)loadData:(NSInteger)pagenum Type:(NSInteger)typenum res:(BOOL)isres hideHud:(BOOL)ishideHud reloadData:(BOOL)isreloadData{
    
    [self showLoading:isres AndText:NO];
    
    NSDictionary * Parameterdic = @{
                                    @"type":@(typenum),
                                    @"page":@(pagenum)
                                    };
    //ziji 2公告 0订单 3消息 1资金

    [self.requestManager requestWebWithParaWithURL:@"User/getMessageList" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        if (ishideHud) {
            [self hideHud];
        }
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSArray *messageList = resultDic[@"data"][@"messageList"];
        
        //ziji 2公告 0订单 3消息 1资金

        
        
        for (NSDictionary * dic in messageList) {
            xiaoxiTXModel * model = [xiaoxiTXModel mj_objectWithKeyValues:dic];
            
            if (typenum == 3) {
                [_zijinArray addObject:model];
            }
            else if(typenum == 0){
                [_tongziArray addObject:model];
            }
//            else if(typenum == 1){
//                [_dingdanArray addObject:model];
//            }
            else if(typenum == 2){
                [_pinglunArray addObject:model];
            }
            
        }
        if (isreloadData) {
            [_tableView reloadData];
       }
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        
        [self hideHud];
        [self showHint:description];
        NSLog(@"失败");
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_keyStr isEqualToString:@"0"]) {
        if (section == 0) {
            return 1;
        }
        return _dingdanArray.count;
    }
    if ([_keyStr isEqualToString:@"1"]) {
        if (section == 0) {
            return 1;
        }
        return _zijinArray.count;

    }
    if ([_keyStr isEqualToString:@"2"]) {
        if (section == 0) {
            return 1;
        }
        return _tongziArray.count;

    }
    if ([_keyStr isEqualToString:@"3"]) {
        if (section == 0) {
            return 1;
        }
        return _pinglunArray.count;

    }
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_keyStr isEqualToString:@"4"]) {
        return 4;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
         return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([_keyStr isEqualToString:@"4"]) {
        return 10;

    }
    return 0.01;
    }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![_keyStr isEqualToString:@"4"]) {
        if (indexPath.section == 0) {
            return 44;
        }

    }
    if ([_keyStr isEqualToString:@"0"]) {
        return 180;

    }
    if ([_keyStr isEqualToString:@"1"]) {
        
        return 100;
        
    }
    if ([_keyStr isEqualToString:@"2"]) {
        
        return 100;
        
    }
    if ([_keyStr isEqualToString:@"3"]) {
        
        return 100;
        
    }



    
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_keyStr isEqualToString:@"4"]) {
        tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = @[@"你有新订单",@"资金变动通知",@"通知",@"评论通知"][indexPath.section];
        cell.teyImg.image = [UIImage imageNamed:@"mine_order_icon"];
        cell.jiantouimg.image = [UIImage imageNamed:@"arrow_down"];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        if(indexPath.section == 0){
        if ([[defaults objectForKey:@"Order"] isEqualToString:@"1"]) {
            cell.tixingimg.hidden = NO;
        }
        else
        {
            cell.tixingimg.hidden = YES;
            
        }
            return cell;
        }
        
        
        
       
        
        if(indexPath.section == 1){

            if ([[defaults objectForKey:@"Notice"] isEqualToString:@"1"]) {
                cell.tixingimg.hidden = NO;
            }
            else
            {
                cell.tixingimg.hidden = YES;
                
            }
            return cell;
        }
        //
        if(indexPath.section == 2){
             cell.tixingimg.hidden = YES;
            return cell;

        }
        if(indexPath.section == 3){

            if ([[defaults objectForKey:@"Comment"] isEqualToString:@"1"]) {
                cell.tixingimg.hidden = NO;
            }
            else
            {
                cell.tixingimg.hidden = YES;
                
            }
            return cell;
        }
        
//
//        
        
       return cell;
    }
    
    if (![_keyStr isEqualToString:@"4"]) {
        if (indexPath.section == 0) {
            tixing1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing1TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing1TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            if ([_keyStr isEqualToString:@"0"]) {
                cell.titleLbl.text = @"你有新订单";

            }
            if ([_keyStr isEqualToString:@"1"]) {
                cell.titleLbl.text = @"资金变动通知";
                
            }
            if ([_keyStr isEqualToString:@"2"]) {
                cell.titleLbl.text = @"通知";
                
            }
            if ([_keyStr isEqualToString:@"3"]) {
                cell.titleLbl.text = @"评论通知";
                
            }

            cell.teyImg.image = [UIImage imageNamed:@"mine_order_icon"];
            cell.jiantouimg.image = [UIImage imageNamed:@"arrow_down"];
//            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//            if ([[defaults objectForKey:@"Order"] isEqualToString:@"1"]) {
//                cell.tixingimg.hidden = NO;
//            }
//            else
//            {
               cell.tixingimg.hidden = YES;
//                
//            }
            
            return cell;

        }
        
        
        if ([_keyStr isEqualToString:@"0"]) {//订单
            
        
        if (indexPath.row < _dingdanArray.count) {
            tixing2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tixing2TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"tixing2TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            if (_dingdanArray.count > indexPath.row) {
                xiaoxiTXModel * model = _dingdanArray[indexPath.row];
                
                
                cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                cell.title1Lbl.text = [NSString stringWithFormat:@"共%@元",model.total];
                cell.title2lbl.text = model.goods_name;
                cell.dingdanLbl.text = [NSString stringWithFormat:@"订单%@",model.order_sn];
                cell.zhifulbl.text = [NSString stringWithFormat:@"订单状态:%@",model.status];
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"message_default-photo"]];
                cell.xiangqingBtn.tag = 888 + indexPath.row;
                [cell.xiangqingBtn addTarget:self action:@selector(actionxQBtn:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            
            
            return cell;
        }
        
        }
        
        if ([_keyStr isEqualToString:@"1"]) {//资金
            shouyi2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyi2TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyi2TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (_zijinArray.count > indexPath.row) {
                xiaoxiTXModel * model = _zijinArray[indexPath.row];
                cell.teyimgview.hidden =YES;
                cell.shenqingLbl.hidden = YES;
                cell.jinelbl.hidden = YES;
                
                cell.tey.text = model.title;
                cell.titleLbl.text = model.content;
                cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                
                
                
            }
            
            return cell;
        }
        if ([_keyStr isEqualToString:@"2"]) {//通知
            
            shouyi2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyi2TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyi2TableViewCell" owner:self options:nil]lastObject];
            }
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_tongziArray.count > indexPath.row) {
                xiaoxiTXModel * model = _tongziArray[indexPath.row];
                cell.teyimgview.hidden =YES;
                cell.shenqingLbl.hidden = YES;
                cell.jinelbl.hidden = YES;
                
                cell.tey.text = model.title;
                cell.titleLbl.text = model.content;
                cell.timeLbl.text = [CommonUtil getStringWithLong:[model.add_time longLongValue] Format:@"yyyy-MM-dd HH:mm"];
                
                
                
            }
            
            
            return cell;
            
            
        }
        if ([_keyStr isEqualToString:@"3"]) {
            shouyi2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyi2TableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyi2TableViewCell" owner:self options:nil]lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_pinglunArray.count > indexPath.row) {
                xiaoxiTXModel * model = _pinglunArray[indexPath.row];
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
    
    
    return [[UITableViewCell alloc]init];
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_keyStr isEqualToString:@"4"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

        _keyStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        NSLog(@">>>>>>%@",_keyStr);
        if ([_keyStr isEqualToString:@"0"]) {
            [defaults setObject:@"0" forKey:@"Order"];
            
 
        }
        if ([_keyStr isEqualToString:@"1"]) {
            [defaults setObject:@"0" forKey:@"Notice"];
            
            
        }
        if ([_keyStr isEqualToString:@"3"]) {
            [defaults setObject:@"0" forKey:@"Comment"];
            
            
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

        
    
        [_tableView reloadData];
        return;
    }
    else
    {
        if (indexPath.section == 0) {
//            if ([[NSString stringWithFormat:@"%ld",(long)indexPath.section] isEqualToString:_keyStr]) {
            
                _keyStr = @"4";
                [_tableView reloadData];
                return;
                
           // }

        }
        
        
        
    }
    
    
    
}
-(void)actionxQBtn:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:NO];
    
    [_dagteView pushDingdan];
    
    
    
    
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
