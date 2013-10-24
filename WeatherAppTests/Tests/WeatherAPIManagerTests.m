//
//  WeatherAppTests.m
//  WeatherAppTests
//
//  Created by Renzo Crisóstomo on 10/23/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <XCTest/XCTest.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#import "WeatherAPIManager.h"
#import "TranslatorHelper.h"
#import "ErrorNotificationHelper.h"

@interface AFHTTPRequestOperationManagerSuccess : AFHTTPRequestOperationManager

@property (nonatomic,strong) NSData *responseData;

@end


@implementation AFHTTPRequestOperationManagerSuccess

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    success(nil, _responseData);
    return nil;
}

@end

@interface AFHTTPRequestOperationManagerFailure : AFHTTPRequestOperationManager

@property (nonatomic,strong) NSError *error;

@end

@implementation AFHTTPRequestOperationManagerFailure

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    failure(nil, _error);
    return nil;
}

@end

@interface WeatherAPIManagerTests : XCTestCase

@end

@implementation WeatherAPIManagerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    weatherAPIManager.errorNotificationHelper = nil;
    weatherAPIManager.translatorHelper = nil;
    [super tearDown];
}

#pragma mark - Property Tests

- (void)testSharedManager
{
    assertThat([WeatherAPIManager sharedManager], notNilValue());
    assertThat([WeatherAPIManager sharedManager], instanceOf([WeatherAPIManager class]));
}

- (void)testParserHelper
{
    assertThat([[WeatherAPIManager sharedManager] translatorHelper], notNilValue());
    assertThat([[WeatherAPIManager sharedManager] translatorHelper], instanceOf([TranslatorHelper class]));
}

- (void)testErrorNotificationHelper
{
    assertThat([[WeatherAPIManager sharedManager] errorNotificationHelper], notNilValue());
    assertThat([[WeatherAPIManager sharedManager] errorNotificationHelper], instanceOf([ErrorNotificationHelper class]));
}

#pragma mark - CitiesWithUserLatitudeUserLongitudeAndCallbackBlock Tests

- (void)testCitiesWithUserLatitudeUserLongitudeAndCallbackBlockWithSuccessResponseAndValidResponseData
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    AFHTTPRequestOperationManagerSuccess *requestOperationManagerSuccess = [[AFHTTPRequestOperationManagerSuccess alloc] init];
    NSData *responseData = [JSON_VALID_STRING dataUsingEncoding:NSUTF8StringEncoding];
    requestOperationManagerSuccess.responseData = responseData;
    weatherAPIManager.requestOperationManager = requestOperationManagerSuccess;
    TranslatorHelper *translatorHelper = mock([TranslatorHelper class]);
    weatherAPIManager.translatorHelper = translatorHelper;
    CallbackBlock callbackBlock = ^(NSArray *cities, NSError *error) {};
    [weatherAPIManager citiesWithUserLatitude:@0.0f
                                userLongitude:@0.0f
                             andCallbackBlock:callbackBlock];
    [verify(translatorHelper) parseCitiesWithResponseObject:responseData
                                           andCallbackBlock:callbackBlock];
}

- (void)testCitiesWithUserLatitudeUserLongitudeAndCallbackBlockWithSuccessResponseAndInvalidResponseData
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    AFHTTPRequestOperationManagerSuccess *requestOperationManagerSuccess = [[AFHTTPRequestOperationManagerSuccess alloc] init];
    NSData *responseData = [JSON_INVALID_STRING dataUsingEncoding:NSUTF8StringEncoding];
    requestOperationManagerSuccess.responseData = responseData;
    weatherAPIManager.requestOperationManager = requestOperationManagerSuccess;
    TranslatorHelper *translatorHelper = mock([TranslatorHelper class]);
    weatherAPIManager.translatorHelper = translatorHelper;
    CallbackBlock callbackBlock = ^(NSArray *cities, NSError *error) {};
    [weatherAPIManager citiesWithUserLatitude:@0.0f
                                userLongitude:@0.0f
                             andCallbackBlock:callbackBlock];
    [verify(translatorHelper) parseCitiesWithResponseObject:responseData
                                           andCallbackBlock:callbackBlock];
}

- (void)testCitiesWithUserLatitudeUserLongitudeAndCallbackBlockWithFailureResponse
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    AFHTTPRequestOperationManagerFailure *requestOperationManagerFailure = [[AFHTTPRequestOperationManagerFailure alloc] init];
    weatherAPIManager.requestOperationManager = requestOperationManagerFailure;
    ErrorNotificationHelper *errorNotificationHelper = mock([ErrorNotificationHelper class]);
    weatherAPIManager.errorNotificationHelper = errorNotificationHelper;
    CallbackBlock callbackBlock = ^(NSArray *cities, NSError *error) {};
    [weatherAPIManager citiesWithUserLatitude:@0.0f
                                userLongitude:@0.0f
                             andCallbackBlock:callbackBlock];
    [verify(errorNotificationHelper) notifyError:(NSError *)anything()
                               withCallbackBlock:callbackBlock];
}

#pragma mark - ParseCitiesWithResponseObjectAndCallbackBlock Tests

- (void)testParseCitiesWithResponseObjectAndCallbackBlockWithValidResponseObject
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    AFHTTPRequestOperationManagerSuccess *requestOperationManagerSuccess = [[AFHTTPRequestOperationManagerSuccess alloc] init];
    requestOperationManagerSuccess.responseData = [JSON_VALID_STRING dataUsingEncoding:NSUTF8StringEncoding];
    weatherAPIManager.requestOperationManager = requestOperationManagerSuccess;
    id <TranslatorHelperDelegate> delegate = mockProtocol(@protocol(TranslatorHelperDelegate));
    weatherAPIManager.translatorHelper.delegate = delegate;
    CallbackBlock callbackBlock = ^(NSArray *cities, NSError *error) {};
    [weatherAPIManager citiesWithUserLatitude:@0.0f
                                userLongitude:@0.0f
                             andCallbackBlock:callbackBlock];
    [verify(delegate) didSucceedParseCities:(NSArray *)anything()
                          withCallbackBlock:callbackBlock];
}

- (void)testParseCitiesWithResponseObjectAndCallbackBlockWithInvalidResponseObject
{
    WeatherAPIManager *weatherAPIManager = [WeatherAPIManager sharedManager];
    AFHTTPRequestOperationManagerSuccess *requestOperationManagerSuccess = [[AFHTTPRequestOperationManagerSuccess alloc] init];
    requestOperationManagerSuccess.responseData = [JSON_INVALID_STRING dataUsingEncoding:NSUTF8StringEncoding];
    weatherAPIManager.requestOperationManager = requestOperationManagerSuccess;
    id <TranslatorHelperDelegate> delegate = mockProtocol(@protocol(TranslatorHelperDelegate));
    weatherAPIManager.translatorHelper.delegate = delegate;
    CallbackBlock callbackBlock = ^(NSArray *cities, NSError *error) {};
    [weatherAPIManager citiesWithUserLatitude:@0.0f
                                userLongitude:@0.0f
                             andCallbackBlock:callbackBlock];
    [verify(delegate) didFailParseCitiesWithError:(NSError *)anything()
                                 andCallbackBlock:callbackBlock];
}

@end
