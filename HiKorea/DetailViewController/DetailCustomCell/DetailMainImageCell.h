//
//  DetailMainImageCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 28..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "MainViewController.h"

@class DetailViewController;

@interface DetailMainImageCell : UITableViewCell <UIScrollViewDelegate>

@property (weak) DetailViewController *detailVC;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (strong, nonatomic) IBOutlet UILabel *pageControl;

@property (nonatomic) NSInteger imageTotalCount;

@end
