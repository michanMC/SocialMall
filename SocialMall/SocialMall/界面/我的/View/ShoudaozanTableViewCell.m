//
//  ShoudaozanTableViewCell.m
//  SocialMall
//
//  Created by MC on 16/3/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoudaozanTableViewCell.h"

@implementation ShoudaozanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat height = 40;
        CGFloat width = height;
        _headimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headimgView.image =[UIImage imageNamed:@"Avatar_76"];
        ViewRadius(_headimgView, 20);
        [self.contentView addSubview:_headimgView];
        
        x +=width + 10;
       /// y += 5;
        height = 20;
        width = Main_Screen_Width - x - 10 - 40;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.text = @"mc";
        _nameLbl.textColor = [UIColor darkTextColor];
        _nameLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLbl];
        
        
        y = 60 - 10 - 20;
        
        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _timeLbl.text = @"02月25号 17:57";
        _timeLbl.textColor = [UIColor darkTextColor];
        _timeLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_timeLbl];

        x = Main_Screen_Width - 10 - 40;
        y = 10;
        width = 40;
        height = 40;
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _imgView.image =[UIImage imageNamed:@"message_default-photo"];
        [self.contentView addSubview:_imgView];

        
        
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
