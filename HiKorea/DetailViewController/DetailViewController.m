//
//  DetailViewController.m
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 28..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) NSInteger overViewHeight;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //Back Gesture
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    //정보 Data 파싱
    [self parsingDataWithContentID:[_selectedArrData valueForKey:@"contentid"] withContentType:[_selectedArrData valueForKey:@"contenttypeid"]];
    
    //이미지 Data 파싱
    [self parsingImageWithContentID:[_selectedArrData valueForKey:@"contentid"] withContentType:[_selectedArrData valueForKey:@"contenttypeid"]];
    
    //소개정보 Data 파싱
    [self parsingIntroduceDataWithContentID:[_selectedArrData valueForKey:@"contentid"] withContentType:[_selectedArrData valueForKey:@"contenttypeid"]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0f);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailMainImageCell" bundle:nil] forCellReuseIdentifier:@"DetailMainImageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OverViewCell" bundle:nil] forCellReuseIdentifier:@"OverViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MapInfoViewCell" bundle:nil] forCellReuseIdentifier:@"MapInfoViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultViewCell" bundle:nil] forCellReuseIdentifier:@"DefaultViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction)];
    [leftButton setTintColor:[UIColor colorWithRed:43.0f/255.0f green:64.0f/255.0f blue:107.0f/255.0f alpha:1]];
    self.navigationItem.leftBarButtonItem = leftButton;

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view setFrame:CGRectMake(0, (IS_iPhoneX ? -88.0f : -64.0f) ,self.view.frame.size.width, self.view.frame.size.height + (IS_iPhoneX ? 88.0f : 64.0f))];
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
#pragma mark NetworkParsing

-(void)parsingDataWithContentID:(NSString *)contentID withContentType:(NSString *)contentType
{
    NSString *contentURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=%@&numOfRows=1&pageSize=1&pageNo=1&startPage=1&MobileOS=IOS&MobileApp=HiKorea&contentId=%@&contentTypeId=%@&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&_type=json",SERVICEKEY,contentID,contentType];

    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:contentURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"공통정보 조회 : %@",responseObject);
         
         [self handleSuccess:responseObject];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"touristSpotParsingData : %@", error.localizedDescription);
     }];
    
    
}

-(void)parsingImageWithContentID:(NSString *)contentID withContentType:(NSString *)contentType
{
    NSString *imageURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailImage?serviceKey=%@&numOfRows=10&pageSize=10&pageNo=1&startPage=1&MobileOS=IOS&MobileApp=HiKorea&contentId=%@&contentTypeId=%@&imageYN=Y&_type=json",SERVICEKEY,contentID,contentType];
    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:imageURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"이미지정보 조회 : %@",responseObject);
        
        _imageDataArr = [NSMutableArray new];
        
        NSDictionary *responseDic = responseObject[@"response"];
        NSDictionary *bodyDic = responseDic[@"body"];
        
        if([bodyDic[@"totalCount"] integerValue] > 1)
        {
            NSDictionary *itemsDic = bodyDic[@"items"];
            NSArray *item = [itemsDic objectForKey:@"item"];
            
            for(NSMutableArray *itemArr in item)
            {
                [_imageDataArr addObject:[itemArr valueForKey:@"originimgurl"]];
            }

            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"touristSpotParsingData : %@", error.localizedDescription);
    }];
}

-(void)parsingIntroduceDataWithContentID:(NSString *)contentID withContentType:(NSString *)contentType
{
    NSString *imageURL = [NSString stringWithFormat:@"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?serviceKey=%@&numOfRows=10&pageSize=10&pageNo=1&startPage=1&MobileOS=IOS&MobileApp=HiKorea&contentId=%@&contentTypeId=%@&introYN=Y&_type=json",SERVICEKEY,contentID,contentType];
    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:imageURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"소개정보 조회 : %@",responseObject);
        
        _introduceDataArr = [NSMutableDictionary new];
        
        NSDictionary *responseDic = responseObject[@"response"];
        NSDictionary *bodyDic = responseDic[@"body"];
        
        if([bodyDic[@"totalCount"] integerValue] > 0)
        {
            NSDictionary *itemsDic = bodyDic[@"items"];
            
            _introduceDataArr = [itemsDic objectForKey:@"item"];

            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"touristSpotParsingData : %@", error.localizedDescription);
    }];
}

