//
//  ParseHelper.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ValidatorHelper;

@protocol TranslatorHelperDelegate <NSObject>

@required

- (void)didSucceedParseCities:(NSArray *)cities
            withCallbackBlock:(CallbackBlock)callbackBlock;
- (void)didFailParseCitiesWithError:(NSError *)error
                   andCallbackBlock:(CallbackBlock)callbackBlock;

@end

@interface TranslatorHelper : NSObject

@property (nonatomic, weak) id delegate;

- (void)parseCitiesWithResponseObject:(id)responseObject
                     andCallbackBlock:(CallbackBlock)callbackBlock;

@end
