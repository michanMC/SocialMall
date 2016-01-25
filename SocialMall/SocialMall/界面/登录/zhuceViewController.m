//
//  zhuceViewController.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhuceViewController.h"
#import "zhuceTableViewCell.h"
@interface zhuceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    UITableView *_tableView;
    NSString * _phoneStr;
    NSString * _yanzhenStr;
    NSString * _pwd1Str;
    NSString * _pwd2Str;
    BOOL _iszhuce;
    UIButton *_foorbtn;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;
    
    
}

@end

@implementation zhuceViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ColorNavigation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareUI];
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableView.tableHeaderView = [self headView];
    _tableView.tableFooterView = [self foorView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
    
}
-(UIView*)headView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
    
}
-(UIView*)foorView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat x = 40;
    CGFloat y = 30;
    CGFloat width = Main_Screen_Width - 80;
    CGFloat height = 40;
    _foorbtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_foorbtn setBackgroundImage:[UIImage imageNamed:@"login_btn_bg"] forState:0];
    [_foorbtn setTitle:@"注册" forState:0];
    _foorbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _foorbtn.tag = 400;
    [_foorbtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_foorbtn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:_foorbtn];

    
    return view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_iszhuce) {
        return 4;
    }
    else
    {
        return 2;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"zhuceTableViewCell";
    zhuceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[zhuceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textField.delegate = self;
    if (indexPath.row == 0) {
        cell.textField.placeholder = @"请输入手机号码";
        cell.textField.tag = 300;
        cell.textField.text = _phoneStr;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.fasongBtn.hidden = YES;

    }
    else if(indexPath.row == 1){
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.tag = 301;
        cell.textField.text = _yanzhenStr;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.tag = 401;
        cell.fasongBtn.hidden = NO;
        [cell.fasongBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];

        
        
    }
    else if(indexPath.row == 2){
        cell.textField.placeholder = @"设置密码";
        cell.textField.tag = 302;
        cell.textField.text = _pwd1Str;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.hidden = YES;

        
        
    }
    else if(indexPath.row == 3){
        cell.textField.placeholder = @"请再次输入密码";
        cell.textField.tag = 303;
        cell.textField.text = _pwd2Str;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.hidden = YES;

        
        
    }


    
    return cell;
    
    
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:300];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:301];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:302];
    UITextField * text4 = (UITextField*)[self.view viewWithTag:303];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 300) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 301){
        _yanzhenStr = textField.text;
        
    }
    if (textField.tag == 302) {
        _pwd1Str = textField.text;
    }
    else if(textField.tag == 303){
        _pwd2Str = textField.text;
        
    }

    //[_tableView reloadData];
}

#pragma mark - actionBtn
-(void)actionBtn:(UIButton*)btn{
    [self shoujianpan];
//    NSLog(@"%@ - %@",_phoneStr,_pwdStr);
            if (!_phoneStr.length) {
                [self showAllTextDialog:@"请输入手机号码"];
                return;
            }
            if (![CommonUtil isMobile:_phoneStr]) {
                [self showAllTextDialog:@"请正确输入手机号码"];
                return;
            }
    

    if (btn.tag == 400) {
        if (!_iszhuce) {
            if (!_yanzhenStr.length) {
                [self showAllTextDialog:@"请输入验证码"];
                return;
            }

            _iszhuce = YES;
            [_tableView reloadData];
            [_foorbtn setTitle:@"马上体验" forState:0];

        }
        else
        {
           
            if (!_pwd1Str.length) {
                [self showAllTextDialog:@"请输入密码"];
                return;
            }
            if (!_pwd2Str.length) {
                [self showAllTextDialog:@"请输入确定密码"];
                return;
            }
            if (_pwd1Str.length < 6 || _pwd1Str.length > 30 ) {
                [self showAllTextDialog:@"请输入6-30位的密码"];
                return;
                
            }
            
            if (![_pwd1Str isEqualToString:_pwd2Str]) {
                [self showAllTextDialog:@"两次输入密码不一致"];
                return;
            }

            
            
            
            
            
        }
        
    } else if(btn.tag == 401){//获取验证码
        
        _gameStartTime=[NSDate date];


        NSDictionary * Parameterdic = @{
                                        @"phone":_phoneStr
                                        };
        
        
        [self showLoading:YES AndText:nil];
        [self.requestManager requestWebWithParaWithURL:@"Login/getPhoneVerify" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
            [self hideHud];
            NSLog(@"成功");
            NSLog(@"返回==%@",resultDic);
            [self showAllTextDialog:@"发送成功，请留意你的手机短信"];
            _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
//            if (resultDic[@"data"][@"sessionId"]) {
//            
//            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//                [defaults setObject:resultDic[@"data"][@"sessionId"] forKey:@"sessionId"];
//            
//            //强制让数据立刻保存
//            [defaults synchronize];
//            }
            
            
            
            
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
            [self hideHud];
            [self showAllTextDialog:description];
            
            NSLog(@"失败");
        }];
        
        

        
        
        
    }
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    UIButton * btn = (UIButton*)[self.view viewWithTag:401];
    
    if (deltaTime>60) {
        [btn setTitle:@"重新发送" forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:YES];
        [_gameTimer invalidate];
        return;
    }else
    {
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:NO];
        
    }
    
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
