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
@property (strong, nonatomic) NSString *validationErrorMessage;

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
    
    if ([self.name isFirstResponder]) {
        [self.name resignFirstResponder];
    } else if ([self.email isFirstResponder]) {
        [self.email resignFirstResponder];
    } else if ([self.phone isFirstResponder]) {
        [self.phone resignFirstResponder];
    } else if ([self.address isFirstResponder]) {
        [self.address resignFirstResponder];
    } else if ([self.comments isFirstResponder]) {
        [self.comments resignFirstResponder];
    }
    
    if ([self isFormValid]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Form validation" message:@"Validation passed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [self performSegueWithIdentifier:@"resultSegue" sender:nil];                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    
    } else {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Form validation" message:self.validationErrorMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Validation

- (BOOL) isFormValid {

    if ([self validateStringIsNotBlanck:self.name.text]) {
        self.validationErrorMessage = @"Field name is blank";
        
        return NO;
    } else if (![self validateEmail:self.email.text]) {
        self.validationErrorMessage = @"Field Email is not valid or is blank";
        
        return NO;
    } else if ([self validateStringIsNotBlanck:self.phone.text] || ![self isNumeric:self.phone.text]) {
        self.validationErrorMessage = @"Field Phone is blank or not numeric";
        
        return NO;
    } else if ([self validateStringIsNotBlanck:self.address.text]) {
        self.validationErrorMessage = @"Field Address is blank";
        
        return NO;
    }
    
    return YES;
}

-(BOOL)isNumeric:(NSString*)inputString{
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    
    return [alphaNumbersSet isSupersetOfSet:stringSet];
}

- (BOOL) validateEmail:(NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL) validateStringIsNotBlanck:(NSString *) inputString {
    
    return [inputString isEqualToString:@""] ? YES : NO;
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

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView isEqual:self.comments]) {
        [self.data setObject:textView.text forKey:GH_FORM_COMMENTS];
    }
}

@end
