//
//  FenGuanViewController.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FenGuanViewController.h"
#import "FenGuanTableViewCell.h"
#import "GerenViewController.h"
@interface FenGuanViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    
}

@end

@implementation FenGuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([_titleStr isEqualToString:@"1"]){
        self.title = @"关注列表";
    }
    if([_titleStr isEqualToString:@"2"]){
        self.title = @"粉丝列表";
    }
    
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
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
    GerenViewController * ctl = [[GerenViewController alloc]init];
    [self pushNewViewController:ctl];
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
