//
//  FilterViewController.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

@class MainViewController;


@interface FilterViewController : UIViewController

@property (assign, nonatomic) MainViewController *mainVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviHeader_iphoneX;


//정렬
@property (strong, nonatomic) IBOutlet UIButton *mostViewOrder;
@property (strong, nonatomic) IBOutlet UIButton *latestOrder;
@property (strong, nonatomic) IBOutlet UIButton *distanceOrder;

//카테고리
@property (strong, nonatomic) IBOutlet UIButton *touristCategory;
@property (strong, nonatomic) IBOutlet UIButton *culturalCategory;
@property (strong, nonatomic) IBOutlet UIButton *festivalCategory;
@property (strong, nonatomic) IBOutlet UIButton *travelingCategory;
@property (strong, nonatomic) IBOutlet UIButton *leportsCategory;
@property (strong, nonatomic) IBOutlet UIButton *accommodationCategory;
@property (strong, nonatomic) IBOutlet UIButton *shoppingCategory;
@property (strong, nonatomic) IBOutlet UIButton *restaurantCategory;

@property (strong, nonatomic) IBOutlet UILabel *touristCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *culturalCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *festivalCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *travelingCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *leportsCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *accommodationCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *shoppingCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *restaurantCategoryName;




- (IBAction)orderBtnAction:(id)sender;
- (IBAction)categoryBtnAction:(id)sender;
- (IBAction)filterApplication:(id)sender;

- (IBAction)popUpDismiss:(id)sender;



@end
