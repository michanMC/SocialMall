//
//  MeViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MeViewController.h"
#import "me1TableViewCell.h"
#import "me2TableViewCell.h"
#import "me3TableViewCell.h"
#import "settgViewController.h"
#import "yonghuViewController.h"
#import "MyshouyiViewController.h"
#import "tixingViewController.h"
#import "FenGuanViewController.h"
#import "zhanshiViewController.h"
#import "me4TableViewCell.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_titleArray;
    NSArray *_imgArray;

    
    
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"我的收益",@"收货地址管理",@"消息提醒",@"我的收藏",@"我的订单"];
    _imgArray = @[@"income_icon",@"mine_address_icon",@"mine_message_icon",@"mine_collect_icon",@"mine_order_icon"];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_set-up_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionrightBar)];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
}
-(void)ActionrightBar{
    settgViewController * ctl = [[settgViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section== 0)
    return 10;
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 240;
    }
//    if (indexPath.section == 1) {
//        return 44;
//    }
//    if (indexPath.section == 2) {
//        return 126;
//    }
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
       
        return 1;
    }
    return 5;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {//头
        me1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me1TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headBtn.tag = 2000;
        cell.zanbtn.tag = 2001;
        cell.fenbtn.tag = 2002;
        cell.guanBtn.tag = 2003;
        cell.zhanBtn.tag = 2004;
        cell.shoudaozanBtn.tag = 2005;
        [cell.headBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zanbtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fenbtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.guanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shoudaozanBtn addTarget:self action:@selector(actionCell1:) forControlEvents:UIControlEventTouchUpInside];

        
        
        
        
        
        return cell;

    }
     if (indexPath.section == 1) {
         
         me4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me4TableViewCell"];
         if (!cell) {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"me4TableViewCell" owner:self options:nil]lastObject];
         }
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         cell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
         cell.tiltleLbl.text = _titleArray[indexPath.row];
         return cell;
         
         
         
     }
    
    /*弃用
    if (indexPath.section == 1) {
        
        
        
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me2TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me2TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.shouyiBtn.tag = 3000;
        cell.quanbuBtn.tag = 3001;
        cell.shouruBtn.tag = 3002;
        cell.tixianBtn.tag = 3003;
        
        [cell.shouyiBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.quanbuBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shouruBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tixianBtn addTarget:self action:@selector(actionCell2:) forControlEvents:UIControlEventTouchUpInside];

        
        
        
        
        
        return cell;
    }
    if (indexPath.section == 2) {
        me3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me3TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me3TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.shouhuoBtn.tag = 4000;
        cell.tixingBtn.tag = 4001;
        cell.shouchangBtn.tag = 4002;
        cell.dingdanBtn.tag = 4003;
        [cell.shouhuoBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tixingBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shouchangBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dingdanBtn addTarget:self action:@selector(actionCell3:) forControlEvents:UIControlEventTouchUpInside];

        
        return cell;

    }
     */
    return [[UITableViewCell alloc]init];

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //收益
            MyshouyiViewController * ctl = [[MyshouyiViewController alloc]init];
            [self pushNewViewController:ctl];

        }
        if (indexPath.row == 1) {
            //收货
            [self showAllTextDialog:@"跳H5?"];
        }
        if (indexPath.row == 2) {
            //提醒
            tixingViewController * ctl = [[tixingViewController alloc]init];
            [self pushNewViewController:ctl];
        }
        if (indexPath.row == 3) {
            //收藏
            [self showAllTextDialog:@"跳H5?"];
        }
        if (indexPath.row == 4) {
            //订单
            [self showAllTextDialog:@"跳H5?"];
            
        }

        
    }
    
    
}
#pragma mark-第一个cell的点击
-(void)actionCell1:(UIButton*)btn{
    if (btn.tag == 2000) {
        //人头
        yonghuViewController * ctl = [[yonghuViewController alloc]init];
        ctl.isMy = YES;
        [self pushNewViewController:ctl];
        
    }
    else if(btn.tag == 2001){
        //赞'
        zhanshiViewController * ctl = [[zhanshiViewController alloc]init];
        ctl.keyStr = @"2";
        [self pushNewViewController:ctl];

        
    }
    else if(btn.tag == 2002){
        //粉
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"2";
        [self pushNewViewController:ctl];
        
    } else if(btn.tag == 2003){
        //关
        FenGuanViewController * ctl = [[FenGuanViewController alloc]init];
        ctl.titleStr = @"1";
        [self pushNewViewController:ctl];

        
    } else if(btn.tag == 2004){
        //展
        
        zhanshiViewController * ctl = [[zhanshiViewController alloc]init];
        ctl.keyStr = @"1";
        [self pushNewViewController:ctl];

        
    }
    else if(btn.tag == 2005){
        //收到的赞
        
        zhanshiViewController * ctl = [[zhanshiViewController alloc]init];
        ctl.keyStr = @"3";
        [self pushNewViewController:ctl];
        
        
    }

    
    
    
}
/*弃用
#pragma mark-第2个cell的点击
-(void)actionCell2:(UIButton*)btn{
    //收益
    MyshouyiViewController * ctl = [[MyshouyiViewController alloc]init];
    if (btn.tag == 3000) {
        ctl.index = 0;
        
    }
    else if(btn.tag == 3001){
        //全
        ctl.index = 0;

    }
    else if(btn.tag == 3002){
        //收
        ctl.index = 1;

    } else if(btn.tag == 3003){
        //提
        ctl.index = 2;

    }     
    
[self pushNewViewController:ctl];
    
    
}
 
#pragma mark-第3个cell的点击
-(void)actionCell3:(UIButton*)btn{
    if (btn.tag == 4000) {
        //收货
        
    }
    else if(btn.tag == 4001){
        //提醒
        tixingViewController * ctl = [[tixingViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    else if(btn.tag == 4002){
        //收藏
        
    } else if(btn.tag == 4003){
        //订
        
    }
    
    
    
    
}
*/
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
