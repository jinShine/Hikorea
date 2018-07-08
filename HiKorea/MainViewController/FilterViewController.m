//
//  FilterViewController.m
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "FilterViewController.h"
#import "AppDelegate.h"
#import "SupportingFile.h"

typedef NS_ENUM(NSUInteger, FilterBtnTag) {
    MostViewOrder,
    LatestOrder,
    DistanceOrder,
};

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if(IS_iPhoneX)
        _naviHeader_iphoneX.constant = 90.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (IBAction)popUpDismiss:(id)sender {
    
    _mainVC.isPrevModality = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)orderBtnAction:(id)sender {
    
    if((UIButton *)sender == _mostViewOrder)
    {
        mArrange = @"P";
        
        [_mostViewOrder setImage:[UIImage imageNamed:@"Alignment"] forState:UIControlStateNormal];
        [_latestOrder setImage:[UIImage imageNamed:@"Alignment2_gray"] forState:UIControlStateNormal];
        [_distanceOrder setImage:[UIImage imageNamed:@"Alignment3_gray"] forState:UIControlStateNormal];
        [_mostViewOrder setSelected:YES];
        [_latestOrder setSelected:NO];
        [_distanceOrder setSelected:NO];
    }
    else if((UIButton *)sender == _latestOrder)
    {
        mArrange = @"R";
        
        [_mostViewOrder setImage:[UIImage imageNamed:@"Alignment_gray"] forState:UIControlStateNormal];
        [_latestOrder setImage:[UIImage imageNamed:@"Alignment2"] forState:UIControlStateNormal];
        [_distanceOrder setImage:[UIImage imageNamed:@"Alignment3_gray"] forState:UIControlStateNormal];
        [_mostViewOrder setSelected:NO];
        [_latestOrder setSelected:YES];
        [_distanceOrder setSelected:NO];
    }
    else if((UIButton *)sender == _distanceOrder)
    {
        [_mostViewOrder setImage:[UIImage imageNamed:@"Alignment_gray"] forState:UIControlStateNormal];
        [_latestOrder setImage:[UIImage imageNamed:@"Alignment2_gray"] forState:UIControlStateNormal];
        [_distanceOrder setImage:[UIImage imageNamed:@"Alignment3"] forState:UIControlStateNormal];
        [_mostViewOrder setSelected:NO];
        [_latestOrder setSelected:NO];
        [_distanceOrder setSelected:YES];
        
    }
}


- (IBAction)categoryBtnAction:(id)sender {
    
    if((UIButton *)sender == _touristCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_default"] forState:UIControlStateNormal];
        [_touristCategory setSelected:YES];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
    }
    else if((UIButton *)sender == _culturalCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_default"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:YES];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        
    }
    else if((UIButton *)sender == _festivalCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_default"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:YES];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        
    }
    else if((UIButton *)sender == _travelingCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_default"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:YES];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
    }
    else if((UIButton *)sender == _leportsCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_default"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:YES];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
    }
    else if((UIButton *)sender == _accommodationCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_default"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:YES];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
    }
    else if((UIButton *)sender == _shoppingCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_default"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:YES];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_gray"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:NO];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
    }
    else if((UIButton *)sender == _restaurantCategory)
    {
        [_touristCategory setImage:[UIImage imageNamed:@"category1_gray"] forState:UIControlStateNormal];
        [_touristCategory setSelected:NO];
        [_culturalCategory setImage:[UIImage imageNamed:@"category2_gray"] forState:UIControlStateNormal];
        [_culturalCategory setSelected:NO];
        [_festivalCategory setImage:[UIImage imageNamed:@"category3_gray"] forState:UIControlStateNormal];
        [_festivalCategory setSelected:NO];
        [_travelingCategory setImage:[UIImage imageNamed:@"category4_gray"] forState:UIControlStateNormal];
        [_travelingCategory setSelected:NO];
        [_leportsCategory setImage:[UIImage imageNamed:@"category5_gray"] forState:UIControlStateNormal];
        [_leportsCategory setSelected:NO];
        [_accommodationCategory setImage:[UIImage imageNamed:@"category6_gray"] forState:UIControlStateNormal];
        [_accommodationCategory setSelected:NO];
        [_shoppingCategory setImage:[UIImage imageNamed:@"category7_gray"] forState:UIControlStateNormal];
        [_shoppingCategory setSelected:NO];
        [_restaurantCategory setImage:[UIImage imageNamed:@"category8_default"] forState:UIControlStateNormal];
        [_restaurantCategory setSelected:YES];
        
        [_touristCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_culturalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_festivalCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_travelingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_leportsCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_accommodationCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_shoppingCategoryName setTextColor:[UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]];
        [_restaurantCategoryName setTextColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
    }
}

- (IBAction)filterApplication:(id)sender {
    
    [self setMainVC:_mainVC];
    
    //정렬
    if([_mostViewOrder isSelected] == YES)
    {
        mArrange = @"P";
        _mainVC.isSelectedDistanceOrder = NO;
    }
    
    if([_latestOrder isSelected] == YES)
    {
        mArrange = @"R";
        _mainVC.isSelectedDistanceOrder = NO;
    }
    
    if([_distanceOrder isSelected] == YES)
    {
        _mainVC.isSelectedDistanceOrder = YES;
    }
    
    //카테고리
    if([_touristCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)TouristSpot];
    }
    
    if([_culturalCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)CulturalFacility];
    }
    
    if([_festivalCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)Festival];
    }
    
    if([_travelingCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)TravelingCourse];
    }
    
    if([_leportsCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)Leports];
    }
    
    if([_accommodationCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)Accommodation];
    }
    
    if([_shoppingCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)Shopping];
    }
    
    if([_restaurantCategory isSelected] == YES){
        mContentType = [NSString stringWithFormat:@"%ld",(long)Restaurant];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}
@end
