//
//  SearchViewController.h
//  HiKorea
//
//  Created by 김승진 on 2018. 4. 19..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "DetailViewController.h"
#import "MainViewController.h"
#import "SearchDataCell.h"
#import "RecommandCell.h"
#import "SupportingFile.h"


@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviHeader_iPhoneX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop_iPhoneX;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


//ParsingDatas
@property (strong, nonatomic) NSMutableArray *parserDataSaved;
@property (strong, nonatomic) NSMutableArray *latestSearchData;

@property (weak, nonatomic) IBOutlet UIImageView *noSearchInfoView;
@property (nonatomic) BOOL isNoSearch;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *backgroundTap;



- (IBAction)closeBtnAction:(id)sender;


@end
