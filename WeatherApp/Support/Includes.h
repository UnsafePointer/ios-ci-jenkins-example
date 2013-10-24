//
//  Includes.h
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#ifndef WeatherApp_Includes_h
#define WeatherApp_Includes_h

typedef void (^CallbackBlock) (NSArray *cities, NSError *error);

#define JSON_VALID_STRING @"{\"message\":0.0097,\"cod\":\"200\",\"calctime\":\"\",\"cnt\":1,\"list\":[{\"id\":5391959,\"name\":\"San Francisco\",\"coord\":{\"lon\":-122.419418,\"lat\":37.774929},\"distance\":1.869,\"main\":{\"temp\":291.11,\"pressure\":1019,\"humidity\":51,\"temp_min\":286.48,\"temp_max\":295.37},\"dt\":1363564220,\"wind\":{\"speed\":8.2,\"deg\":280},\"clouds\":{\"all\":75},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}]}]}"
#define JSON_INVALID_STRING @"{ergnlsgzkuyghlzfnz§fgibuzf}"

#endif
