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

@end
