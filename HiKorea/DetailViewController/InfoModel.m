//
//  InfoModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

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
    if([key isEqualToString:@"accomcount"])
        self.accomcount = key;
    else if([key isEqualToString:@"chkbabycarriage"])
        self.chkbabycarriage = key;
    else if([key isEqualToString:@"chkcreditcard"])
        self.chkcreditcard = key;
    else if([key isEqualToString:@"chkpet"])
        self.chkpet = key;
    else if([key isEqualToString:@"expagerange"])
        self.expagerange = key;
    else if([key isEqualToString:@"expguide"])
        self.expguide = key;
    else if([key isEqualToString:@"heritage1"])
        self.heritage1 = (NSInteger)key;
    else if([key isEqualToString:@"heritage2"])
        self.heritage2 = (NSInteger)key;
    else if([key isEqualToString:@"heritage3"])
        self.heritage3 = (NSInteger)key;
    else if([key isEqualToString:@"infocenter"])
        self.infocenter = key;
    else if([key isEqualToString:@"opendate"])
        self.opendate = key;
    else if([key isEqualToString:@"parking"])
        self.parking = key;
    else if([key isEqualToString:@"restdate"])
        self.restdate = key;
    else if([key isEqualToString:@"useseason"])
        self.useseason = key;
    else if([key isEqualToString:@"usetime"])
        self.usetime = key;
    
}

@end


