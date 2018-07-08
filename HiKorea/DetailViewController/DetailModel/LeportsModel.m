//
//  LeportsModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "LeportsModel.h"

@implementation LeportsModel

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
    
    if([key isEqualToString:@"accomcountleports"])
        self.accomcountleports = key;
    else if([key isEqualToString:@"chkbabycarriageleports"])
        self.chkbabycarriageleports = key;
    else if([key isEqualToString:@"chkcreditcardleports"])
        self.chkcreditcardleports = key;
    else if([key isEqualToString:@"chkpetleports"])
        self.chkpetleports = key;
    else if([key isEqualToString:@"expagerangeleports"])
        self.expagerangeleports = key;
    else if([key isEqualToString:@"infocenterleports"])
        self.infocenterleports = key;
    else if([key isEqualToString:@"openperiod"])
        self.openperiod = key;
    else if([key isEqualToString:@"parkingfeeleports"])
        self.parkingfeeleports = key;
    else if([key isEqualToString:@"parkingleports"])
        self.parkingleports = key;
    else if([key isEqualToString:@"reservation"])
        self.reservation = key;
    else if([key isEqualToString:@"restdateleports"])
        self.restdateleports = key;
    else if([key isEqualToString:@"scaleleports"])
        self.scaleleports = key;
    else if([key isEqualToString:@"usefeeleports"])
        self.usefeeleports = key;
    else if([key isEqualToString:@"usetimeleports"])
        self.usetimeleports = key;
    
}

@end
