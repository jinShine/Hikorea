//
//  SearchDataCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 4. 19..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDataCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *readCount;
@property (strong, nonatomic) IBOutlet UILabel *distance;

@end
