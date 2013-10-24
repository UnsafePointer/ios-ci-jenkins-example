//
//  WeatherAPIManager.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "WeatherAPIManager.h"
#import <AFNetworking/AFNetworking.h>

static dispatch_once_t oncePredicate;

@implementation WeatherAPIManager
{
}

#pragma mark - Lazy Loading Pattern

- (TranslatorHelper *)parseHelper
{
    if (_parseHelper == nil) {
        _parseHelper = [[TranslatorHelper alloc] init];
        _parseHelper.delegate = self;
    }
    return _parseHelper;
}

- (ErrorNotificationHelper *)errorNotificationHelper
{
    if (_errorNotificationHelper == nil) {
        _errorNotificationHelper = [[ErrorNotificationHelper alloc] init];
        _errorNotificationHelper.delegate = self;
    }
    return _errorNotificationHelper;
}

#pragma mark - Public Methods

+ (WeatherAPIManager *)sharedManager
{
    static WeatherAPIManager *_sharedManager;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (void)citiesWithUserLatitude:(NSNumber *)userLatitude
                 userLongitude:(NSNumber *)userLongitude
              andCallbackBlock:(CallbackBlock)callbackBlock
{
    __weak WeatherAPIManager *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:@"http://api.openweathermap.org/data/2.5/find"
      parameters:@{@"lat": userLatitude,
                   @"lon": userLongitude,
                   @"cnt": @100,
                   @"type": @"json"}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [[weakSelf parseHelper] parseCitiesWithResponseObject:responseObject
                                                  andCallbackBlock:callbackBlock];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[weakSelf errorNotificationHelper] notifyError:error
                                      withCallbackBlock:callbackBlock];
    }];
}

#pragma mark - ParseHelperDelegate

- (void)didSucceedParseCities:(NSArray *)cities
            withCallbackBlock:(CallbackBlock)callbackBlock
{
    callbackBlock(cities, nil);
}

- (void)didFailParseCitiesWithError:(NSError *)error
                   andCallbackBlock:(CallbackBlock)callbackBlock
{
    [[self errorNotificationHelper] notifyError:error
                              withCallbackBlock:callbackBlock];
}

#pragma mark - ErrorNotificationHelperDelegate

- (void)didNotifyError:(NSError *)error
     withCallbackBlock:(CallbackBlock)callbackBlock
{
    callbackBlock(nil, error);
}

@end
