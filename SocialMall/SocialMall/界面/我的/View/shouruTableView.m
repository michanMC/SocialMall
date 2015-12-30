//
//  shouruTableView.m
//  SocialMall
//
//  Created by MC on 15/12/30.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "shouruTableView.h"
#import "shouyiTableViewCell.h"
@interface shouruTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation shouruTableView
+ (shouruTableView *)contentTableView {
    shouruTableView *contentTV = [[shouruTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    // contentTV.backgroundColor = [UIColor yellowColor];
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;

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
//    return 1;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
