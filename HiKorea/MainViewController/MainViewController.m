//
//  MainViewController.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //CollectionView Delegate
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    if(_parserDataSaved == nil)
    {
        [self initLocationSetting];
        
        //Extern 디폴트 저장
        mContentType = [NSString stringWithFormat:@"%ld",TouristSpot];
        mArrange = @"P";
        mDistance = [NSString stringWithFormat:@"%d",1000];
    }
    
    //Register
    [self collectionViewRegisterNib];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    //필터 모달 종료시 통신
    if(self.isPrevModality == YES)
    {
        self.isPrevModality = NO;
        
        [self parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark Custom Method

-(void)initLocationSetting
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //사용중에만 위치 정보 요청
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

-(void)collectionViewRegisterNib
{
    [_collectionView registerNib:[UINib nibWithNibName:@"MainImageCollectionView" bundle:nil] forCellWithReuseIdentifier:@"MainImageCollectionView"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionView" bundle:nil] forCellWithReuseIdentifier:@"CategoryCollectionView"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SurroundingCell" bundle:nil] forCellWithReuseIdentifier:@"SurroundingCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CategoryHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CategoryHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SurroundingHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SurroundingHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"NoDataInfoCell" bundle:nil] forCellWithReuseIdentifier:@"NoDataInfoCell"];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusDenied)
    {
        NSLog(@"%s : ","kCLAuthorizationStatusDenied");
        
        SCLAlertView *alertView = [[SCLAlertView alloc] init];

        [alertView addButton:@"확인" actionBlock:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                if(success)
                    NSLog(@"openURL Success");
            }];
        }];
        
        [alertView showNotice:self title:@"현재 위치" subTitle:@"현재 위치를 불러 올 수 없습니다.\n 보다 편리한 검색을 위해 위치서비스를 사용해 보세요.\n iOS 기기의 [설정] > [HiKorea] > [위치]를 ON으로 설정해주세요."
             closeButtonTitle:@"close" duration:0.0f];
    }
    else if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"%s : ","kCLAuthorizationStatusAuthorizedWhenInUse");
        
        self.isLocationAuthorizedUse = YES;
        
        mLongtitude = self.locationManager.location.coordinate.longitude;
        mLatitude = self.locationManager.location.coordinate.latitude;
        
        [self parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
        
    }
}

//거리 계산 알고리즘
-(float)distanceCalculateWithLatitude1:(float)latitude1 longtitude1:(float)longtitude1 latitude2:(float)latitude2 longtitude2:(float)longtitude2{
    
    CLLocation *pointA = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longtitude1];
    CLLocation *pointB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longtitude2];
    CLLocationDistance distance = [pointA distanceFromLocation:pointB];

    return distance;
}

//순차 알고리즘
-(void)orderedSorting
{
    self.isSelectedDistanceOrder = YES;
    
    for(NSInteger idx = 0; idx < [_parserDataSaved count]; idx++)
    {
        //거리
        float latitude = [[[self.parserDataSaved objectAtIndex:idx] objectForKey:@"mapy"]floatValue];
        float longtitude = [[[self.parserDataSaved objectAtIndex:idx] objectForKey:@"mapx"]floatValue];
        
        float minDistance = [self distanceCalculateWithLatitude1:self.locationManager.location.coordinate.latitude longtitude1:self.locationManager.location.coordinate.longitude latitude2:latitude longtitude2:longtitude];
        
        NSInteger minIndex = idx;
        
        for(NSInteger jdx = idx+1; jdx < [_parserDataSaved count]; jdx++)
        {
            float latitude = [[[self.parserDataSaved objectAtIndex:jdx] objectForKey:@"mapy"]floatValue];
            float longtitude = [[[self.parserDataSaved objectAtIndex:jdx] objectForKey:@"mapx"]floatValue];
            float compareDistance = [self distanceCalculateWithLatitude1:self.locationManager.location.coordinate.latitude longtitude1:self.locationManager.location.coordinate.longitude latitude2:latitude longtitude2:longtitude];
            
            if( minDistance > compareDistance)
            {
                minDistance = compareDistance;
                minIndex = jdx;
            }
        }
        
        [_parserDataSaved exchangeObjectAtIndex:idx withObjectAtIndex:minIndex];
        
    }
}


