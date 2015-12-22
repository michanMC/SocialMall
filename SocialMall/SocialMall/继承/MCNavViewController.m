//
//  NavViewController.m
//  StarGroups
//
//  Created by fenguoxl on 15/3/12.
//  Copyright (c) 2015年 fenguo. All rights reserved.
//

#import "MCNavViewController.h"

@interface MCNavViewController ()

@end

@implementation MCNavViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
