//
//  MapAnnotation.m
//  iMenu
//
//  Created by Kai HAN on 27/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate,title;
-(id) initWithCoordinate:(CLLocationCoordinate2D)c 
                   title:(NSString *)t
{
    self=[super init];
    coordinate=c;
    [self setTitle:t];
    return self;
}

-(void) dealloc
{
	[title release];
	[super dealloc];
}
@end
