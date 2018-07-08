//
//  KoreaMapViewController.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 18..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

@interface KoreaMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn_Seoul;               // 1
@property (weak, nonatomic) IBOutlet UIButton *btn_Incheon;             // 2
@property (weak, nonatomic) IBOutlet UIButton *btn_Daejeon;             // 3
@property (weak, nonatomic) IBOutlet UIButton *btn_Daegu;               // 4
@property (weak, nonatomic) IBOutlet UIButton *btn_Gwangju;             // 5
@property (weak, nonatomic) IBOutlet UIButton *btn_Busan;               // 6
@property (weak, nonatomic) IBOutlet UIButton *btn_Ulsan;               // 7
@property (weak, nonatomic) IBOutlet UIButton *btn_Gyeonggido;          // 31
@property (weak, nonatomic) IBOutlet UIButton *btn_Gangwondo;           // 32
@property (weak, nonatomic) IBOutlet UIButton *btn_Chungcheongbukdo;    // 33
@property (weak, nonatomic) IBOutlet UIButton *btn_Chungcheongnamdo;    // 34
@property (weak, nonatomic) IBOutlet UIButton *btn_Gyeongsangbukdo;     // 35
@property (weak, nonatomic) IBOutlet UIButton *btn_Gyeongsangnamdo;     // 36
@property (weak, nonatomic) IBOutlet UIButton *btn_Jeollabukdo;         // 37
@property (weak, nonatomic) IBOutlet UIButton *btn_Jeollanamdo;         // 38
@property (weak, nonatomic) IBOutlet UIButton *btn_Jeju;                // 39


@property (weak, nonatomic) IBOutlet UILabel *navi_title;

@property (weak, nonatomic) NSString *selectedCategory;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviHeader_iphoneX;

- (IBAction)areaSelected:(UIButton *)sender;




@end
