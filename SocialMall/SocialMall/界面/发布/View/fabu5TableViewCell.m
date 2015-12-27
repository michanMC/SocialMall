//
//  fabu5TableViewCell.m
//  SocialMall
//
//  Created by MC on 15/12/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "fabu5TableViewCell.h"
@interface fabu5TableViewCell (){
    UILabel *_titleLbl;
    
}

@end

@implementation fabu5TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, Main_Screen_Width - 10, 40)];
        _titleLbl.textColor = [UIColor grayColor];
        _titleLbl.text = @"搭配列表";
        _titleLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLbl ];
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 50, 10, 50, 20)];
        
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .7;
        ViewRadius(_bgView, 10);
        [self.contentView addSubview:_bgView];
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (40 - 15)/2, 15, 15)];
        
        _imgView.image = [UIImage imageNamed:@"style_icon"];
        [self.contentView addSubview:_imgView];
        
        
        _title2Lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 22, 20)];
        _title2Lbl.textColor = [UIColor whiteColor];
        _title2Lbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_title2Lbl];
       UIView* _lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 39.5, Main_Screen_Width - 5, 0.5)];
        _lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineView];

        
    }
    return self;
    
}
-(void)setTitle2Str:(NSString *)title2Str
{
    
    CGFloat w = [MCIucencyView heightforString:title2Str andHeight:20 fontSize:13];
    
    _bgView.frame = CGRectMake(Main_Screen_Width - 10 - w - 10 - 10, 10, w + 10 + 10, 20);
    
    _imgView.frame = CGRectMake(Main_Screen_Width  - w - 15 - 15, _imgView.frame.origin.y, 15, 15);
    
    _title2Lbl.frame = CGRectMake(Main_Screen_Width - 10 - w - 5, 10, w, 20);
    
    _title2Lbl.text = title2Str;
    
    
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
