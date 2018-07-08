//
//  MainViewController.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

#import <SVProgressHUD.h>
#import <SCLAlertView.h>

#import "AppDelegate.h"
#import "FilterViewController.h"
#import "MainImageCell/MainImageCollectionView.h"
#import "CategoryCell/CategoryCollectionView.h"
#import "NoDataInfoCell.h"
#import "SurroundingCell/SurroundingHeader.h"
#import "SurroundingCell/SurroundingCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"



typedef NS_ENUM(NSUInteger, HomeSectionType) {
    MainImageSection = 0,
    CategorySection,
    SurroundingSection,
    
    SectionToTal
};


@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate>


//collectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//locationManager
@property (strong, nonatomic) CLLocationManager *locationManager;

//정보를 찾을 수 없습니다.
@property (weak, nonatomic) UIView *noDataInfoView;

//ParsingDatas
@property (strong, nonatomic) NSMutableArray *parserDataSaved;

//FilterVC
@property (strong, nonatomic) FilterViewController *filterVC;

@property (nonatomic) BOOL isPrevModality; // 모달인지 판단
@property (nonatomic) BOOL isSelectedDistanceOrder; //필터에 거리순 체크
@property (nonatomic) BOOL isLocationAuthorizedUse; //권한 허용
@property (nonatomic) BOOL isNoData;


- (IBAction)naviRefreshBtn:(UIBarButtonItem *)sender;
- (IBAction)searchBtnAction:(UIBarButtonItem *)sender;

//Parsing 메소드
-(void)parsingDataWithContentType:(NSString *)contentType withArrange:(NSString *)arrange withLongtitude:(float)longtitude withLatitude:(float)latitude withDistance:(NSString *)distance;

-(void)initLocationSetting;

@end
