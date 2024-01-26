//
//  LoginViewController.h
//  NiftyGifties
//
//  Created by TechFlitter on 09/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate> 
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *versionLabel;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIButton *loginButton;
}

@end
