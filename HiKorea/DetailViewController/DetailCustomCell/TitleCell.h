//
//  TitleCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 29..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subAddress;
@property (strong, nonatomic) IBOutlet UILabel *readCount;
@property (strong, nonatomic) IBOutlet UIImageView *info1;
@property (strong, nonatomic) IBOutlet UIImageView *info2;
@property (strong, nonatomic) IBOutlet UIImageView *info3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_spacing;



@end
