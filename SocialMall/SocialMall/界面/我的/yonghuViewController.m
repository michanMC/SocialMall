//
//  yonghuViewController.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "yonghuViewController.h"
#import "yonghuTableViewCell.h"
@interface yonghuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
}

@end

@implementation yonghuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户中心";
    if (_isMy) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(ActionBaocun)];
    }
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource= self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}
#pragma mark-保存
-(void)ActionBaocun{
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 152;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    yonghuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"yonghuTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"yonghuTableViewCell" owner:self options:nil]lastObject];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isMy) {
        cell.headBtn.userInteractionEnabled = YES;
        cell.nameText.userInteractionEnabled = YES;
        cell.nvBtn.userInteractionEnabled = YES;
        cell.nanBtn.userInteractionEnabled = YES;

    }
    else
    {
        cell.headBtn.userInteractionEnabled = NO;
        cell.nameText.userInteractionEnabled = NO;
        cell.nvBtn.userInteractionEnabled = NO;
        cell.nanBtn.userInteractionEnabled =NO;
    }
    cell.nanBtn.tag = 661;
    cell.nvBtn.tag = 660;
    
    [cell.nvBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nanBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}
-(void)actionBtn:(UIButton*)btn{
    
    UIButton * btn1 = (UIButton*)[self.view viewWithTag:660];
    UIButton * btn2 = (UIButton*)[self.view viewWithTag:661];
    btn1.selected = NO;
    btn2.selected = NO;
    btn.selected = YES;
    
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
