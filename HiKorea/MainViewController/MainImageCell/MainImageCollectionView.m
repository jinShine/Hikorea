//
//  MainImageCollectionView.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 29..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "MainImageCollectionView.h"

@implementation MainImageCollectionView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 8;
    
    self.parserDataSaved = [NSMutableArray array];
    
    [self festivalParsingData];
    
    //Auto Scroll
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollToNextCell) userInfo:nil repeats:YES];
    
    //Register
    [_collectionView registerNib:[UINib nibWithNibName:@"MainImageCell" bundle:nil] forCellWithReuseIdentifier:@"MainImageCell"];
}

#pragma mark -
#pragma mark Method

-(void)scrollToNextCell
{
    CGSize cellSize = CGSizeMake(_collectionView.frame.size.width, 250);
    CGPoint contentOffset = _collectionView.contentOffset;
    
    if(self.pageControl.currentPage < [_parserDataSaved count] - 1)
        [_collectionView scrollRectToVisible:CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height) animated:YES];
    else
        [_collectionView scrollRectToVisible:CGRectMake(0, contentOffset.y, cellSize.width, cellSize.height) animated:NO];
    
}

#pragma mark -
#pragma mark CollectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.parserDataSaved count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainImageCell" forIndexPath:indexPath];
    
    //MainImage
    [cell.mainImage sd_setImageWithURL:[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"firstimage"] placeholderImage:[UIImage imageNamed:@"Logo2"]];
    
    //Title
    cell.title.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.title.adjustsFontSizeToFitWidth = YES;
    
    //Address
    cell.address.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"addr1"];
    cell.address.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width, 250);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"선택 메인 이미지 : %@", [self.parserDataSaved objectAtIndex:indexPath.row]);
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.selectedArrData = [self.parserDataSaved objectAtIndex:indexPath.row];
    
    [self.mainVC.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark -
#pragma mark NetworkParsing

-(void)festivalParsingData
{
    NSString *culturalFacilityURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=%@&pageNo=1&startPage=1&numOfRows=8&pageSize=10&MobileApp=HiKorea&MobileOS=IOS&arrange=R&contentTypeId=%ld&listYN=Y&_type=json",SERVICEKEY,(long)Festival];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:culturalFacilityURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"touristSpotParsingData : %@", error.localizedDescription);
    }];
}

-(void)handleSuccess:(id)responseObject
{
    //jsonParsing
    NSDictionary *responseDic = responseObject[@"response"];
    NSDictionary *bodyDic = responseDic[@"body"];
    
    if([bodyDic[@"totalCount"] integerValue] > 0)
    {
        NSDictionary *itemsDic = bodyDic[@"items"];
        NSArray *item = [itemsDic objectForKey:@"item"];
        
        if([bodyDic[@"totalCount"] integerValue] == 1)
            [_parserDataSaved addObject:item];
        else
            [_parserDataSaved addObjectsFromArray:item];

    }
    
    [self.collectionView reloadData];
}
@end
