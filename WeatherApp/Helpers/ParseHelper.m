//
//  ParseHelper.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "ParseHelper.h"
#import "City.h"

@implementation ParseHelper

#pragma mark - Public Methods

- (void)parseCitiesWithResponseObject:(id)responseObject
                     andCallbackBlock:(CallbackBlock)callbackBlock
{
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                               options:0
                                                                 error:&error];
    if (error) {
        if ([_delegate respondsToSelector:@selector(didFailParseCitiesWithError:andCallbackBlock:)]) {
            [_delegate performSelector:@selector(didFailParseCitiesWithError:andCallbackBlock:)
                            withObject:error
                            withObject:callbackBlock];
        }
    }
    else {
        NSArray *jsonCities = [jsonObject objectForKey:@"list"];
        for (NSDictionary *jsonCity in jsonCities) {
            City *city = [[City alloc] init];
            city.name = [jsonCity objectForKey:@"name"];
            NSDictionary *jsonCoordinates = [jsonCity objectForKey:@"coord"];
            city.latitude = [jsonCoordinates objectForKey:@"lat"];
            city.longitude = [jsonCoordinates objectForKey:@"lon"];
            NSDictionary *jsonMain = [jsonCity objectForKey:@"main"];
            city.temperature = [jsonMain objectForKey:@"temp"];
            city.pressure = [jsonMain objectForKey:@"pressure"];
            city.humidity = [jsonMain objectForKey:@"humidity"];
            [cities addObject:city];
        }
        if ([_delegate respondsToSelector:@selector(didSucceedParseCities:withCallbackBlock:)]) {
            [_delegate performSelector:@selector(didSucceedParseCities:withCallbackBlock:)
                            withObject:cities
                            withObject:callbackBlock];
        }
    }
}

@end
