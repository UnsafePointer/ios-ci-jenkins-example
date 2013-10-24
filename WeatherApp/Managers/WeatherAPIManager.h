//
//  WeatherAPIManager.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "TranslatorHelper.h"
#import "ErrorNotificationHelper.h"

@interface WeatherAPIManager : NSObject <TranslatorHelperDelegate, ErrorNotificationHelperDelegate>

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestOperationManager;
@property (nonatomic, strong) TranslatorHelper *translatorHelper;
@property (nonatomic, strong) ErrorNotificationHelper *errorNotificationHelper;

+ (WeatherAPIManager *)sharedManager;

- (void)citiesWithUserLatitude:(NSNumber *)userLatitude
                 userLongitude:(NSNumber *)userLongitude
              andCallbackBlock:(CallbackBlock)callbackBlock;

@end
