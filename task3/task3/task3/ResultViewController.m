//
//  ResultViewController.m
//  task3
//
//  Created by Anton Lookin on 12/16/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "ResultViewController.h"
#import "FormViewController.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

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
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
