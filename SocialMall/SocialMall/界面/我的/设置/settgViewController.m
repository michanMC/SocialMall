//
//  settgViewController.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "settgViewController.h"
#import "yonghuViewController.h"
#import "xinxiViewController.h"
#import "yijianViewController.h"
#import "GuanzhuViewController.h"
//#import "XZMTabbarExtension.h"
#import "FabuViewController.h"
#import "FaxianViewController.h"
#import "MallViewController.h"
#import "MeViewController.h"

@interface settgViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    NSArray * _array;
    
}

@end

@implementation settgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    _array = @[
  @[@"账号管理",@"信息设置",@"意见反馈"],
  @[@"用户协议",@"关于我们",@"清除缓存"],
  @[@"退出"],
  ];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 1;
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _array[indexPath.section][indexPath.row];
    cell.textLabel.font = AppFont;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        yonghuViewController * ctl =[[ yonghuViewController alloc]init];
        ctl.isMy = YES;
        ctl.userModel = _userModel;

        [self pushNewViewController:ctl];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        xinxiViewController * ctl =[[ xinxiViewController alloc]init];
       // ctl.isMy = YES;
        [self pushNewViewController:ctl];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        yijianViewController * ctl =[[ yijianViewController alloc]init];
        // ctl.isMy = YES;
        [self pushNewViewController:ctl];
    }

    if (indexPath.section == 2) {
        [self logout];
    }
    
}
#pragma mark-退出登录
-(void)logout{
    [self showLoading:YES AndText:nil];
    [ self.requestManager requestWebWithParaWithURL:@"Login/logout" Parameter:nil IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [MCUser sharedInstance].sessionId = nil;
        [MCUser sharedInstance].userId = nil;
        
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"sessionId"];
        [defaults setObject :nil forKey:@"userId"];
        
        [defaults setObject:nil forKey:@"Pwd"];
        
        //强制让数据立刻保存
        [defaults synchronize];
#import "GuanzhuViewController.h"
        //#import "XZMTabbarExtension.h"
#import "FabuViewController.h"
#import "FaxianViewController.h"
#import "MallViewController.h"
#import "MeViewController.h"

        [self showAllTextDialog:@"成功退出"];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[GuanzhuViewController class]] ||[vc isKindOfClass:[FabuViewController class]] ||[vc isKindOfClass:[FaxianViewController class]]||[vc isKindOfClass:[MeViewController class]]||[vc isKindOfClass:[MallViewController class]]
                ) {
                //设置tabBarController的下标 0:首页
                vc.tabBarController.selectedIndex = 1;
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didRefreshDataObjNotification" object:@""];
                //跳转到订单列表
                [self.navigationController popToViewController:vc animated:NO];
                
                
                
            }
        }
        

        

    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"%@",description);
    }];
    

    
    
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
