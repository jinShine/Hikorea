//
//  SurroundingCell.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "SurroundingCell.h"

@implementation SurroundingCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cardView.layer.cornerRadius = 7.0f;
    self.cardView.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.cardView.layer.shadowOpacity = 0.2f;
    self.cardView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.mainImage.layer.masksToBounds = YES;
    
}

@end
