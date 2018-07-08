//
//  TitleCell.m
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 29..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "TitleCell.h"

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //타이틀 길이가 길어지면 자동 조절.
    [self.title setAdjustsFontSizeToFitWidth:YES];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    if([self.subAddress.text isEqualToString:@""] == YES)
        self.left_spacing.constant = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
