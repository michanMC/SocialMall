//
//  zuopinDataView3Cell.h
//  SocialMall
//
//  Created by MC on 16/1/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zuopinDataView3CellDelegate <NSObject>

-(void)actionZanBtn:(BOOL)isAll;

@end


@interface zuopinDataView3Cell : UITableViewCell
@property (nonatomic,assign) BOOL isQX;
@property(nonatomic,weak)id<zuopinDataView3CellDelegate>deleGate;
-(void)prepareUI;

@end
