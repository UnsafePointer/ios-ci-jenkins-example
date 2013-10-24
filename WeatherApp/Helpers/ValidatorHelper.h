//
//  ValidatorHelper.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidatorHelper : NSObject

+ (BOOL)isResponseObjectValid:(id)responseObject;
+ (BOOL)isCityObjectValid:(id)cityObject;
+ (BOOL)isCoordinatesObjectValid:(id)coordinateObject;
+ (BOOL)isMainObjectValid:(id)mainObject;

@end
