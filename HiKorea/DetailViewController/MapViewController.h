//
//  MapViewController.h
//  HiKorea
//
//  Created by 김승진 on 2018. 2. 16..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

#import "DetailViewController.h"

@class DetailViewController;

@interface MapViewController : UIViewController

@property (weak, nonatomic) NSMutableArray *selectedArrData;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) DetailViewController *detailVC;
@end
