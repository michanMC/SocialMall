//
//  MainTableViewController.m
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MainTableViewController.h"
#import "GuanzhuViewController.h"
//#import "XZMTabbarExtension.h"
#import "FabuViewController.h"
#import "FaxianViewController.h"
#import "MallViewController.h"
#import "MeViewController.h"
#import "MCNavViewController.h"
@interface MainTableViewController ()

@end

@implementation MainTableViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view.
}
- (void)setupViews
{
    GuanzhuViewController *loan = [[GuanzhuViewController alloc]init];
    [self setUpChildController:loan title:@"关注" imageName:@"focus_normal" selectedImageName:@"focus_pressed"];
    
    ////    _contasctsVC = [[ContactsViewController alloc]init];
    //
    GuanzhuViewController *chatList= [[GuanzhuViewController alloc] init];
    //    [_chatListVC networkChanged:_connectionState];
    [self setUpChildController:chatList title:@"发现" imageName:@"detection_normal" selectedImageName:@"detection_pressed"];

    FabuViewController *catact = [[FabuViewController alloc]init];
    [self setUpChildController:catact title:nil imageName:@"add" selectedImageName:@"add"];
    
    MallViewController *mall = [[MallViewController alloc]init];
    [self setUpChildController:mall title:@"商城" imageName:@"mine_normal" selectedImageName:@"mine_pressed"];

    MeViewController *me = [[MeViewController alloc]init];
    
    [self setUpChildController:me title:@"我" imageName:@"mall_normal" selectedImageName:@"mall_pressed"];
    //
}

- (void)setUpChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage
{
    controller.title = title;
    // 底部字体颜色
    self.tabBar.tintColor = AppCOLOR;//RGBCOLOR(254, 96, 149);
    //默认的图片
    [controller.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

   // if (title)
    //选择时的图片,将其渲染方式设置为原始的颜色
    [controller.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   /// controller.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    if (title == nil) {
        controller.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);

    }
    MCNavViewController *nav = [[MCNavViewController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
    
    
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
