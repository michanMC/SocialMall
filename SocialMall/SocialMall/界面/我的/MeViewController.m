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

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    
    
    
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 220;
    }
    if (indexPath.section == 1) {
        return 97;
    }
    if (indexPath.section == 2) {
        return 126;
    }
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
       
        return 1;
    }
    if (section == 1) {
        return 1;
    
    }
    if (section == 2) {
        return 1;
    }
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        me1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me1TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    if (indexPath.section == 1) {
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me2TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me2TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    if (indexPath.section == 2) {
        me3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"me3TableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"me3TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    }
    return [[UITableViewCell alloc]init];

    
    
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
