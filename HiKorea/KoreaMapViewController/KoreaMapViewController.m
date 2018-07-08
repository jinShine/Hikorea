//
//  KoreaMapViewController.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 18..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "KoreaMapViewController.h"

@interface KoreaMapViewController ()

@end

@implementation KoreaMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initNavigationControllerSetting];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    if(IS_iPhoneX)
        _naviHeader_iphoneX.constant = 90.0f;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Method

-(void)initNavigationControllerSetting
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.navi_title.text = self.selectedCategory;
}

- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 typedef NS_ENUM(NSInteger, areaCode)
 {
 Seoul               = 1,
 Incheon             = 2,
 Daejeon             = 3,
 Daegu               = 4,
 Gwangju             = 5,
 Busan               = 6,
 Ulsan               = 7,
 Gyeonggido          = 31,
 Gangwondo           = 32,
 Chungcheongbukdo    = 33,
 Chungcheongnamdo    = 34,
 Gyeongsangbukdo     = 35,
 Gyeongsangnamdo     = 36,
 Jeollabukdo         = 37,
 Jeollanamdo         = 38,
 Jeju                = 39
 };
 */

- (IBAction)areaSelected:(UIButton *)sender {
    
    if(sender.tag == Seoul){
        
    }else if(sender.tag == Incheon){
        
    }else if(sender.tag == Daejeon){
        
    }else if(sender.tag == Daegu){
        
    }else if(sender.tag == Gwangju){
        
    }else if(sender.tag == Busan){
        
    }else if(sender.tag == Ulsan){
        
    }else if(sender.tag == Gyeonggido){
        
    }else if(sender.tag == Gangwondo){
        
    }else if(sender.tag == Chungcheongbukdo){
        
    }else if(sender.tag == Chungcheongnamdo){
        
    }else if(sender.tag == Gyeongsangbukdo){
        
    }else if(sender.tag == Gyeongsangnamdo){
        
    }else if(sender.tag == Jeollabukdo){
        
    }else if(sender.tag == Jeollanamdo){
        
    }else if(sender.tag == Jeju){
        
    }
    
}
@end
