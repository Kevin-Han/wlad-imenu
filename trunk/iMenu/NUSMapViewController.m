//
//  NUSMapViewController.m
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMapViewController.h"

@interface NUSMapViewController ()

@end

@implementation NUSMapViewController


- (void)foundLocation
{
	[locationManager stopUpdatingLocation];
	[activityIndicator stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation: (CLLocation *)newLocation
		  fromLocation:(CLLocation *)oldLocation
{	
	MapAnnotation *ma = [[MapAnnotation alloc] initWithCoordinate:[newLocation coordinate]  title:@"I am here"];
	[mapView addAnnotation:ma];
	[mapView selectAnnotation:ma animated:YES];
	[mapView setCenterCoordinate:[newLocation coordinate]  animated:YES];
	
	// structure to define areas spanned by a map region
	MKCoordinateRegion region; 
	
    region.center = [newLocation coordinate];
 	// define the distance (in degrees) to be display
	region.span.latitudeDelta = .005;
	region.span.longitudeDelta = .005;
	
    [mapView setRegion:region animated:TRUE];
    
	[ma release];	
	
	[self foundLocation];
} 

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *) error
{
	NSLog(@"Could not locate location: %@", error);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		locationManager = [[CLLocationManager alloc] init];
		[locationManager setDelegate:self];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];
		[mapView setShowsUserLocation:YES];
		[activityIndicator startAnimating];
	}
    return self;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [mapView release];
	[activityIndicator release];
}

-(void) annotateMap:(CLLocationCoordinate2D) newCoordinate
{
    MapAnnotation *ma= [[MapAnnotation alloc]initWithCoordinate:newCoordinate title:[locationTitleField text]];
    MKCoordinateRegion region;
    
    region.center=newCoordinate;
    region.span.latitudeDelta=0.005;
    region.span.longitudeDelta=0.005;

    [mapView setRegion:region animated:TRUE];
    [mapView addAnnotation:ma];
    [mapView setCenterCoordinate:newCoordinate animated:YES];
    
    //[ma release];
    return;
                        
}

-(BOOL) textFieldShouldReturn:(UITextField *)tf
{
    CLGeocoder *geoCoder=[[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:locationTitleField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *firstPlacemark=[placemarks objectAtIndex:0];
        [self annotateMap:firstPlacemark.location.coordinate];
        if(error)
        {
            NSLog(@"Error: %@", [error description]);
        }
    }];
    [tf resignFirstResponder];
    return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
	[mapView release];
	[activityIndicator release];
    [super dealloc];
}

@end
