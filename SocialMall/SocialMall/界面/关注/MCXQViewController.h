//
//  MCXQViewController.h
//  SocialMall
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "faXianModel.h"
#import "zuopinDataView.h"
@interface MCXQViewController : BaseViewController
@property (nonatomic,strong)faXianModel *faxianModel;
@property (nonatomic,weak)zuopinDataView *DataView;

@end
