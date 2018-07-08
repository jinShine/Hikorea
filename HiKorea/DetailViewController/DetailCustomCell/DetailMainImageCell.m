//
//  DetailMainImageCell.m
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 28..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "DetailMainImageCell.h"

@implementation DetailMainImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pageScrollView.delegate = self;
    
    self.pageControl.layer.cornerRadius = self.pageControl.frame.size.width / 6;
    self.pageControl.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)dismiss:(id)sender
{
    [self.detailVC.navigationController popToRootViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor(((scrollView.contentOffset.x / pageWidth)) + 1);
    
    [self.pageControl setText:[NSString stringWithFormat:@"%ld/%ld", (long)page,(long)_imageTotalCount]];
}

@end