-(void)handleSuccess:(id)responseObject
{
    _parserDataArr = [NSMutableArray array];
    
    //jsonParsing
    NSDictionary *responseDic = responseObject[@"response"];
    NSDictionary *bodyDic = responseDic[@"body"];

    if([bodyDic[@"totalCount"] integerValue] > 0)
    {
        NSDictionary *itemsDic = bodyDic[@"items"];
        NSArray *item = [itemsDic objectForKey:@"item"];
        
        if([bodyDic[@"totalCount"] integerValue] == 1)
            [_parserDataArr addObject:item];
        else
            [_parserDataArr addObjectsFromArray:item];
        
        [SVProgressHUD dismiss];
    }
}



#pragma mark -
#pragma mark TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DetailSectionTotal;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == MainImageSetion)
        return MainImageRowTotal;
    else if(section == MapInfoViewSection)
        return MapInfoRowTotal;
    else if(section == DefaultInfoSection)
    {
        if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == TouristSpot)
            return TouristSpotRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == CulturalFacility)
            return CulturalFacilityRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == Festival)
            return FestivalRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == TravelingCourse)
            return TravelingCourseRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == Leports)
            return LeportsRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == Accommodation)
            return AccommodationRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == Shopping)
            return ShoppingRowTotal;
        else if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == Restaurant)
            return RestaurantRowTotal;
        else
            return [_introduceDataArr count] + 1;
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == MainImageSetion)
    {
        if(indexPath.row == ImageRow)
        {
            DetailMainImageCell *cell = (DetailMainImageCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailMainImageCell"];
            [cell setDetailVC:self];

            for(NSInteger i = 0; i<[_imageDataArr count]; i++)
            {
                cell.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(cell.pageScrollView.frame.size.width * i, 0, cell.pageScrollView.frame.size.width, cell.pageScrollView.frame.size.height)];
                
                [cell.mainImage sd_setImageWithURL:[_imageDataArr objectAtIndex:i]];
                
                [cell.pageScrollView addSubview:cell.mainImage];
            }
            
            cell.imageTotalCount = [_imageDataArr count];
            cell.pageScrollView.pagingEnabled = YES;
            
            // (page/pageScrollView)
            [cell.pageScrollView setContentSize:CGSizeMake(cell.pageScrollView.frame.size.width * [_imageDataArr count], cell.pageScrollView.frame.size.height)];
            CGFloat pageWidth = cell.pageScrollView.frame.size.width;
            NSInteger page = floor(((cell.pageScrollView.contentOffset.x / pageWidth)) + 1);
            [cell.pageControl setText:[NSString stringWithFormat:@"%ld/%ld", (long)page,(long)[_imageDataArr count]]];
            
            //placeholder 이미지 통신으로 넣기
            if(_imageDataArr != nil && [_imageDataArr count] == 0)
            {
                [cell.mainImage sd_setImageWithURL:[_selectedArrData valueForKey:@"firstimage"]];
                [cell.pageControl setText:[NSString stringWithFormat:@"1/1"]];
            }
            
            return cell;
        }
        else if(indexPath.row == TitleRow)
        {
            TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:@"TitleCell"];

            cell.title.text = [_selectedArrData valueForKey:@"title"];
            
            NSString *subAddress = [_selectedArrData valueForKey:@"addr2"];
            if(subAddress != nil)
            {
                subAddress = [subAddress stringByReplacingOccurrencesOfString:@"(" withString:@""];
                subAddress = [subAddress stringByReplacingOccurrencesOfString:@")" withString:@""];
                cell.subAddress.text = [NSString stringWithFormat:@" %@   |",subAddress];
            }
            else if([_selectedArrData containsObject:@"addr1"] != NO)
            {
                subAddress = [_selectedArrData valueForKey:@"addr1"];
                cell.subAddress.text = [NSString stringWithFormat:@" %@   |",subAddress];
            }
            else{
                subAddress = @"";
                cell.subAddress.text = [NSString stringWithFormat:@"%@",subAddress];
            }
            
            cell.readCount.text = [NSString stringWithFormat:@"%ld",(long)[[_selectedArrData valueForKey:@"readcount"] integerValue]];
            
            if([[_selectedArrData valueForKey:@"contenttypeid"]integerValue] == TouristSpot){
                if([[_introduceDataArr valueForKey:@"heritage1"]integerValue] == 1){
                    cell.info1.image = [UIImage imageNamed:@"heritage1"];
                    [cell.info1 setHidden:NO];
                }
                else if([[_introduceDataArr valueForKey:@"herigate2"]integerValue] == 1){
                    cell.info1.image = [UIImage imageNamed:@"heritage2"];
                    [cell.info1 setHidden:NO];
                }
                else if([[_introduceDataArr valueForKey:@"herigate3"]integerValue] == 1){
                    cell.info1.image = [UIImage imageNamed:@"heritage3"];
                    [cell.info1 setHidden:NO];
                }
                else
                    [cell.info1 setHidden:YES];
                
                if([[_selectedArrData valueForKey:@"booktour"]integerValue] == 1 && [cell.info1 isHidden] == YES){
                    cell.info1.image = [UIImage imageNamed:@"booktour"];
                    [cell.info1 sizeToFit];
                    [cell.info1 setFrame:CGRectMake(cell.info1.frame.origin.x, cell.info1.frame.origin.y, cell.info1.frame.size.width + 30, cell.info1.frame.size.height)];
                    [cell.info1 setHidden:NO];
                }
                else if([[_selectedArrData valueForKey:@"booktour"]integerValue] == 1 && [cell.info1 isHidden] == NO){
                    cell.info2.image = [UIImage imageNamed:@"booktour"];
                    
                    [cell.info2 setHidden:NO];
                }
            }
            
            return cell;
            
        }
        else if(indexPath.row == OverViewRow)
        {
            OverViewCell *cell = (OverViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OverViewCell"];
            
            NSString *overViewStr = @"";
            
            if([[[_parserDataArr objectAtIndex:0] objectForKey:@"overview"] isEqualToString:@""] || [[_parserDataArr objectAtIndex:0] objectForKey:@"overview"] != nil)
            {
                overViewStr = [self removeTextTag:[[_parserDataArr objectAtIndex:0] objectForKey:@"overview"]];
            }
            
            //Line Spacing
            cell.overView.attributedText = [self lineSpacingControlWithTypeCell:cell withString:overViewStr];

            return cell;
        }
    }
    else if(indexPath.section == MapInfoViewSection)
    {
        if(indexPath.row == MapInfoRow)
        {
            MapInfoViewCell *cell = (MapInfoViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MapInfoViewCell"];
            [cell setDetailVC:self];
            
            cell.selectedArrData = _parserDataArr;
            
            double longtitude = [[_selectedArrData valueForKey:@"mapx"] doubleValue];
            double latitude = [[_selectedArrData valueForKey:@"mapy"] doubleValue];
            cell.camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longtitude zoom:15];
            cell.mapView.camera = cell.camera;
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude, longtitude);
            if(![[_selectedArrData valueForKey:@"title"] isEqualToString:@""])
                marker.title = [_selectedArrData valueForKey:@"title"];
            if(![[_selectedArrData valueForKey:@"addr2"] isEqualToString:@""])
                marker.snippet = [_selectedArrData valueForKey:@"addr2"];
            marker.map = cell.mapView;
            
            return cell;
        }
    }
    else if(indexPath.section == DefaultInfoSection)
    {
        DefaultViewCell *cell = (DefaultViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DefaultViewCell"];

        [self defaultInfoCell:cell withContentTypeID:[[_selectedArrData valueForKey:@"contenttypeid"]integerValue] withCellForRowAtIndexPath:indexPath];

        return cell;
        
    }
    
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
            return 250.0f;
        else if(indexPath.row == 1)
            return 85.0f;
        else if(indexPath.row == 2) // overview
            return UITableViewAutomaticDimension;
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
            return 150.0f;
    }
    else if(indexPath.section == 2)
    {
        return UITableViewAutomaticDimension;
    }
    
    return 50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 1.0f;
    
    return 5.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            
        }
    }
    else if(indexPath.section == 1)
    {
        
    }
    else if(indexPath.section == 2)
    {
        NSString *homepageAddress;
        
        //축제(15) 일때만 첫번째 주소로 이동
        if([[_introduceDataArr valueForKey:@"contenttypeid"]integerValue] == Festival){
            if(indexPath.row == 0){
                homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_introduceDataArr valueForKey:@"bookingplace"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                if(![homepageAddress isEqualToString:@""])
                    [self openURLDeleveryAddress:homepageAddress];
            }
        }else // 그 외는 전화통화로 추가
        {
            
        }
        
        if(indexPath.row == 1)
        {
            homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
            [self openURLDeleveryAddress:homepageAddress];
        }
        
    }
}

