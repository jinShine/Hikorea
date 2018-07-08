//
//  SearchViewController.m
//  HiKorea
//
//  Created by 김승진 on 2018. 4. 19..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    
    //tabBarController선택시 네비게이션 < Hidden
    if(self.tabBarController.selectedIndex == 1)
        [self.closeBtn setHidden:YES];
    else
        [self.closeBtn setHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //SearchBar 세팅
    [self initSearchBarSetting];
    
    [self.noSearchInfoView setHidden:YES];
    
}


-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    if(IS_iPhoneX){
        self.naviHeader_iPhoneX.constant = 146.0f;
        self.titleTop_iPhoneX.constant = 52.0f;
    }
}

#pragma mark -
#pragma mark CustomMethod

-(void)dismissKeyboard{

    NSLog(@"indexPath 선택됨");

    [_searchBar resignFirstResponder];
}

-(void)initSearchBarSetting{
    
    self.searchBar.placeholder = @"무엇을 찾으시나요?";
    
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"search_field"]];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_field"] forState:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"search_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"search_close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchBar setValue:@"취소" forKey:@"_cancelButtonText"];
    self.searchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
}

//거리 계산 알고리즘
-(float)distanceCalculateWithLatitude1:(float)latitude1 longtitude1:(float)longtitude1 latitude2:(float)latitude2 longtitude2:(float)longtitude2{

    CLLocation *pointA = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longtitude1];
    CLLocation *pointB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longtitude2];
    CLLocationDistance distance = [pointA distanceFromLocation:pointB];
    
    return distance;
}

#pragma mark -
#pragma mark TableViewController Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_parserDataSaved count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchDataCell *cell = (SearchDataCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchDataCell" forIndexPath:indexPath];
    
    //MainImage
    [cell.mainImage sd_setImageWithURL:[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"firstimage"] placeholderImage:[UIImage imageNamed:@"Placeholder-image"]];
    
    //Title
    cell.title.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.title.adjustsFontSizeToFitWidth = YES;
    
    //Address
    cell.address.text = [[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"addr1"];
    cell.address.adjustsFontSizeToFitWidth = YES;
    
    //ReadCount
    cell.readCount.text = [NSString stringWithFormat:@"%@",[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"readcount"]];
    cell.readCount.adjustsFontSizeToFitWidth = YES;
    
    //거리
    float latitude = [[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"mapy"]floatValue];
    float longtitude = [[[self.parserDataSaved objectAtIndex:indexPath.row] objectForKey:@"mapx"]floatValue];
    
    float distance =  [self distanceCalculateWithLatitude1:mLatitude longtitude1:mLongtitude latitude2:latitude longtitude2:longtitude];
    
    NSString *distanceCode = @"";
    
    if(distance >= 1000){
        distanceCode = [NSString stringWithFormat:@"%.2lf%@", distance/1000.0,@"km"];
    }else
        distanceCode = [NSString stringWithFormat:@"%.f%@", distance,@"m"];
    
    cell.distance.text = distanceCode;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.selectedArrData = [_parserDataSaved objectAtIndex:indexPath.row];
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    
    [self.navigationController pushViewController:detailVC animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark -
#pragma mark SearchBar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"선택됨");
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Cancel 버튼 선택됨");
    [self.searchBar setShowsCancelButton:NO animated:YES];
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"serchButton Clicked : %@", searchBar.text);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *searchText = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet capitalizedLetterCharacterSet]];
    NSString *contentURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?serviceKey=%@&MobileApp=AppTest&MobileOS=ETC&pageNo=1&startPage=1&numOfRows=100&pageSize=100&listYN=Y&arrange=P&keyword=%@&_type=json",SERVICEKEY,searchText];

    [manager GET:contentURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD show];

        NSLog(@"Search Data : %@",responseObject);
        
        [self handleSuccess:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        [self.searchBar resignFirstResponder];
        [self.searchBar setShowsCancelButton:NO animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"search Error : %@", error);
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
        //noSearchInfoView 숨기기
        [self.noSearchInfoView setHidden:YES];
        [self.view bringSubviewToFront:self.tableView];
        
        NSDictionary *itemsDic = bodyDic[@"items"];
        NSArray *item = [itemsDic objectForKey:@"item"];
        
        if([bodyDic[@"totalCount"] integerValue] == 1)
            [_parserDataSaved addObject:item];
        else
            [_parserDataSaved addObjectsFromArray:item];
        
        [SVProgressHUD dismiss];
    }
    else
    {
        //noSearchInfoView 보이기
        [self.noSearchInfoView setHidden:NO];
        [self.view bringSubviewToFront:self.noSearchInfoView];
        
        [SVProgressHUD dismiss];
    }
}

- (IBAction)closeBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
