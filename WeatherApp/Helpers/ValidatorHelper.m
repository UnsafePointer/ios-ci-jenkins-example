//
//  ValidatorHelper.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "ValidatorHelper.h"

@implementation ValidatorHelper
{
}

#pragma mark - Class Methods

+ (BOOL)isResponseObjectValid:(id)responseObject
{
    return (responseObject != nil &&
            [responseObject isKindOfClass:[NSDictionary class]] &&
            [responseObject objectForKey:@"list"] != nil);
}

+ (BOOL)isCityObjectValid:(id)cityObject
{
    return (cityObject != nil &&
            [cityObject isKindOfClass:[NSDictionary class]] &&
            [cityObject objectForKey:@"name"] != nil &&
            [cityObject objectForKey:@"coord"] != nil &&
            [cityObject objectForKey:@"lat"] != nil &&
            [cityObject objectForKey:@"lon"] != nil &&
            [cityObject objectForKey:@"main"] != nil &&
            [cityObject objectForKey:@"temp"] != nil &&
            [cityObject objectForKey:@"temp"] != nil &&
            [cityObject objectForKey:@"humidity"] != nil);
}

+ (BOOL)isCoordinatesObjectValid:(id)coordinateObject
{
    return (coordinateObject != nil &&
            [coordinateObject isKindOfClass:[NSDictionary class]] &&
            [coordinateObject objectForKey:@"lat"] != nil &&
            [coordinateObject objectForKey:@"lon"] != nil);
}

+ (BOOL)isMainObjectValid:(id)mainObject
{
    return (mainObject != nil &&
            [mainObject isKindOfClass:[NSDictionary class]] &&
            [mainObject objectForKey:@"temp"] != nil &&
            [mainObject objectForKey:@"lat"] != nil &&
            [mainObject objectForKey:@"humidity"] != nil);
}

@end
