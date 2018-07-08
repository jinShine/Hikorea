//
//  ShoppingModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel

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
    
    if([key isEqualToString:@"chkbabycarriageshopping"])
        self.chkbabycarriageshopping = key;
    else if([key isEqualToString:@"chkcreditcardshopping"])
        self.chkcreditcardshopping = key;
    else if([key isEqualToString:@"chkpetshopping"])
        self.chkpetshopping = key;
    else if([key isEqualToString:@"culturecenter"])
        self.culturecenter = key;
    else if([key isEqualToString:@"fairday"])
        self.fairday = key;
    else if([key isEqualToString:@"infocentershopping"])
        self.infocentershopping = key;
    else if([key isEqualToString:@"opendateshopping"])
        self.opendateshopping = key;
    else if([key isEqualToString:@"opentime"])
        self.opentime = key;
    else if([key isEqualToString:@"parkingshopping"])
        self.parkingshopping = key;
    else if([key isEqualToString:@"restdateshopping"])
        self.restdateshopping = key;
    else if([key isEqualToString:@"restroom"])
        self.restroom = key;
    else if([key isEqualToString:@"saleitem"])
        self.saleitem = key;
    else if([key isEqualToString:@"saleitemcost"])
        self.saleitemcost = key;
    else if([key isEqualToString:@"scaleshopping"])
        self.scaleshopping = key;
    else if([key isEqualToString:@"shopguide"])
        self.shopguide = key;
    
}

@end
