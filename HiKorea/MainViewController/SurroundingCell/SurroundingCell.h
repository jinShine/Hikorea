//
//  SurroundingCell.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurroundingCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIView *cardView;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UILabel *mainTitle;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *readCount;
@property (strong, nonatomic) IBOutlet UILabel *location;


@end
