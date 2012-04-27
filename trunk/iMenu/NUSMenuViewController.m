//
//  NUSMenuViewController.m
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMenuViewController.h"

@interface NUSMenuViewController ()
- (void)showLoginView;
@end

@implementation NUSMenuViewController

@synthesize flagCancelLogin=_flagCancelLogin, loginHUD=_loginHUD, username=_username, password=_password, loginBarButtonItem = _loginBarButtonItem;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [self setLoginHUD:nil];
    [self setLoginBarButtonItem:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - Action Methods

- (IBAction)loginBarButtonAction:(id)sender
{
    if([[_loginBarButtonItem title] isEqualToString:@"Login"])
    {
        UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        
        [loginAlert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        [loginAlert show];
    }
    else if([[_loginBarButtonItem title] isEqualToString:@"Logout"])
    {
        UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"Logout" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
        
        [logoutAlert show];
    }
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Login"])
    {
        _username = [[alertView textFieldAtIndex:0] text];
        _password = [[alertView textFieldAtIndex:1] text];
        

        NSLog(@"%s Login Username=%@ Password=%@", __FUNCTION__, _username, _password);
        
        [self showLoginView];
    }
    else if ([title isEqualToString:@"Logout"]) 
    {
        NSLog(@"%s Logout Username=%@ Password=%@", __FUNCTION__, _username, _password);

        [_loginBarButtonItem setTitle:@"Login"];
    }
}


#pragma mark - Show login view
- (void)showLoginView
{
    NSLog(@"%s", __FUNCTION__);
    
    _loginHUD = [[MBProgressHUD alloc] initWithView:self.view];

    _loginHUD.labelText = @"Loging...";
	_loginHUD.dimBackground = YES;
	_loginHUD.square = YES;
    _loginHUD.margin = 60.0;
    _loginHUD.delegate = self;
    _loginHUD.cancelButtonText = @"Cancel";
    
    _flagCancelLogin = 0;
    
    [self.view addSubview:_loginHUD];
    
    [_loginHUD showWhileExecuting:@selector(doLogin) onTarget:self withObject:nil animated:YES];
}

- (void)doLogin
{
    
    // Do the login here currently use sleep method instead login
    sleep(5);
    
    if([_username isEqualToString:_password])
    {
        [_loginHUD stopIndicators];
        _loginHUD.labelText =  @"Succeed";
        _flagCancelLogin=1;
        [_loginBarButtonItem setTitle:@"Logout"];
    }
    else
    {
        [_loginHUD stopIndicators];
        _loginHUD.labelText =  @"Failed";
    }
    
    while(!_flagCancelLogin)
    { 
        sleep(1);
    }
}


#pragma mark - MBProgressHUD delegate

- (void)hudWasHidden 
{  
    if(_loginHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_loginHUD removeFromSuperview];  
    }
}  

- (void)clearHud
{
    if(_loginHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_loginHUD removeFromSuperview];  
        
        _flagCancelLogin = 1;
    }
}

@end
