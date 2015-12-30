//
//  allTableView.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "allTableView.h"
#import "shouyiTableViewCell.h"
@interface allTableView ()<UITableViewDataSource, UITableViewDelegate>

@end



@implementation allTableView
+ (allTableView *)contentTableView {
    allTableView *contentTV = [[allTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    // contentTV.backgroundColor = [UIColor yellowColor];
    
    return contentTV;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    shouyiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shouyiTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"shouyiTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
//-(NSInteger)numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0)
//    return 5;
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
