//
//  SurroundingHeader.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 30..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class FilterViewController;

@interface SurroundingHeader : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *currentLocation;

@property(weak, nonatomic) MainViewController *mainVC;
@property(strong, nonatomic) FilterViewController *filterVC;

@property (strong, nonatomic) IBOutlet UIButton *distanceBtnImage;
@property (strong, nonatomic) IBOutlet UIButton *filterBtn;

- (IBAction)filterBtn:(id)sender;
- (IBAction)distanceBtn:(id)sender;
@end
