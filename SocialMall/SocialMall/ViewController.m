//
//  ViewController.m
//  SocialMall
//
//  Created by MC on 15/12/17.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "MCNavViewController.h"
//#import "XZMTabBarViewController.h"
@interface ViewController ()<MAMapViewDelegate, AMapSearchDelegate>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MainTableViewController *main = [[MainTableViewController alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = main;

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
