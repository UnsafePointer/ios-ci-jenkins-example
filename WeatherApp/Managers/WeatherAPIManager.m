//
//  WeatherAPIManager.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "WeatherAPIManager.h"

static dispatch_once_t oncePredicate;

@implementation WeatherAPIManager
{
}

#pragma mark - Lazy Loading Pattern

- (AFHTTPRequestOperationManager *)requestOperationManager
{
    if (_requestOperationManager == nil) {
        _requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:
                                    [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/"]];
        _requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return _requestOperationManager;
}

- (TranslatorHelper *)translatorHelper
{
    if (_translatorHelper == nil) {
        _translatorHelper = [[TranslatorHelper alloc] init];
        _translatorHelper.delegate = self;
    }
    return _translatorHelper;
}

- (ErrorNotificationHelper *)errorNotificationHelper
{
    if (_errorNotificationHelper == nil) {
        _errorNotificationHelper = [[ErrorNotificationHelper alloc] init];
        _errorNotificationHelper.delegate = self;
    }
    return _errorNotificationHelper;
}

#pragma mark - Class Methods

+ (WeatherAPIManager *)sharedManager
{
    static WeatherAPIManager *_sharedManager;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

#pragma mark - Public Methods

- (void)citiesWithUserLatitude:(NSNumber *)userLatitude
                 userLongitude:(NSNumber *)userLongitude
              andCallbackBlock:(CallbackBlock)callbackBlock
{    
    __weak typeof(self) blocksafeSelf = self;
    [[self requestOperationManager] GET:@"find"
                             parameters:[NSDictionary dictionaryWithObjectsAndKeys:userLatitude,
                                         @"lat", userLongitude, @"lon", [NSNumber numberWithInt:100], @"cnt", @"json", @"mode", nil]
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    [[blocksafeSelf translatorHelper] parseCitiesWithResponseObject:responseObject
                                                                                   andCallbackBlock:callbackBlock];
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    [[blocksafeSelf errorNotificationHelper] notifyError:error
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
