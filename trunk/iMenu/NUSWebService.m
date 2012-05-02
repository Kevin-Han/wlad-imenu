//
//  NUSWebService.m
//  User
//
//  Created by Yuan Xiao dan on 1/5/12.
//  Copyright (c) 2012 patty.1984@hotmail.com. All rights reserved.
//

#import "NUSWebService.h"

@implementation NUSWebService



-(NSString *)getRespone:(NSString *) webServiceRequest{

    // for testing 
    //webServiceRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login?email=zawmyotun82@googlemail.com&password=123456";
    webServiceRequest = [webServiceRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *RequestURL=[NSURL URLWithString:[NSString 
                                            stringWithFormat:@"%@",webServiceRequest]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:RequestURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response ;
    NSError *error;
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:request 
                                 returningResponse:&response error:&error];
    
    if(error!=NULL){
        return NULL;
    }
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    
    NSLog(@" getRespone method result:%@",result );
    /*
    if ([result rangeOfString:@"UserID"].location == NSNotFound) {
        NSLog(@"!!!string does not contain UserID");
        
    } else {
        NSLog(@"!!!string contains UserID!");
        /* NSRange start = [result rangeOfString:@"UserID"];
         NSRange end = [result rangeOfString:@","];
         
         NSString *tempKeyValue = [result substringWithRange:NSMakeRange(start.location, end.location)];
         NSLog(@"keyValue%@", tempKeyValue);
        
        
        //NSDictionary *dictionary = [result JSONValue];
        // NSLog(@"Dictionary value for \"UserID\" is \"%@\"", [dictionary objectForKey:@"UserID"]);
    }*/
    
    return result;
    


}

@end
