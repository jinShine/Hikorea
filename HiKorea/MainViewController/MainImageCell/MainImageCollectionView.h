//
//  MainImageCollectionView.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 29..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD.h>

#import "MainViewController.h"
#import "DetailViewController.h"
#import "SupportingFile.h"
#import "MainImageCell.h"


@class MainViewController;

@interface MainImageCollectionView : UICollectionViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (assign, nonatomic) MainViewController *mainVC;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *parserDataSaved;


-(void)festivalParsingData;

@end
