//
//  xinxiViewController.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "xinxiViewController.h"
#import "xinxiTableViewCell.h"
@interface xinxiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation xinxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息设置";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    
    
    // Do any additional setup after loading the view.
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    xinxiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"xinxiTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"xinxiTableViewCell" owner:self options:nil]lastObject];
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
[cell.swBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLbl.text = @"新消息提醒";
        cell.swBtn.tag = 770;
        if([defaults objectForKey:@"xin"])
        {
            cell.swBtn.selected = NO;
        }
        else
        {
          cell.swBtn.selected = YES;
        }
        return cell;
    }
    if (indexPath.row == 1) {
        cell.titleLbl.text = @"评论通知";
        cell.swBtn.tag = 771;
        if([defaults objectForKey:@"pin"])
        {
            cell.swBtn.selected = NO;
        }
        else
        {
            cell.swBtn.selected = YES;
        }
        return cell;

    }
    if (indexPath.row == 2) {
        cell.titleLbl.text = @"震动";
        cell.swBtn.tag = 772;
        if([defaults objectForKey:@"zhen"])
        {
            cell.swBtn.selected = NO;
        }
        else
        {
            cell.swBtn.selected = YES;
        }
        return cell;

    }
    
    return cell;
}
-(void)actionBtn:(UIButton*)btn{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    if (btn.selected) {
        btn.selected = NO;
        if (btn.tag == 770) {
            [defaults setObject:@"1" forKey:@"xin"];
        }
        if (btn.tag == 771) {
            [defaults setObject:@"1" forKey:@"pin"];
        }
        if (btn.tag == 772) {
            [defaults setObject:@"1" forKey:@"zhen"];
        }

        
    }
    else
    {
       btn.selected = YES;
        if (btn.tag == 770) {
            [defaults setObject:nil forKey:@"xin"];
        }
        if (btn.tag == 771) {
            [defaults setObject:nil forKey:@"pin"];
        }
        if (btn.tag == 772) {
            [defaults setObject:nil forKey:@"zhen"];
        }

    }
    
    [defaults synchronize];
 
    
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