#pragma mark -
#pragma mark Method

-(void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableAttributedString *)lineSpacingControlWithTypeCell:(UITableViewCell *)cell withString:(NSString *)string{
    
    //Line Spacing
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:string];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:3];

    if([cell isKindOfClass:[OverViewCell class]]){
        [style setAlignment:NSTextAlignmentLeft];
    }
    else if([cell isKindOfClass:[DefaultViewCell class]]){
        
        if(string.length >= 100)
            [style setAlignment:NSTextAlignmentLeft];
        else
            [style setAlignment:NSTextAlignmentRight];
    }
        
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, string.length)];
    
    return attrString;
}

-(NSString *)removeTextTag:(NSString *)string
{
    NSRange range = [string rangeOfString:@"<br />"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<br />" withString:@"\r"];
    
    range = [string rangeOfString:@"<br/>"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\r"];
    
    range = [string rangeOfString:@"<br>"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r"];
    
    range = [string rangeOfString:@"<BR>"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\r"];
    
    range = [string rangeOfString:@"<BR />"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\r"];
    
    range = [string rangeOfString:@"&nbsp;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    range = [string rangeOfString:@"&rsquo;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
    
    range = [string rangeOfString:@"<strong>"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"<strong>" withString:@"*"];
    
    range = [string rangeOfString:@"</strong>"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"</strong>" withString:@"*"];
    
    range = [string rangeOfString:@"&middot;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    
    range = [string rangeOfString:@"&ldquo;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    
    range = [string rangeOfString:@"&rdquo;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    
    range = [string rangeOfString:@"&lsquo;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"'"];
    
    range = [string rangeOfString:@"&gt;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    range = [string rangeOfString:@"&lt;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    
    range = [string rangeOfString:@"\n"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    range = [string rangeOfString:@"&sim;"];
    if(range.location != NSNotFound)
        string = [string stringByReplacingOccurrencesOfString:@"&sim;" withString:@"~"];

    return string;
}

-(void)openURLDeleveryAddress:(NSString *)AddressString
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:AddressString]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AddressString] options:@{} completionHandler:^(BOOL success) {
            if(success)
                NSLog(@"URL open 성공");
        }];
}

-(void)defaultInfoCell:(DefaultViewCell *)cell withContentTypeID:(NSInteger)contentTypeID withCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *infoString = @"";

    if(contentTypeID == TouristSpot){
        TouristSpotModel *touristSpotModel = [[TouristSpotModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case infocenterRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.infocenter]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.infocenter == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"call"];
            }
                break;
            case touristSpotHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                if([_parserDataArr valueForKey:@"homepage"] == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.text = homepageAddress;
                
                cell.titleImage.image = [UIImage imageNamed:@"browser"];
            }
                break;
            case opendateRow:
            {
                cell.titleText.text = @"개장일";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.opendate]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.opendate == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"disc"];
            }
                break;
            case restdateRow:
            {
                cell.titleText.text = @"쉬는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.restdate]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.restdate == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"x-circle"];
            }
                break;
            case usetimeRow:
            {
                cell.titleText.text = @"이용시간";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.usetime]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.usetime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"clock"];
            }
                break;
            case parkingRow:
            {
                cell.titleText.text = @"주차시설";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.parking]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.parking == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_local_parking"];
            }
                break;
            case accomcountRow:
            {
                cell.titleText.text = @"수용인원";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.accomcount]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.accomcount == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"users"];
                
            }
                break;
            case expguideRow:
            {
                cell.titleText.text = @"체험안내";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.expguide]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.expguide == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"game_controller_round"];
            }
                break;
            case expagerangeRow:
            {
                cell.titleText.text = @"체험가능 연령";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.expagerange]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.expagerange == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"emoji_happy_circle"];
            }
                break;
            case chkpetRow:
            {
                cell.titleText.text = @"애완동물 가능 여부";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",touristSpotModel.chkpet]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(touristSpotModel.chkpet == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"dog"];
            }
                break;
            default:
                return;
                break;
        }
    }else if(contentTypeID == CulturalFacility){
        CulturalFacilityModel *culturalFacilityModel = [[CulturalFacilityModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case infocentercultureRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.infocenterculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.infocenterculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"call"];
            }
                break;
            case culturalFacilityHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];

                if([_parserDataArr valueForKey:@"homepage"] == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
                
                cell.titleImage.image = [UIImage imageNamed:@"browser"];
            }
                break;
            case restdatecultureRow:
            {
                cell.titleText.text = @"쉬는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.restdateculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.restdateculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"x-circle"];
            }
                break;
            case usetimecultureRow:
            {
                cell.titleText.text = @"이용시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.usetimeculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.usetimeculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"clock"];
            }
                break;
            case usefeeRow:
            {
                cell.titleText.text = @"이용요금";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.usefee]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.usefee == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];

                cell.titleImage.image = [UIImage imageNamed:@"Purse"];
            }
                break;
            case discountinfoRow:
            {
                cell.titleText.text = @"할인정보";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.discountinfo]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.discountinfo == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];

                cell.titleImage.image = [UIImage imageNamed:@"ic_trending_down"];
                
            }
                break;
            case scaleRow:
            {
                cell.titleText.text = @"규모";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.scale]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.scale == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_business"];
                
            }
                break;
            case spendtimeRow:
            {
                cell.titleText.text = @"관람 소요시간";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.spendtime]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.spendtime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_access_alarm"];
            }
                break;
            case parkingcultureRow:
            {
                cell.titleText.text = @"주차시설";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.parkingculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.parkingculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_local_parking"];
            }
                break;
            case parkingfeeRow:
            {
                cell.titleText.text = @"주차요금";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.parkingfee]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.parkingfee == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"Parking_Cost"];
            }
                break;
            case accomcountcultureRow:
            {
                cell.titleText.text = @"수용인원";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.accomcountculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.accomcountculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"users"];
            }
                break;
            case chkpetcultureRow:
            {
                cell.titleText.text = @"애완동물 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",culturalFacilityModel.chkpetculture]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(culturalFacilityModel.chkpetculture == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"dog"];
            }
                break;
                
            default:
                break;
        }
    }else if(contentTypeID == Festival){
        FestivalModel *festivalModel = [[FestivalModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case bookingplaceRow:
            {
                cell.titleText.text = @"예매처";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.bookingplace]];
                
                //주소가 들어있으면 주소로 표현.
                if([infoString rangeOfString:@"<a href"].location != NSNotFound){
                    infoString = [[[[[NSString stringWithFormat:@"%@",infoString] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                }
                
                    
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.bookingplace == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"call"];
            }
                break;
            case festivalHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                
                if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(homepageAddress == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(festivalModel.eventhomepage != nil)
                    cell.contentText.text = festivalModel.eventhomepage;
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
                
                cell.titleImage.image = [UIImage imageNamed:@"browser"];
                
            }
                break;
            case eventstartdateRow:
            {
                cell.titleText.text = @"행사 시작일";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.eventstartdate]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(festivalModel.eventstartdate == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"disc"];
            }
                break;
            case eventenddateRow:
            {
                cell.titleText.text = @"행사 종료일";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.eventenddate]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.eventenddate == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"x-circle"];
                
            }
                break;
            case discountinfofestivalRow:
            {
                cell.titleText.text = @"할인정보";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.discountinfofestival]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.discountinfofestival == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_trending_down"];
                
            }
                break;
            case agelimitRow:
            {
                cell.titleText.text = @"관람 가능 연령";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.agelimit]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.agelimit == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"eyes"];
            }
                break;
            case eventplaceRow:
            {
                cell.titleText.text = @"행사 장소";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.eventplace]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.eventplace == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"Pin"];
                
            }
                break;
            case placeinfoRow:
            {
                cell.titleText.text = @"행사장 위치안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.placeinfo]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.placeinfo == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"ic_navigation"];
            }
                break;
            case playtimeRow:
            {
                cell.titleText.text = @"공연시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.playtime]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.playtime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"calendar"];
            }
                break;
            case programRow:
            {
                cell.titleText.text = @"행사 프로그램";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.program]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음" ];
                else if(festivalModel.program == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case spendtimefestivalRow:
            {
                cell.titleText.text = @"관람 소요시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.spendtimefestival]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.spendtimefestival == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
                cell.titleImage.image = [UIImage imageNamed:@"clock"];
                
            }
                break;
            case sponsor1Row:
            {
                cell.titleText.text = @"주최자 정보";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.sponsor1]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.sponsor1 == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case sponsor1telRow:
            {
                cell.titleText.text = @"주최자 연락처";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.sponsor1tel]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.sponsor1tel == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case sponsor2Row:
            {
                cell.titleText.text = @"주관자 정보";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.sponsor2]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.sponsor2 == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case sponsor2telRow:
            {
                cell.titleText.text = @"주관자 연락처";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.sponsor2tel]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.sponsor2tel == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case subeventRow:
            {
                cell.titleText.text = @"부대행사";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",festivalModel.subevent]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(festivalModel.subevent == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
                
            default:
                break;
        }
    }else if(contentTypeID == TravelingCourse){
        TravelingCourseModel *travelingCourseModel = [[TravelingCourseModel alloc] initWithDictionary:_introduceDataArr];

        switch (indexPath.row) {
            case infocentertourcourseRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",travelingCourseModel.infocentertourcourse]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(travelingCourseModel.infocentertourcourse == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case travelingCourseHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                
                if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(homepageAddress == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
            }
                break;
            case themeRow:
            {
                cell.titleText.text = @"코스 테마";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",travelingCourseModel.theme]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(travelingCourseModel.theme == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case scheduleRow:
            {
                cell.titleText.text = @"코스 일정";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",travelingCourseModel.schedule]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(travelingCourseModel.schedule == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case distanceRow:
            {
                cell.titleText.text = @"코스 총 거리";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",travelingCourseModel.distance]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(travelingCourseModel.distance == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case taketimeRow:
            {
                cell.titleText.text = @"코스 총 소요시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",travelingCourseModel.taketime]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(travelingCourseModel.taketime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            default:
                break;
        }
    }else if(contentTypeID == Leports){
        LeportsModel *leportsModel = [[LeportsModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case infocenterleportsRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.infocenterleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.infocenterleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case leportsHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                
                if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(homepageAddress == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
            }
                break;
            case openperiodRow:
            {
                cell.titleText.text = @"개장기간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.openperiod]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.openperiod == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case restdateleportsRow:
            {
                cell.titleText.text = @"쉬는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.restdateleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.restdateleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case accomcountleportsRow:
            {
                cell.titleText.text = @"수용인원";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.accomcountleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.accomcountleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case scaleleportsRow:
            {
                cell.titleText.text = @"규모";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.scaleleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.scaleleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case usefeeleportsRow:
            {
                cell.titleText.text = @"입장료";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.usefeeleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.usefeeleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case usetimeleportsRow:
            {
                cell.titleText.text = @"이용시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.usetimeleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.usetimeleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case reservationRow:
            {
                cell.titleText.text = @"예약안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.reservation]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.reservation == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case expagerangeleportsRow:
            {
                cell.titleText.text = @"체험 가능연령";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.expagerangeleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.expagerangeleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case parkingleportsRow:
            {
                cell.titleText.text = @"주차시설";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.parkingleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음" ];
                else if(leportsModel.parkingleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case parkingfeeleportsRow:
            {
                cell.titleText.text = @"주차 요금";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.parkingfeeleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.parkingfeeleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkbabycarriageleportsRow:
            {
                cell.titleText.text = @"유모차 대여 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.chkbabycarriageleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.chkbabycarriageleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkcreditcardleportsRow:
            {
                cell.titleText.text = @"신용카드 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.chkcreditcardleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.chkcreditcardleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkpetleportsRow:
            {
                cell.titleText.text = @"애완동물 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",leportsModel.chkpetleports]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(leportsModel.chkpetleports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            default:
                break;
        }
        
    }else if(contentTypeID == Accommodation){
        AccommodationModel *accommodationModel = [[AccommodationModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case infocenterlodgingRow:
            {
                cell.titleText.text = @"문의 및 안내";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.infocenterlodging]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.infocenterlodging == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case accommodationHomepageRow:
            {
                cell.titleText.text = @"홈페이지";

                if(accommodationModel.reservationurl != nil){
                    accommodationModel.reservationurl = [[[[[NSString stringWithFormat:@"%@",accommodationModel.reservationurl] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:accommodationModel.reservationurl];
                }
                else
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
            }
                break;
            case checkintimeRow:
            {
                cell.titleText.text = @"입실 시간";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.checkintime]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.checkintime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case checkouttimeRow:
            {
                cell.titleText.text = @"퇴실 시간";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.checkouttime]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.checkouttime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case scalelodgingRow:
            {
                cell.titleText.text = @"규모";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.scalelodging]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.scalelodging == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];

            }
                break;
            case roomcountRow:
            {
                cell.titleText.text = @"객실수";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.roomcount]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.roomcount == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];

            }
                break;
            case roomtypeRow:
            {
                cell.titleText.text = @"객실 유형";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.roomtype]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.roomtype == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case accomcountlodgingRow:
            {
                cell.titleText.text = @"수용인원";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.accomcountlodging]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.accomcountlodging == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];

            }
                break;
            case parkinglodgingRow:
            {
                cell.titleText.text = @"주차시설";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.parkinglodging]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.parkinglodging == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkcookingRow:
            {
                cell.titleText.text = @"객실내 취사 여부";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.chkcooking]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.chkcooking == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case pickupRow:
            {
                cell.titleText.text = @"픽업 서비스";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.pickup]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.pickup == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case foodplaceRow:
            {
                cell.titleText.text = @"식음료장";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.foodplace]];

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음" ];
                else if(accommodationModel.foodplace == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case barbecueRow:
            {
                cell.titleText.text = @"바비큐장";

                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.barbecue]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.barbecue == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case campfireRow:
            {
                cell.titleText.text = @"캠프파이어";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.campfire]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"불가";
                else
                    infoString = @"가능";

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.campfire == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case fitnessRow:
            {
                cell.titleText.text = @"휘트니스 센터 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.fitness]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.fitness == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case karaokeRow:
            {
                cell.titleText.text = @"노래방 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.karaoke]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";

                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.karaoke == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case publicpcRow:
            {
                cell.titleText.text = @"공용 PC실 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.publicpc]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.publicpc == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case saunaRow:
            {
                cell.titleText.text = @"사우나실 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.sauna]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.sauna == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case seminarRow:
            {
                cell.titleText.text = @"세미나실 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.seminar]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.seminar == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case beautyRow:
            {
                cell.titleText.text = @"뷰티시설 정보";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.beauty]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.beauty == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case sportsRow:
            {
                cell.titleText.text = @"스포츠 시설 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.sports]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.sports == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case subfacilityRow:
            {
                cell.titleText.text = @"부대시설(기타)";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",accommodationModel.subfacility]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(accommodationModel.subfacility == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            default:
                break;
        }
    }else if(contentTypeID == Shopping){
        ShoppingModel *shoppingModel = [[ShoppingModel alloc] initWithDictionary:_introduceDataArr];
        
        switch (indexPath.row) {
            case infocentershoppingRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.infocentershopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.infocentershopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case shoppingHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(homepageAddress == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
            }
                break;
            case culturecenterRow:
            {
                cell.titleText.text = @"문화센터 바로가기";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.culturecenter]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.culturecenter == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case opendateshoppingRow:
            {
                cell.titleText.text = @"개장일";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.opendateshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.opendateshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case fairdayRow:
            {
                cell.titleText.text = @"장서는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.fairday]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.fairday == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case opentimeRow:
            {
                cell.titleText.text = @"영업시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.opentime]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.opentime == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case restdateshoppingRow:
            {
                cell.titleText.text = @"쉬는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.restdateshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.restdateshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case saleitemRow:
            {
                cell.titleText.text = @"판매 품목";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.saleitem]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.saleitem == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case saleitemcostRow:
            {
                cell.titleText.text = @"판매 품목별 가격";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.saleitemcost]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.saleitemcost == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case scaleshoppingRow:
            {
                cell.titleText.text = @"규모";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.scaleshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.scaleshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case shopguideRow:
            {
                cell.titleText.text = @"매장 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.shopguide]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.shopguide == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case parkingshoppingRow:
            {
                cell.titleText.text = @"주차시설";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.parkingshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음" ];
                else if(shoppingModel.parkingshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case restroomRow:
            {
                cell.titleText.text = @"화장실";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.restroom]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.restroom == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkbabycarriageshoppingRow:
            {
                cell.titleText.text = @"유모차 대여 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.chkbabycarriageshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.chkbabycarriageshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkcreditcardshoppingRow:
            {
                cell.titleText.text = @"신용카드 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.chkcreditcardshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.chkcreditcardshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkpetshoppingRow:
            {
                cell.titleText.text = @"애완동물 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",shoppingModel.chkpetshopping]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(shoppingModel.chkpetshopping == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            default:
                break;
        }
        
    }else if(contentTypeID == Restaurant){
        RestaurantModel *restaurantModel = [[RestaurantModel alloc] initWithDictionary:_introduceDataArr];
        switch (indexPath.row) {
            case infocenterfoodRow:
            {
                cell.titleText.text = @"문의 및 안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.infocenterfood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.infocenterfood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case restaurantHomepageRow:
            {
                cell.titleText.text = @"홈페이지";
                
                NSString *homepageAddress = [[[[[NSString stringWithFormat:@"%@",[_parserDataArr valueForKey:@"homepage"]] componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"<"] firstObject];
                
                if([homepageAddress isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if(homepageAddress == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else if([homepageAddress rangeOfString:@"href"].location == NSNotFound)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"홈페이지 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:homepageAddress];
            }
                break;
            case opentimefoodRow:
            {
                cell.titleText.text = @"영업시간";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.opentimefood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.opentimefood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case opendatefoodRow:
            {
                cell.titleText.text = @"개업일";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.opendatefood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.opendatefood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case restdatefoodRow:
            {
                cell.titleText.text = @"쉬는날";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.restdatefood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.restdatefood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case firstmenuRow:
            {
                cell.titleText.text = @"대표 메뉴";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.firstmenu]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.firstmenu == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case treatmenuRow:
            {
                cell.titleText.text = @"취급 메뉴";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.treatmenu]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.treatmenu == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case discountinfofoodRow:
            {
                cell.titleText.text = @"할인 정보";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.discountinfofood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.discountinfofood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
                
            }
                break;
            case packingRow:
            {
                cell.titleText.text = @"포장 가능";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.packing]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.packing == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case scalefoodRow:
            {
                cell.titleText.text = @"규모";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.scalefood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.scalefood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case seatRow:
            {
                cell.titleText.text = @"좌석수";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.seat]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.seat == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case parkingfoodRow:
            {
                cell.titleText.text = @"주차시설";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.parkingfood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음" ];
                else if(restaurantModel.parkingfood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case reservationfoodRow:
            {
                cell.titleText.text = @"예약안내";
                
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.reservationfood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.reservationfood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case chkcreditcardfoodRow:
            {
                cell.titleText.text = @"신용카드 가능 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.chkcreditcardfood]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.chkcreditcardfood == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case kidsfacilityRow:
            {
                cell.titleText.text = @"어린이 놀이방 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.kidsfacility]];
                
                if([infoString isEqualToString:@"0"])
                    infoString = @"없음";
                else
                    infoString = @"있음";
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else if(restaurantModel.kidsfacility == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"정보 없음"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            case smokingRow:
            {
                cell.titleText.text = @"금연/흡연 여부";
                infoString = [self removeTextTag:[NSString stringWithFormat:@"%@",restaurantModel.smoking]];
                
                if([infoString isEqualToString:@""])
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"금연"];
                else if(restaurantModel.smoking == nil)
                    cell.contentText.text = [NSString stringWithFormat:@"%@",@"금연"];
                else
                    cell.contentText.attributedText = [self lineSpacingControlWithTypeCell:cell withString:infoString];
            }
                break;
            default:
                break;
        }
    }
}

@end
