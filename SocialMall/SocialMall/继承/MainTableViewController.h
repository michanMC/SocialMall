//
//  MainTableViewController.h
//  Hair
//
//  Created by michan on 15/5/26.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITabBarController
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

@end
