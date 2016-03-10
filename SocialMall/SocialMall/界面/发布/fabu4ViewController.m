//
//  fabu4ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "fabu4ViewController.h"
#import "loginTextTableViewCell.h"

@interface fabu4ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    
    UITableView *_tableView;
    
    
    NSString * _shangpiStr;
    NSString * _pinpaiStr;
    NSString * _xinghaoStr;

    
}

@end

@implementation fabu4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加商品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButton)];
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
-(void)rightBarButton{
    [self shoujianpan];
    
    NSLog(@"%@",_shangpiStr);
    NSLog(@"%@",_pinpaiStr);
    NSLog(@"%@",_xinghaoStr);
    if (!_shangpiStr.length) {
        [self showAllTextDialog:@"请输入商品名称"];
        return;
    }
    if (!_pinpaiStr.length) {
        [self showAllTextDialog:@"请输入品牌"];
        return;
    }
    if (!_xinghaoStr.length) {
        [self showAllTextDialog:@"请输入型号"];
        return;
    }
    
    NSDictionary * dic =@{
                          @"goods_name":_shangpiStr,
                          
                          @"brand_name":_pinpaiStr,

                          @"model":_xinghaoStr,

                          };
    [_delegate backDic:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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
    
    
    
    cell.imgView.frame = CGRectMake(20, cell.imgView.frame.origin.y, cell.imgView.frame.size.width, cell.imgView.frame.size.height);
    cell.textField.frame = CGRectMake(20 +cell.imgView.frame.size.width + 5 , cell.textField.frame.origin.y, cell.textField.frame.size.width, cell.textField.frame.size.height);
    
    if (indexPath.row == 0) {
        cell.imgView.image = [UIImage imageNamed:@"Product-name_icon"];
        cell.textField.placeholder = @"商品名称";
        cell.textField.tag = 900;
       // cell.textField.text = _phoneStr;
       // cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.keyboardType = UIKeyboardTypeDefault;

    }
    else if(indexPath.row == 1){
        cell.imgView.image = [UIImage imageNamed:@"brand_icon"];
        cell.textField.placeholder = @"品牌";
        cell.textField.tag = 901;
        //cell.textField.text = _pwdStr;
        
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        
        
    }
    else if(indexPath.row == 2){
        cell.imgView.image = [UIImage imageNamed:@"model_icon"];
        cell.textField.placeholder = @"型号";
        cell.textField.tag = 902;
        //cell.textField.text = _pwdStr;
        
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        
        
    }

    
    return cell;

}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:900];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:901];
    UITextField * text3 = (UITextField*)[self.view viewWithTag:902];

    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 900) {
        _shangpiStr = textField.text;
    }
    else if(textField.tag == 901){
        _pinpaiStr = textField.text;
        
    }
    else if(textField.tag == 902){
        _xinghaoStr = textField.text;
        
    }

    //[_tableView reloadData];
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
