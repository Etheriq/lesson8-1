//
//  ResultViewController.m
//  task3
//
//  Created by Anton Lookin on 12/16/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "ResultViewController.h"
#import "FormViewController.h"

@interface ResultViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolleView;
@property (strong, nonatomic) UITextField *activeField;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    [result appendAttributedString:[self getAttributedString:@"Name: " withValue:[self.result objectForKey:GH_FORM_NAME]]];
    [result appendAttributedString:[self getBlankString]];
    [result appendAttributedString:[self getAttributedString:@"Email: " withValue:[self.result objectForKey:GH_FORM_EMAIL]]];
    [result appendAttributedString:[self getBlankString]];
    [result appendAttributedString:[self getAttributedString:@"Phone: " withValue:[self.result objectForKey:GH_FORM_PHONE]]];
    [result appendAttributedString:[self getBlankString]];
    [result appendAttributedString:[self getAttributedString:@"Address: " withValue:[self.result objectForKey:GH_FORM_ADDRESS]]];
    [result appendAttributedString:[self getBlankString]];
    [result appendAttributedString:[self getCommentAttributedString:@"Comments: " withValue:[self.result objectForKey:GH_FORM_COMMENTS]]];
    
    self.resultLabel.attributedText = result;
    
    NSLog(@"%@", self.result);
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [nc addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - AttributedStrings

-(NSMutableAttributedString *) getAttributedString:(NSString*) key withValue:(NSString*) value {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:key attributes:
                                 @{
                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:15],
                                   NSForegroundColorAttributeName: [UIColor blackColor]
                                   }];
    NSAttributedString *content = [[NSAttributedString alloc] initWithString:value attributes:
                                   @{
                                     NSFontAttributeName: [UIFont fontWithName:@"Menlo" size:15],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]
                                     }];
    
    NSMutableAttributedString *origin = [[NSMutableAttributedString alloc] initWithAttributedString:title];
    [origin appendAttributedString:content];
    
    return origin;
}

-(NSMutableAttributedString *) getCommentAttributedString:(NSString*) key withValue:(NSString*) value {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:key attributes:
                                 @{
                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:15],
                                   NSForegroundColorAttributeName: [UIColor blackColor]
                                   }];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:value attributes:
                                   @{
                                     NSFontAttributeName: [UIFont fontWithName:@"Menlo" size:15],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]
                                     }];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    [content addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, 1)];
    
    NSMutableAttributedString *origin = [[NSMutableAttributedString alloc] initWithAttributedString:title];
    [origin appendAttributedString:content];
    
    return origin;
}

-(NSAttributedString*) getBlankString {
    NSAttributedString *blank = [[NSAttributedString alloc] initWithString:@"\n" attributes:nil];
 
    return blank;
}

#pragma mark - Keyboard

- (void)onKeyboardShow:(NSNotification *) notification {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 5, 0.0);
    self.scrolleView.contentInset = contentInsets;
    self.scrolleView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrolleView scrollRectToVisible:self.activeField.frame animated:YES];
    }
    // ************
//    NSDictionary* info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    CGRect bkgndRect = self.activeField.superview.frame;
//    bkgndRect.size.height += kbSize.height;
//    [self.activeField.superview setFrame:bkgndRect];
//    [self.scrolleView setContentOffset:CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height) animated:YES];
}

- (void)onKeyboardHide:(NSNotification *) notification {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)onKeyboardWillBeHide:(NSNotification *) notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrolleView.contentInset = contentInsets;
    self.scrolleView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

#pragma mark - Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
