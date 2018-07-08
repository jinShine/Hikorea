//
//  DefaultViewCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 2. 28..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *contentText;


@end
