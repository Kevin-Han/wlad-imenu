//
//  MapAnnotation.h
//  iMenu
//
//  Created by Kai HAN on 27/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation: NSObject<MKAnnotation>
{
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic,readwrite)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id) initWithCoordinate: (CLLocationCoordinate2D)c
                   title:(NSString *)t;


@end