- (IBAction)naviRefreshBtn:(UIBarButtonItem *)sender {
    
    //MainImageCell
    MainImageCollectionView *mainImageCV = [[MainImageCollectionView alloc] init];
    [mainImageCV setMainVC:self];
    [mainImageCV festivalParsingData];
    
    //Surrounding
    [self initLocationSetting];
}

#pragma mark -
#pragma mark NetworkParsing

-(void)parsingDataWithContentType:(NSString *)contentType withArrange:(NSString *)arrange withLongtitude:(float)longtitude withLatitude:(float)latitude withDistance:(NSString *)distance
{
    //서울역 Default값
    if(longtitude == 0 || latitude == 0)
    {
        longtitude = 37.553186;
        latitude = 126.971988;
    }
    
    NSString *contentURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=%@&numOfRows=9999&pageNo=1&startPage=1&MobileOS=IOS&MobileApp=HiKorea&contentTypeId=%@&arrange=%@&mapX=%lf&mapY=%lf&radius=%@&listYN=Y&_type=json",SERVICEKEY,contentType,arrange,longtitude,latitude,distance];
    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:contentURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        NSLog(@"Receive Data : %@",responseObject);
        
        [self handleSuccess:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        SCLAlertView *alertView = [[SCLAlertView alloc] init];
        [alertView showError:self title:@"서버 점검" subTitle:@"현재 서버 점검 중입니다.\n서비스 이용에 불편을 드려 죄송합니다.\n신속하게 완료하여 보다 안정적인 서비스가 되도록 하겠습니다." closeButtonTitle:@"앱 종료" duration:0.0f];

        [alertView alertIsDismissed:^{
            NSLog(@"앱 종료");
            exit(0);
        }];
        
        NSLog(@"touristSpotParsingData : %@", error.localizedDescription);
    }];

}

-(void)handleSuccess:(id)responseObject
{
    _parserDataSaved = [NSMutableArray new];
    
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
        
        if(self.isSelectedDistanceOrder == YES)
        {
            //오름차순 순차 알고리즘
            [self orderedSorting];
        }
        
        [SVProgressHUD dismiss];
    }
    else
    {
        if(self.isNoData == NO){
            self.isNoData = YES;
            
            NSString *noDataInfo = @"현재 위치에서 정보를 찾을 수 없습니다.";
            NSDictionary *noDataDic = [NSDictionary dictionaryWithObject:noDataInfo forKey:@"noDataInfo"];
            
            [_parserDataSaved addObject:noDataDic];
            
            [SVProgressHUD dismiss];
        }
    }
}

