//
//  TravelingCourseModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "TravelingCourseModel.h"

@implementation TravelingCourseModel

-(id)initWithDictionary:(NSDictionary *)jsonDictionary
{
    self = [super init];
    if(self)
    {
        [self setValuesForKeysWithDictionary:jsonDictionary];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if([key isEqualToString:@"distance"])
        self.distance = key;
    else if([key isEqualToString:@"infocentertourcourse"])
        self.infocentertourcourse = key;
    else if([key isEqualToString:@"schedule"])
        self.schedule = key;
    else if([key isEqualToString:@"taketime"])
        self.taketime = key;
    else if([key isEqualToString:@"theme"])
        self.theme = key;
    
}

@end
