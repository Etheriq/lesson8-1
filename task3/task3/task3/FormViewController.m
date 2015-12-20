//
//  ViewController.m
//  task3
//
//  Created by Anton Lookin on 12/16/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "FormViewController.h"
#import "ResultViewController.h"

#define GH_FORM_NAME @"gh_name"
#define GH_FORM_EMAIL @"gh_email"
#define GH_FORM_PHONE @"gh_phone"
#define GH_FORM_ADDRESS @"gh_address"
#define GH_FORM_COMMENTS @"gh_comments"


@interface FormViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextView *comments;
@property (strong, nonatomic) NSMutableDictionary *data;


@end

@implementation FormViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
    self.data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                 @"" , GH_FORM_NAME,
                 @"" , GH_FORM_EMAIL,
                 @"" , GH_FORM_PHONE,
                 @"" , GH_FORM_ADDRESS,
                 @"" , GH_FORM_COMMENTS,
                 nil];

    
    NSLog(@"%@", self.data);
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)saveDataLstener:(UITextField *)sender {
    if ([sender isEqual:self.name]) {
        
        [self.data setObject:sender.text forKey:GH_FORM_NAME];
    } else if ([sender isEqual:self.email]) {
        
        [self.data setObject:sender.text forKey:GH_FORM_EMAIL];
    } else if ([sender isEqual:self.phone]) {
        
        [self.data setObject:sender.text forKey:GH_FORM_PHONE];
    } else if ([sender isEqual:self.address]) {
        
        [self.data setObject:sender.text forKey:GH_FORM_ADDRESS];
    }
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    
    [self performSegueWithIdentifier:@"resultSegue" sender:nil];
}

#pragma mark - Navigation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"resultSegue"]) {
        ResultViewController *formVC = segue.destinationViewController;
        formVC.result = self.data;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.name]) {
        [self.email becomeFirstResponder];
    } else if ([textField isEqual:self.email]) {
        [self.phone becomeFirstResponder];
    } else if ([textField isEqual:self.phone]) {
        [self.address becomeFirstResponder];
    } else {
        [self.comments becomeFirstResponder];
    }
    
    return YES;
}



@end
