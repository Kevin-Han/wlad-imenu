//
//  NUSMapViewController.h
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
 
@interface NUSMapViewController : UIViewController
{
    IBOutlet MKMapView *mapView;
    IBOutlet UITextField *locationTitleField;
}
@end
