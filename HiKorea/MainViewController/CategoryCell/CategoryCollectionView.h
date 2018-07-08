//
//  CategoryCollectionView.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 30..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"
#import "KoreaMapViewController.h"
#import "CategoryCell.h"

@interface CategoryCollectionView : UICollectionViewCell  <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (assign, nonatomic) MainViewController *mainVC;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *categoryImage;
@property (strong, nonatomic) NSArray *categoryTitle;


@end
