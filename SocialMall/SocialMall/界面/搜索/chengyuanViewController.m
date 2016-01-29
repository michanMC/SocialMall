//
//  chengyuanViewController.m
//  SocialMall
//
//  Created by MC on 16/1/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "chengyuanViewController.h"
#import "FenGuanTableViewCell.h"
#import "GerenViewController.h"
@interface chengyuanViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    UITableView *_tableView;

    
    
    
}

@end

@implementation chengyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(Main_Screen_Width * 2, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FenGuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FenGuanTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FenGuanTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFsearchGRObjNotification" object:@""];
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
