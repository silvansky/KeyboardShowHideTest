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

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.textField.inputAccessoryView = [UIView new];

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

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark - CADisplayLink Tick

- (void)tick:(CADisplayLink *)displayLink
{
	CGRect r = [self.textField.inputAccessoryView.superview.layer.presentationLayer frame];
	r = [self.view convertRect:r fromView:_textField.inputAccessoryView.superview.superview];

	CGFloat fromBottom = self.view.bounds.size.height - r.origin.y;
	if (fromBottom > 44)
	{
		self.bottomConstraint.constant = fromBottom;
	}
	else
	{
		self.bottomConstraint.constant = 44;
	}
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
	self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
	[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
	[self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
	[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
	[self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

@end
