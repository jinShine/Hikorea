//
//  MainImageCell.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainImageCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *address;


@end
