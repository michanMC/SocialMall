//
//  titleTableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "titleTableViewCell.h"


@interface titleTableViewCell (){
    UILabel *_titleLbl;
    
    
}

@end
@implementation titleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, Main_Screen_Width - 10, 44)];
        _titleLbl.textColor = [UIColor grayColor];
        _titleLbl.numberOfLines = 0;
        _titleLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLbl ];
        
        
    }
    return self;
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    
    CGFloat h = [MCIucencyView heightForString:titleStr fontSize:13 andWidth:Main_Screen_Width - 10];
    _titleLbl.frame = CGRectMake(5, 10, Main_Screen_Width - 10, h);
    _titleLbl.text = titleStr;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
