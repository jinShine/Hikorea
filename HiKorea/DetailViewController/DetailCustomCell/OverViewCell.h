//
//  OverViewCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 29..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *overView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overViewStrHeight;

@end
