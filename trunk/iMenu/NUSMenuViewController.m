//
//  NUSMenuViewController.m
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMenuViewController.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@interface NUSMenuViewController ()
- (void)showLoginView;
@end

@implementation NUSMenuViewController

@synthesize flagCancelLogin=_flagCancelLogin, loginHUD=_loginHUD, username=_username, password=_password, loginBarButtonItem = _loginBarButtonItem, data=_data, menuTableView = _menuTableView;;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _menuTableView.rowHeight = 100.0;
    _menuTableView.backgroundColor = DARK_BACKGROUND;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
	// Load the data.
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    
    _data = [NSArray arrayWithContentsOfFile:dataPath];
     
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [self setLoginHUD:nil];
    [self setLoginBarButtonItem:nil];
    [self setData:nil];
    
    [self setMenuTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - Action Methods

- (IBAction)orderBarButtonAction:(id)sender 
{
    if([[_loginBarButtonItem title] isEqualToString:@"Login"])
    {
        UIAlertView *orderAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Login First" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        
        [orderAlert show];
    }
    else if([[_loginBarButtonItem title] isEqualToString:@"Logout"])
    {
        NSMutableDictionary *dataItem;
        
        NSString *orderListMsg = [[NSString alloc] init];
        
        
        for(int i=0;i<6;i++)
        {
            dataItem = [orderList objectAtIndex:i];
            int count = (int)[dataItem valueForKey:@"Count"];
            if (count!=0) 
            {
                orderListMsg  = [orderListMsg stringByAppendingFormat:@"%@    pcs:%@\n", [dataItem valueForKey:@"ID"], [dataItem valueForKey:@"Count"]];
                NSLog(@"%s Name=%@ Count=%@", __FUNCTION__, [dataItem valueForKey:@"Name"], [dataItem valueForKey:@"Count"]);
            }
        }
        
        if(orderListMsg.length==0)
        {
             UIAlertView *orderEmpty = [[UIAlertView alloc] initWithTitle:@"Order" message:@"Order List Empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [orderEmpty show];
        }
        else 
        {
            UIAlertView *orderConfirm = [[UIAlertView alloc] initWithTitle:@"Order" message:orderListMsg delegate:self cancelButtonTitle:@"Cancel"otherButtonTitles:@"Order", nil];
            
            [orderConfirm show];
        }
    }
}

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
    else if ([title isEqualToString:@"Order"])
    {
        NSLog(@"%s title=%@", __FUNCTION__, title);
         
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
    sleep(2);
    /*
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login";
    
    loginRequest = [loginRequest stringByAppendingFormat:@"?email=%@",_username];
    loginRequest = [loginRequest stringByAppendingFormat:@"&password=%@",_password];
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    NSLog(@"login result%@", loginResult);
    
    NSString *result = [webserviceModel getLoginResponse:loginResult];
    //NSLog(@"result:%@",result);
    
    if([@"1" isEqualToString:result])
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
    
    */
    
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

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
        cell = [[CompositeSubviewBasedApplicationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:CellIdentifier];
    }
    
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    NSDictionary *dataItem = [_data objectAtIndex:indexPath.row];
    cell.icon = [UIImage imageNamed:[dataItem objectForKey:@"Icon"]];
    cell.price = [dataItem objectForKey:@"Price"];
    cell.name = [dataItem objectForKey:@"Name"];
    cell.numRatings = [[dataItem objectForKey:@"NumRatings"] intValue];
    cell.rating = [[dataItem objectForKey:@"Rating"] floatValue];
    cell.stepper.tag = indexPath.row;

	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NUSMenuDetailViewController *menuDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuDetail"];

    menuDetail.dataItem = [_data objectAtIndex:indexPath.row];;
    
    [self.navigationController pushViewController:menuDetail animated:YES];
}
@end
