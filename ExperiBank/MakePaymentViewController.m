//
//  MakePaymentViewController.m
//  ExperiBank
//
//  Created by TechFlitter on 31/12/12.
//  Copyright (c) 2012 Experitest. All rights reserved.
//

#import "MakePaymentViewController.h"
#import "CountryTableViewController.h"

@interface MakePaymentViewController ()

@end

@implementation MakePaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setAccessibilityLabel:@"makePaymentView"];
    [scrollView setAccessibilityLabel:@"scrollView"];
    [phoneTextField setAccessibilityLabel:@"phoneTextField"];
    [nameTextField setAccessibilityLabel:@"nameTextField"];
    [amountTextField setAccessibilityLabel:@"amountTextField"];
    [countryTextField setAccessibilityLabel:@"countryTextField"];
    [countryButton setAccessibilityLabel:@"countryButton"];
    [sendPaymentButton setAccessibilityLabel:@"sendPaymentButton"];
    [cancelButton setAccessibilityLabel:@"cancelButton"];
    
    scrollView.contentSize = self.view.frame.size;
}

- (void)viewDidUnload
{
    phoneTextField = nil;
    nameTextField = nil;
    amountTextField = nil;
    countryTextField = nil;
    countryButton = nil;
    sendPaymentButton = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [sendPaymentButton setEnabled:[self readyToSignIn]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldChanged
{
    [sendPaymentButton setEnabled:[self readyToSignIn]];
}

- (BOOL)readyToSignIn
{
    return [phoneTextField.text length] != 0 && [nameTextField.text length] != 0
    && [amountTextField.text length] != 0 && [countryTextField.text length] != 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)source
{
    if(source == phoneTextField)
        [nameTextField becomeFirstResponder];
    else if(source == nameTextField)
        [amountTextField becomeFirstResponder];
    else if(source == amountTextField)
        [countryTextField becomeFirstResponder];
    else if(source == countryTextField)
        [self sendPaymentPressed:source];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        float balance = [[NSUserDefaults standardUserDefaults] floatForKey:@"Balance"] - [amountTextField.text floatValue];
        [[NSUserDefaults standardUserDefaults] setFloat:balance forKey:@"Balance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)sendPaymentPressed:(id)sender
{
    [phoneTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [amountTextField resignFirstResponder];
    [countryTextField resignFirstResponder];
    
    [[[UIAlertView alloc] initWithTitle:@"ExperiBank" message:@"Are you sure you want to send payment?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil] show];
}

- (IBAction)cancelPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectCountryPressed:(id)sender
{
    [phoneTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [amountTextField resignFirstResponder];
    [countryTextField resignFirstResponder];
    
    CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] initWithNibName:@"CountryTableViewController" bundle:nil];
    [countryTableViewController setCountryTextField:countryTextField];
    [self presentViewController:countryTableViewController animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [sendPaymentButton setEnabled:[self readyToSignIn]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
