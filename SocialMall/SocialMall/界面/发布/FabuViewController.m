//
//  FabuViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FabuViewController.h"
#import "YBImgPickerViewController.h"
#import "Fabu2ViewController.h"
@interface FabuViewController ()<YBImgPickerViewControllerDelegate>

@end

@implementation FabuViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObjFB:) name:@"didSelectFBNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObjZQ:) name:@"didSelectZQNotification" object:nil];
    

    self.title = @"发布";
    self.tabBarItem.title = @"";
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    [next showInViewContrller:self choosenNum:0 delegate:self];

    // Do any additional setup after loading the view.
}
-(void)didSelectObjZQ:(NSNotification*)Notification{
    MCUser * mc = [MCUser sharedInstance];
    self.navigationController.tabBarController.selectedIndex = mc.tabIndex;
    
    
}
-(void)didSelectObjFB:(NSNotification*)Notification{
    
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    [next showInViewContrller:self choosenNum:0 delegate:self];
 
    
    
}
- (void)YBImagePickerDidFinishWithImages:(NSArray *)imageArray {
   
    if (imageArray.count) {
        Fabu2ViewController * ctl = [[Fabu2ViewController alloc]init];
        ctl.image = imageArray[0];
        [self.navigationController pushViewController:ctl animated:NO];

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
