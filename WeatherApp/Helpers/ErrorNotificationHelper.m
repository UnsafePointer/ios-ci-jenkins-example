//
//  ErrorNotificationHelper.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "ErrorNotificationHelper.h"

@implementation ErrorNotificationHelper

#pragma mark - Public Methods

- (void)notifyError:(NSError *)error
  withCallbackBlock:(CallbackBlock)callbackBlock;
{
    NSLog(@"Error getting cities: %@", [error localizedDescription]);
    if ([_delegate respondsToSelector:@selector(didNotifyErrorWithCallbackBlock:)]) {
        [_delegate performSelector:@selector(didNotifyErrorWithCallbackBlock:)
                        withObject:callbackBlock];
    }
}

@end
