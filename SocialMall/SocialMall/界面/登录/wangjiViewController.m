//
//  wangjiViewController.m
//  SocialMall
//
//  Created by MC on 15/12/23.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "wangjiViewController.h"
#import "zhuceTableViewCell.h"

@interface wangjiViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
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

@implementation wangjiViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self ColorNavigation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
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
    [_foorbtn setTitle:@"确认修改" forState:0];
    _foorbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _foorbtn.tag = 500;
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
        cell.textField.tag = 600;
        cell.textField.text = _phoneStr;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.fasongBtn.hidden = YES;
        //设置密码输入
        cell.textField.secureTextEntry = NO;
        
    }
    else if(indexPath.row == 1){
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.tag = 601;
        cell.textField.text = _yanzhenStr;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.tag = 501;
        cell.fasongBtn.hidden = NO;
        [cell.fasongBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置密码输入
        cell.textField.secureTextEntry = NO;
        
    }
    else if(indexPath.row == 2){
        cell.textField.placeholder = @"设置密码";
        cell.textField.tag = 602;
        cell.textField.text = _pwd1Str;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.hidden = YES;
        
        //设置密码输入
        cell.textField.secureTextEntry = YES;
        
    }
    else if(indexPath.row == 3){
        cell.textField.placeholder = @"请再次输入密码";
        cell.textField.tag = 603;
        cell.textField.text = _pwd2Str;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.fasongBtn.hidden = YES;
        
        //设置密码输入
        cell.textField.secureTextEntry = YES;
        
    }
    
    
    
    return cell;
    
    
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:600];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:601];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:602];
    UITextField * text4 = (UITextField*)[self.view viewWithTag:603];
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
    if (textField.tag == 600) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 601){
        _yanzhenStr = textField.text;
        
    }
    if (textField.tag == 602) {
        _pwd1Str = textField.text;
    }
    else if(textField.tag == 603){
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
    
    
    if (btn.tag == 500) {
        if (!_iszhuce) {
            if (!_yanzhenStr.length) {
                [self showAllTextDialog:@"请输入验证码"];
                return;
            }
            
            _iszhuce = YES;
            [_tableView reloadData];
            //[_foorbtn setTitle:@"马上体验" forState:0];
            
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
            
             [self zhuceLoad];
            
            
            
            
        }
        
    } else if(btn.tag == 501){
        
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
            
        } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
            [self hideHud];
            [self showAllTextDialog:description];
            
            NSLog(@"失败");
        }];
        
        
        
    }
}
#pragma mark-设置密码接口
-(void)zhuceLoad{
    
    
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneStr,
                                    @"verify":_yanzhenStr,
                                    @"password":_pwd1Str
                                    };
//                                    @"repassword":_pwd2Str                                    };
    
    
    [self showLoading:YES AndText:nil];
    
    [self.requestManager requestWebWithParaWithURL:@"Login/forgetPass" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [MCUser sharedInstance].sessionId = resultDic[@"data"][@"sessionId"];
        [MCUser sharedInstance].userId = resultDic[@"data"][@"userId"];
        
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:resultDic[@"data"][@"sessionId"] forKey:@"sessionId"];
        [defaults setObject :resultDic[@"data"][@"userId"] forKey:@"userId"];
        
        [defaults setObject:_phoneStr forKey:@"UserPhone"];
        [defaults setObject:_pwd1Str forKey:@"Pwd"];
        
        //强制让数据立刻保存
        [defaults synchronize];
        
        [self showAllTextDialog:@"密码修改成功,请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        });
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
    
}

// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    UIButton * btn = (UIButton*)[self.view viewWithTag:501];
    
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
