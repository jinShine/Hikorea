//
//  SurroundingHeader.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 30..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "SurroundingHeader.h"
#import "MainViewController.h"
#import "FilterViewController.h"

@implementation SurroundingHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)filterBtn:(id)sender {

    _filterVC = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    _filterVC.providesPresentationContextTransitionStyle = YES;
    _filterVC.definesPresentationContext = YES;
    _filterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [_filterVC setMainVC:_mainVC];
    
    [_mainVC presentViewController:_filterVC animated:YES completion:^{
        _mainVC.isPrevModality = YES;
    }];

}


- (IBAction)distanceBtn:(id)sender {
    
    UIAlertController * alertController = [UIAlertController
                                alertControllerWithTitle:@"내 주변 검색 반경"
                                message:@"선택해주세요."
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *distance500m = [UIAlertAction
                         actionWithTitle:@"500m"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             mDistance = @"500";
                             
                             [self.distanceBtnImage setImage:[UIImage imageNamed:@"500m"] forState:UIControlStateNormal];
    
                             [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
                             
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction *distance1km = [UIAlertAction
                         actionWithTitle:@"1Km"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             mDistance = @"1000";
                             
                             [self.distanceBtnImage setImage:[UIImage imageNamed:@"1km"] forState:UIControlStateNormal];

                             [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
                             
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction *distance2km = [UIAlertAction
                         actionWithTitle:@"2Km"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             mDistance = @"2000";
                             
                             [self.distanceBtnImage setImage:[UIImage imageNamed:@"2km"] forState:UIControlStateNormal];

                             [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
                             
                             [alertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction *distance5km = [UIAlertAction
                                  actionWithTitle:@"5Km"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      mDistance = @"5000";
        
                                      [self.distanceBtnImage setImage:[UIImage imageNamed:@"5km"] forState:UIControlStateNormal];
        
                                      [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
        
                                      [alertController dismissViewControllerAnimated:YES completion:nil];
                                  }];
    
    UIAlertAction *distance10km = [UIAlertAction
                                  actionWithTitle:@"10Km"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      mDistance = @"10000";
                                      
                                      [self.distanceBtnImage setImage:[UIImage imageNamed:@"10km"] forState:UIControlStateNormal];
                                      
                                      [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
                                      
                                      [alertController dismissViewControllerAnimated:YES completion:nil];
                                  }];
    
    UIAlertAction *cancel = [UIAlertAction
                                  actionWithTitle:@"취소"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action)
                                  {
                                      [alertController dismissViewControllerAnimated:YES completion:nil];
                                  }];
    
    [alertController addAction:distance500m];
    [alertController addAction:distance1km];
    [alertController addAction:distance2km];
    [alertController addAction:distance5km];
    [alertController addAction:distance10km];
    [alertController addAction:cancel];
    
    
    [_mainVC presentViewController:alertController animated:YES completion:nil];
 
    
}
@end