#pragma mark -
#pragma mark CollectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return SectionToTal;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemCount = 0;
        
    switch (section)
    {
        case MainImageSection:
        {
            if(self.isLocationAuthorizedUse == YES)
                itemCount = 1;
            else
                itemCount = 0;
        }
            break;
        case CategorySection:
            itemCount = 1;
            break;
        case SurroundingSection:
            itemCount = [_parserDataSaved count];
            break;
        default:
            break;
    }
    return itemCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case MainImageSection:{
            MainImageCollectionView *cell = (MainImageCollectionView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MainImageCollectionView" forIndexPath:indexPath];
            [cell setMainVC:self];
            
            return cell;
        }
            break;
        case CategorySection:{
            CategoryCollectionView *cell = (CategoryCollectionView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionView" forIndexPath:indexPath];
            
            [cell setMainVC:self];
            
            return cell;
        }
            break;
        case SurroundingSection:
        {
            if(self.isNoData == YES){
                self.isNoData = NO;
                
                NoDataInfoCell *cell = (NoDataInfoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NoDataInfoCell" forIndexPath:indexPath];
                cell.noDataInfo.text = [[_parserDataSaved valueForKey:@"noDataInfo"] objectAtIndex:0];
                
                [self.collectionView setAllowsSelection:NO];
                
                return cell;
            }else{
                
                [self.collectionView setAllowsSelection:YES];
                
                SurroundingCell *cell = (SurroundingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SurroundingCell" forIndexPath:indexPath];
                
                [cell.mainImage sd_setImageWithURL:[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"firstimage"] placeholderImage:[UIImage imageNamed:@"Placeholder-image"]];
                
                cell.mainTitle.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"title"];
                cell.mainTitle.adjustsFontSizeToFitWidth = YES;
                
                cell.address.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"addr1"];
                cell.address.adjustsFontSizeToFitWidth = YES;
                
                if([[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"readcount"] != nil)
                    cell.readCount.text = [NSString stringWithFormat:@"%@",[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"readcount"]];
                else
                    cell.readCount.text = @"0";
                
                //거리
                float latitude = [[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"mapy"]floatValue];
                float longtitude = [[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"mapx"]floatValue];
                
                float distance =  [self distanceCalculateWithLatitude1:self.locationManager.location.coordinate.latitude longtitude1:self.locationManager.location.coordinate.longitude latitude2:latitude longtitude2:longtitude];
                
                NSString *distanceCode = @"";
                
                if(distance >= 1000){
                    distanceCode = [NSString stringWithFormat:@"%.2lf%@", distance/1000.0,@"km"];
                }else
                    distanceCode = [NSString stringWithFormat:@"%.f%@", distance,@"m"];
                
                cell.location.text = distanceCode;
                
                return cell;
            }
        }
            break;
        default:
            return nil;
            break;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.selectedArrData = [_parserDataSaved objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    
    switch (indexPath.section) {
        case MainImageSection:
            itemSize = CGSizeMake(_collectionView.frame.size.width, 250);
            break;
        case CategorySection:
            itemSize = CGSizeMake(_collectionView.frame.size.width, 80);
            break;
        case SurroundingSection:
        {
            if(self.isNoData == YES)
                itemSize = CGSizeMake(_collectionView.frame.size.width, 100);
            else
                itemSize = CGSizeMake((_collectionView.frame.size.width / 2) - 15, 230);
        }
            break;
        default:
            break;
    }
    
    return itemSize;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insetForSection = UIEdgeInsetsZero;
    
    switch (section) {
        case MainImageSection:
            insetForSection = UIEdgeInsetsMake(0, 0, 24, 0);
            break;
        case CategorySection:
            insetForSection = UIEdgeInsetsMake(10, 30, 30, 30);
            break;
        case SurroundingSection:
            insetForSection = UIEdgeInsetsMake(10, 10, 10, 10);
            break;
        default:
            break;
    }
    
    return insetForSection;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat minimumLineSpacing = 0.0f;

    switch (section) {
        case MainImageSection:
            minimumLineSpacing = 0.0f;
            break;
        case CategorySection:
            minimumLineSpacing = 0.0f;
            break;
        case SurroundingSection:
            minimumLineSpacing = 0.0f;
        default:
            break;
    }

    return minimumLineSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
        CGFloat interItemSpacing = 0.0f;
    
        switch (section) {
            case MainImageSection:
                interItemSpacing = 0.0f;
                break;
            case CategorySection:
                interItemSpacing = 0.0f;
                break;
            case SurroundingSection:
                break;
            default:
                break;
        }

    return interItemSpacing;
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case MainImageSection:{
            return nil;
        }
            break;
        case CategorySection:{
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CategoryHeader" forIndexPath:indexPath];
            
            return headerView;
        }
            break;
        case SurroundingSection:
        {
            SurroundingHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SurroundingHeader" forIndexPath:indexPath];
            [headerView setMainVC:self];
            
            return headerView;
        }
            break;
            
        default:
        {
            return nil;
        }
            break;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize headerSize = CGSizeZero;
    
    switch (section) {
        case MainImageSection:
            break;
        case CategorySection:
            headerSize = CGSizeMake(self.collectionView.frame.size.width, 50);
            break;
        case SurroundingSection:
            headerSize = CGSizeMake(self.collectionView.frame.size.width, 50);
            break;
        default:
            break;
    }
    
    return headerSize;
}

- (IBAction)searchBtnAction:(UIBarButtonItem *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *searchVC = (SearchViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    
    [self.navigationController pushViewController:searchVC animated:YES];

}
@end
