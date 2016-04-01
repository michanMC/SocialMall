//
//  noDataTableViewCell.m
//  SocialMall
//
//  Created by MC on 16/3/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "noDataTableViewCell.h"

@interface noDataTableViewCell (){
    
    
    UIImageView * _imgView;
    UILabel *_titleLbl;
    
    
}

@end



@implementation noDataTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 80)/2, (Main_Screen_Height -64-44- 80)/2, 80, 80)];
        
        _imgView.image = [UIImage imageNamed:@"搜索-缺省页"];
        [self.contentView addSubview:_imgView];
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.frame.origin.y + 80 + 10, Main_Screen_Width, 20)];
        _titleLbl.textColor = AppCOLOR;
        _titleLbl.font = AppFont;
        _titleLbl.text = @"真抱歉，麻烦换一下关键词";
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLbl];
        

        
        
    }
    return self;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
