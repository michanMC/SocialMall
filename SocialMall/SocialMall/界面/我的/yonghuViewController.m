//
//  yonghuViewController.m
//  SocialMall
//
//  Created by MC on 15/12/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "yonghuViewController.h"
#import "yonghuTableViewCell.h"
#import "yonghu2TableViewCell.h"
@interface yonghuViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *_tableView;
    NSString *_textViewStr;
    UIImage* _headimg;
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
    [self shoujianpan];
    NSInteger userSex = 0;
    
    UIButton * btn = (UIButton*)[self.view viewWithTag:660];
    if (btn.selected) {
        userSex = 1;
    }
    
    if (!_userModel.autograph) {
        _userModel.autograph = @"";
    }
    
    if (!_userModel.nickname) {
        _userModel.nickname = @"";
    }
 
//    if (!_userModel.headimgurl) {
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:662];

        _headimg = btn2.imageView.image;//[UIImage imageNamed:@"Avatar_76"];
    //}
    
    NSData *imageData = UIImageJPEGRepresentation(_headimg, 0.2);
    NSString *base64Image=[imageData base64Encoding];
    NSString *base64ImageStr = [NSString stringWithFormat: @"data:image/jpg;base64,%@",base64Image];
    NSDictionary * Parameterdic = @{
                                    @"headImg":base64ImageStr,
                                    @"userName":_userModel.nickname,
                                    @"autograph":_userModel.autograph,
                                    @"userSex":@(userSex)
                                    
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [ self.requestManager requestWebWithParaWithURL:@"User/updateInfo" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"修改成功"];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectloadData2Notification" object:@""];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showHint:description];
        NSLog(@"%@",description);
    }];
    

    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    if (indexPath.section == 1) {
        return 120;
    }
    return 152;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
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
        cell.headBtn.tag = 662;
    [cell.nvBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nanBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.headBtn addTarget:self action:@selector(ACtionHead) forControlEvents:UIControlEventTouchUpInside];
        
        
        if ([_userModel.sex isEqualToString:@"0"]) {
            cell.nanBtn.selected = YES;
            cell.nvBtn.selected = NO;
            
        }
        else
        {
            cell.nanBtn.selected = NO;
            cell.nvBtn.selected = YES;
            
            
        }
        cell.nameText.text = _userModel.nickname;
        cell.nameText.tag = 6000;
        cell.nameText.delegate =self;
        [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:_userModel.headimgurl] forState:0 placeholderImage:[UIImage imageNamed:@"Avatar_76"]];
        ViewRadius(cell.headBtn, 33/2);
        
        
        
        
    return cell;
    }
    if (indexPath.section == 1) {
        yonghu2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"yonghu2TableViewCell"];
        if (!cell) {

            cell = [[yonghu2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yonghu2TableViewCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textView.tag = 4444;
        cell.textView.delegate =self;
        if (_isMy) {
            cell.textView.userInteractionEnabled = YES;
        }
        else
        {
            cell.textView.userInteractionEnabled = NO;

        }
        cell.textView.text = _userModel.autograph;
        return cell;

    }
    return [[UITableViewCell alloc]init];
}
-(void)actionBtn:(UIButton*)btn{
    
    UIButton * btn1 = (UIButton*)[self.view viewWithTag:660];
    UIButton * btn2 = (UIButton*)[self.view viewWithTag:661];
    btn1.selected = NO;
    btn2.selected = NO;
    btn.selected = YES;
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    _textViewStr = textView.text;
    _userModel.autograph = textView.text;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        _userModel.autograph = textView.text;
        return NO;
    }
//    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
//    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 20) {
        //[_tableview reloadData];
        
        
        return NO;
    }
    return YES;
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == 6000) {
        _userModel.nickname = textField.text;
    }
    
    
}
-(void)shoujianpan{
    UITextView * textview = (UITextView*)[self.view viewWithTag:4444];
    UITextField * text = (UITextField*)[self.view viewWithTag:6000];

    [textview resignFirstResponder];

    [text resignFirstResponder];

}

#pragma mark-点击头像
-(void)ACtionHead{
   // _isshang = YES;
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark-选择从哪里拿照片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==2) return;
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if(buttonIndex==1){//拍照
        sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]){
            kAlertMessage(@"检测到无效的摄像头设备");
            return ;
        }
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    picker.sourceType=sourceType;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil ) {
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:662];
        [btn setImage:image forState:0];
        _headimg = image;
       // _isshang = NO;
       // [self updateAvatar:image];
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
