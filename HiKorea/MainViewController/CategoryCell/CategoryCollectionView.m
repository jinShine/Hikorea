//
//  CategoryCollectionView.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 30..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "CategoryCollectionView.h"

@implementation CategoryCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    self.categoryImage = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"category1_default"],
                                                    [UIImage imageNamed:@"category2_default"],
                                                    [UIImage imageNamed:@"category3_default"],
                                                    [UIImage imageNamed:@"category4_default"],
                                                    [UIImage imageNamed:@"category5_default"],
                                                    [UIImage imageNamed:@"category6_default"],
                                                    [UIImage imageNamed:@"category7_default"],
                                                    [UIImage imageNamed:@"category8_default"],
                                                    nil];
    
    self.categoryTitle = [[NSArray alloc] initWithObjects:@"관광지",@"문화시설",@"축제",@"여행코스",@"레포츠",@"숙박",@"쇼핑",@"음식점", nil];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCell"];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categoryTitle count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    cell.title.text = [self.categoryTitle objectAtIndex:indexPath.row];
    cell.categoryImage.image = [self.categoryImage objectAtIndex:indexPath.row];
    cell.categoryImage.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(55, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 18, 0, 18);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KoreaMapViewController *detailVC = [[KoreaMapViewController alloc] initWithNibName:@"KoreaMapViewController" bundle:nil];
    detailVC.selectedCategory = [self.categoryTitle objectAtIndex:indexPath.row];
    [self.mainVC.navigationController pushViewController:detailVC animated:YES];
}






@end
