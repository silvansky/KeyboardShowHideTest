//
//  ViewController.m
//  KeyboardShowHideTest
//
//  Created by Valentine on 21.07.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)cancelClicked:(id)sender {
	[self.textField resignFirstResponder];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
	CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
	self.bottomConstraint.constant = keyboardHeight;
	self.heightConstraint.constant = 44;

	[self.view setNeedsUpdateConstraints];

	NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] * 0.9f;

	NSInteger opts = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
	[UIView animateWithDuration:duration delay:0.f options:opts << 16 animations:^{
		[self.view layoutIfNeeded];
	} completion:NULL];

}

- (void)keyboardDidShow:(NSNotification *)notification
{
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.bottomConstraint.constant = 44;
	self.heightConstraint.constant = 60;

	[self.view setNeedsUpdateConstraints];

	NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] * 0.9f;

	NSInteger opts = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
	[UIView animateWithDuration:duration delay:0.f options:opts << 16 animations:^{
		[self.view layoutIfNeeded];
	} completion:NULL];

}

- (void)keyboardDidHide:(NSNotification *)notification
{
}

@end
