//
//  ErrorNotificationHelper.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ErrorNotificationHelperDelegate <NSObject>

@required

- (void)didNotifyError:(NSError *)error
     withCallbackBlock:(CallbackBlock)callbackBlock;

@end

@interface ErrorNotificationHelper : NSObject

@property (nonatomic, weak) id delegate;

- (void)notifyError:(NSError *)error
  withCallbackBlock:(CallbackBlock)callbackBlock;

@end
