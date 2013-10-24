//
//  ParseHelper.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseHelperDelegate <NSObject>

@required

- (void)didSucceedParseCities:(NSArray *)cities
            withCallbackBlock:(CallbackBlock)callbackBlock;
- (void)didFailParseCitiesWithError:(NSError *)error
                   andCallbackBlock:(CallbackBlock)callbackBlock;

@end

@interface ParseHelper : NSObject

@property (nonatomic, weak) id delegate;

- (void)parseCitiesWithResponseObject:(id)responseObject
                     andCallbackBlock:(CallbackBlock)callbackBlock;

@end
