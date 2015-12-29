//
//  me2TableViewCell.h
//  SocialMall
//
//  Created by MC on 15/12/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface me2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *quanbuLbl;
@property (weak, nonatomic) IBOutlet UILabel *shouruLbl;
@property (weak, nonatomic) IBOutlet UILabel *tixianLbl;
@property (weak, nonatomic) IBOutlet UIButton *quanbuBtn;
@property (weak, nonatomic) IBOutlet UIButton *shouruBtn;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (weak, nonatomic) IBOutlet UIButton *shouyiBtn;

@end
