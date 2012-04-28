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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) annotateMap:(CLLocationCoordinate2D) newCoordinate
{
    MapAnnotation *ma= [[MapAnnotation alloc]initWithCoordinate:newCoordinate title:[locationTitleField text]];

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
@end
