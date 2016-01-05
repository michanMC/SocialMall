//
//  zhanshiViewController.m
//  SocialMall
//
//  Created by MC on 16/1/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "zhanshiViewController.h"
#import "zhanshiTableViewCell.h"
@interface zhanshiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation zhanshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_keyStr isEqualToString:@"1"]) {
      self.title = @"发布列表";
    }
    else
    {
        self.title = @"赞过列表";
 
    }
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView ];
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    zhanshiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zhanshiTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"zhanshiTableViewCell" owner:self options:nil]lastObject];
    }
    if (indexPath.row == 0) {
        cell.fenxianBtn.hidden = YES;
    }
    else
    {
        cell.fenxianBtn.hidden = NO;

        
    }
    return cell;
    
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
