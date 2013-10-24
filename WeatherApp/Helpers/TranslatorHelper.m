//
//  ParseHelper.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "TranslatorHelper.h"
#import "City.h"
#import "ValidatorHelper.h"

@interface TranslatorHelper ()

- (void)notifyErrorWithCallbackBlock:(CallbackBlock)callbackBlock;

@end

@implementation TranslatorHelper
{
}

#pragma mark - Private Methods

- (void)notifyErrorWithCallbackBlock:(CallbackBlock)callbackBlock
{
    NSError *error = [NSError errorWithDomain:@"com.tallertechnologies.WeatherApp"
                                         code:20091990
                                     userInfo:@{@"Description": @"Wrong response object structure"}];
    if ([_delegate respondsToSelector:@selector(didFailParseCitiesWithError:andCallbackBlock:)]) {
        [_delegate performSelector:@selector(didFailParseCitiesWithError:andCallbackBlock:)
                        withObject:error
                        withObject:callbackBlock];
    }
}

#pragma mark - Public Methods

- (void)parseCitiesWithResponseObject:(id)responseObject
                     andCallbackBlock:(CallbackBlock)callbackBlock
{
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    if ([ValidatorHelper isResponseObjectValid:responseObject]) {
        NSArray *jsonCities = [responseObject objectForKey:@"list"];
        for (id cityObject in jsonCities) {
            if ([ValidatorHelper isCityObjectValid:cityObject]) {
                City *city = [[City alloc] init];
                city.name = [cityObject objectForKey:@"name"];
                id coordinatesObject = [cityObject objectForKey:@"coord"];
                if ([ValidatorHelper isCoordinatesObjectValid:coordinatesObject]) {
                    city.latitude = [coordinatesObject objectForKey:@"lat"];
                    city.longitude = [coordinatesObject objectForKey:@"lon"];
                }
                else {
                    [self notifyErrorWithCallbackBlock:callbackBlock];
                }
                id mainObject = [cityObject objectForKey:@"main"];
                if ([ValidatorHelper isMainObjectValid:mainObject]) {
                    city.temperature = [mainObject objectForKey:@"temp"];
                    city.pressure = [mainObject objectForKey:@"pressure"];
                    city.humidity = [mainObject objectForKey:@"humidity"];
                }
                else {
                    [self notifyErrorWithCallbackBlock:callbackBlock];
                }
                [cities addObject:city];
            }
            else {
                [self notifyErrorWithCallbackBlock:callbackBlock];
            }
        }
    }
    else {
        [self notifyErrorWithCallbackBlock:callbackBlock];
    }
    if ([_delegate respondsToSelector:@selector(didSucceedParseCities:withCallbackBlock:)]) {
        [_delegate performSelector:@selector(didSucceedParseCities:withCallbackBlock:)
                        withObject:cities
                        withObject:callbackBlock];
    }
}

@end
