//
//  loginViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "loginViewController.h"
#import "loginTextTableViewCell.h"
@interface loginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView * _tableView;
    NSString * _phoneStr;
    NSString * _pwdStr;

    
}

@end

@implementation loginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    UIButton* _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 23, 35, 35)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_close_btn"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableView.tableHeaderView = [self headView];
    _tableView.tableFooterView = [self foorView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

}
-(UIView*)headView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 100) / 2, (100 - 100)/2, 100, 100)];
    imgview.image =[ UIImage imageNamed:@"share_friends"];
    [view addSubview:imgview];
    return view;
    
    
}
-(UIView*)foorView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
    CGFloat x = 40;
    CGFloat y = 30;
    CGFloat width = Main_Screen_Width - 80;
    CGFloat height = 40;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:0];
    [btn setTitle:@"登录" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    y += height + 5;
    width = 75;
    height = 25;
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn2 setTitle:@"忘记密码？" forState:0];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitleColor:[UIColor grayColor] forState:0];
    [view addSubview:btn2];

    width = 35;
    x = Main_Screen_Width - 40 - width;
    UIButton * btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [btn3 setTitle:@"注册" forState:0];
    btn3.titleLabel.textAlignment = NSTextAlignmentRight;

    btn3.titleLabel.font = [UIFont systemFontOfSize:13];

    [btn3 setTitleColor:[UIColor orangeColor] forState:0];
    [view addSubview:btn3];
    

    
    return view;

    
}
#pragma mark - actionBtn
-(void)actionBtn:(UIButton*)btn{
    [self shoujianpan];
    NSLog(@"%@ - %@",_phoneStr,_pwdStr);
    
    
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:100];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:101];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 101){
        _pwdStr = textField.text;

    }
    //[_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"loginTextTableViewCell";
    loginTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[loginTextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textField.delegate = self;
    if (indexPath.row == 0) {
        cell.imgView.image = [UIImage imageNamed:@"login_cellphoe_icon"];
        cell.textField.placeholder = @"请输入手机号码";
        cell.textField.tag = 100;
        cell.textField.text = _phoneStr;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if(indexPath.row == 1){
        cell.imgView.image = [UIImage imageNamed:@"login_password_icon"];
        cell.textField.placeholder = @"请输入密码";
        cell.textField.tag = 101;
        cell.textField.text = _pwdStr;

        cell.textField.keyboardType = UIKeyboardTypeDefault;

        
    }
    
    return cell;
}
#pragma mark-返回
-(void)actionBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
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
