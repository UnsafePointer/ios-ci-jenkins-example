//
//  CityTests.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/24/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>
#import "City.h"

@interface CityTests : XCTestCase
{
    City *_city;
}

@end

extern void __gcov_flush();

@implementation CityTests

- (void)setUp
{
    [super setUp];
    _city = [[City alloc] init];
}

- (void)tearDown
{
    __gcov_flush();
    [super tearDown];
}

#pragma mark - Property Tests

- (void)testNameProperty
{
    NSMutableString *cityName = [NSMutableString stringWithString:@"Lima"];
    [_city setName:cityName];
    [cityName setString:@"Chiclayo"];
    assertThat(_city.name, instanceOf([NSString class]));
    assertThat(_city.name, isNot(sameInstance(cityName)));
    assertThat(_city.name, is(@"Lima"));
}

- (void)testLatitudeProperty
{
    NSNumber *cityLatitude = [NSNumber numberWithInt:100];
    [_city setLatitude:cityLatitude];
    assertThat(_city.latitude, instanceOf([NSNumber class]));
}

- (void)testLongitudeProperty
{
    NSNumber *cityLongitude = [NSNumber numberWithInt:100];
    [_city setLongitude:cityLongitude];
    assertThat(_city.longitude, instanceOf([NSNumber class]));
}

- (void)testTemperatureProperty
{
    NSNumber *cityTemperature = [NSNumber numberWithInt:100];
    [_city setTemperature:cityTemperature];
    assertThat(_city.temperature, instanceOf([NSNumber class]));
}

- (void)testPressureProperty
{
    NSNumber *cityPressure = [NSNumber numberWithInt:100];
    [_city setPressure:cityPressure];
    assertThat(_city.pressure, instanceOf([NSNumber class]));
}

- (void)testHumidityProperty
{
    NSNumber *cityHumidity = [NSNumber numberWithInt:100];
    [_city setHumidity:cityHumidity];
    assertThat(_city.humidity, instanceOf([NSNumber class]));
}

@end
