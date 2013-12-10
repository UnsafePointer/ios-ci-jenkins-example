//
//  ViewController.m
//  WeatherApp
//
//  Created by Renzo Crisóstomo on 10/23/13.
//  Copyright (c) 2013 Renzo Crisóstomo. All rights reserved.
//

#import "CitiesViewController.h"
#import "WeatherAPIManager.h"
#import "City.h"
#import "SearchViewController.h"
#import "CityViewController.h"

@interface CitiesViewController () <CLLocationManagerDelegate>
{
    NSMutableArray *_dataSource;
    CLLocationManager *_locationManager;
    __weak UIRefreshControl *_refreshControl;
}

- (void)setupAndStartLocationManager;
- (void)setupRefreshControl;
- (void)reloadDataSourceWithCities:(NSArray *)cities;
- (void)notifyError;
- (void)refreshLocation;
- (void)endRefreshTableView;

@end

@implementation CitiesViewController
{
}

#pragma mark - View Controller Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRefreshControl];
    [self setupAndStartLocationManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CitySegue"]) {
        CityViewController *viewController = (CityViewController *)[segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        City *city = [_dataSource objectAtIndex:selectedIndexPath.row];
        viewController.city = city;
    }
    else if ([[segue identifier] isEqualToString:@"SearchSegue"]) {
        SearchViewController *viewController = (SearchViewController *)[segue destinationViewController];
        [viewController setDataSource:_dataSource];
    }
}

#pragma mark - Private Methods

- (void)setupAndStartLocationManager
{
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self refreshLocation];
}

- (void)setupRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refreshLocation)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    _refreshControl = refreshControl;
}

- (void)reloadDataSourceWithCities:(NSArray *)cities
{
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:cities];
    [self.tableView reloadData];
}

- (void)notifyError
{
    UIAlertView *loadAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"There was an error with the request"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [loadAlert show];
}

- (void)notifyAuthorization
{
    UIAlertView *loadAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This application is not authorized for location "
                                                                 "services or location services are not enabled"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [loadAlert show];
}

- (void)refreshLocation
{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self endRefreshTableView];
            [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusRestricted:
            [self endRefreshTableView];
            [self notifyAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
            [self endRefreshTableView];
            [self notifyAuthorization];
            break;
        case kCLAuthorizationStatusAuthorized:
            [_locationManager startUpdatingLocation];
            break;
    }
}

- (void)endRefreshTableView
{
    if (_refreshControl.isRefreshing) {
        [_refreshControl endRefreshing];
    }
}

#pragma mark - CLLocationManager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    __weak typeof(self) blocksafeSelf = self;
    [[WeatherAPIManager sharedManager] citiesWithUserLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]
                                                userLongitude:[NSNumber numberWithDouble:location.coordinate.longitude]
                                             andCallbackBlock:^(NSArray *cities, NSError *error) {
                                                 [blocksafeSelf endRefreshTableView];
                                                 if (error) {
                                                     [blocksafeSelf notifyError];
                                                 }
                                                 else {
                                                     [blocksafeSelf reloadDataSourceWithCities:cities];
                                                 }
                                             }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CityCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                 forIndexPath:indexPath];
    City *city = nil;
    city = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lat: %.2f, Lon: %.2f",
                                 [city.latitude floatValue],[city.longitude floatValue]];
    return cell;
}

@end
