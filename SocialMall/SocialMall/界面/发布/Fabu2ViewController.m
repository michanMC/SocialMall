//
//  Fabu2ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Fabu2ViewController.h"
#import "Fabu3ViewController.h"

#import "zhizuoText2TableViewCell.h"
#import "UIPlaceHolderTextView.h"
@interface Fabu2ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView * _tableView;
    UIPlaceHolderTextView * _holderText;

    NSString *_countTextStr;
    NSString *_holderTextStr;

}

@end

@implementation Fabu2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    _countTextStr = @"0/150";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(Actionadd)];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64 , Main_Screen_Width, Main_Screen_Height - 64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self headView];
    // Do any additional setup after loading the view.
}
-(UIView*)headView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    imgView.image = _image;
    [view addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES; // 裁剪边缘

    return view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 156;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    zhizuoText2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc1"];
    if (!cell) {
        cell = [[zhizuoText2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc1"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.holderTex.delegate = self;
    _holderText = cell.holderTex;
    _holderText.text = _holderTextStr;
    cell.countLbl.tag = 601;
    cell.countLbl.text = _countTextStr;
    
    
    return cell;

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        return NO;
    }
    UILabel * lbl = (UILabel*)[self.view viewWithTag:601];
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 150) {
        //[_tableview reloadData];
        lbl.text = [NSString stringWithFormat:@"%ld/150",aString.length];
        _countTextStr = lbl.text;
        
        return NO;
    }
    //[_tableview reloadData];
    lbl.text = [NSString stringWithFormat:@"%ld/150",aString.length];
    _countTextStr = lbl.text;
    return YES;
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    _holderTextStr = textView.text;
    
   // [_tableView reloadData];
    
}

-(void)Actionadd{
    [_holderText resignFirstResponder];
    
    if (!_holderTextStr.length) {
        kAlertMessage(@"请输入内容");
        return;
    }
    
    Fabu3ViewController  * ctl = [[Fabu3ViewController alloc]init];
    ctl.titleStr = _holderTextStr;
    ctl.image = _image;
    [self pushNewViewController:ctl];
    
    
}
-(void)ActionBack{
    
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectFBNotification" object:@""];
    [self.navigationController popViewControllerAnimated:NO ];
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
