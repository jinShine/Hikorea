//
//  MapInfoViewCell.m
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "MapInfoViewCell.h"

@implementation MapInfoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)pushMapVC:(id)sender {

    MapViewController *mapVC = [[MapViewController alloc] init];
    [mapVC setDetailVC:_detailVC];
    [mapVC setSelectedArrData:_selectedArrData];
    [_detailVC.navigationController pushViewController:mapVC animated:YES];
    
}
@end
