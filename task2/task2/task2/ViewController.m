//
//  ViewController.m
//  task2
//
//  Created by Anton Lookin on 12/16/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong, nonatomic) NSArray *allFonts;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadSystemFonts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.cur
    
//    self.textLabel.bounds.size.width = self.view.bounds.size.width;
}

#pragma mark - Actions

- (IBAction)AddButtonAction:(UIBarButtonItem *)sender {
    
    NSString *randomString = [self getRandomString];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:randomString attributes:
                                       @{
                                         NSFontAttributeName: [UIFont fontWithName:[self getRandomSystemFont] size:[self getRandomIntFrom:10 andTo:25]],
                                         NSForegroundColorAttributeName: [self getRandomColor]
                                         }];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.paragraphSpacing = [self getRandomIntFrom:5 andTo:15];
    paragraph.lineSpacing = [self getRandomIntFrom:5 andTo:15];
    paragraph.alignment = [self getRandomIntFrom:0 andTo:3];

    [content addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, 1)];
    [content insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    NSMutableAttributedString *origin = [[NSMutableAttributedString alloc] initWithAttributedString:self.textLabel.attributedText];
    [origin appendAttributedString:content];
    
    self.textLabel.attributedText = origin;
    
    NSLog(@"%@", randomString);
}

- (IBAction)ClearButtonAction:(UIBarButtonItem *)sender {
    self.textLabel.text = @"";
}

#pragma mark - Custom methods

- (NSInteger) getRandomIntFrom:(NSInteger) from andTo:(NSInteger) to {
    
    return from + arc4random() % (to + 1 - from);
}

- (void) loadSystemFonts {
    NSMutableArray *fonts = [NSMutableArray array];
    for (NSString *fontFamily in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamily]) {
            [fonts addObject:fontName];
        }
    }
    
    self.allFonts = [NSArray arrayWithArray:fonts];
}

- (NSString *) getRandomString {
    
    NSString *baseString = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ut pulvinar urna. Ut dignissim interdum risus eu lacinia. Phasellus congue justo lectus, id imperdiet odio euismod in. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec laoreet ligula tincidunt aliquam luctus. Aliquam fringilla urna nec dui lacinia sodales. Proin in est id dolor vestibulum cursus. Ut orci neque, varius nec arcu nec, laoreet vulputate augue. Phasellus eu libero massa. Curabitur vel porta nulla, in sollicitudin tellus. Praesent sed quam velit. Nunc ut feugiat nunc, eu molestie odio. Praesent lacinia massa metus, dapibus scelerisque dolor hendrerit ac. Quisque et lorem condimentum, sodales sem vitae, condimentum ex. Phasellus venenatis, erat a tincidunt faucibus, metus tortor semper nisi, id mattis urna magna vel diam. Ut elementum ante id felis laoreet, sed vehicula est tristique. Aliquam semper lacinia ornare. Pellentesque urna tellus, accumsan non ipsum ac, cursus dictum erat. Nam sit amet eros egestas elit tempor tempor.";
    
    NSUInteger baseStringLenght = [baseString length];
    NSUInteger from = [self getRandomIntFrom:0 andTo:baseStringLenght];
    NSUInteger to = baseStringLenght - [self getRandomIntFrom:from andTo:baseStringLenght] - 1;
    
//    NSLog(@"Len = %li, from %li to %li", baseStringLenght, from, to);
  
    return [baseString substringWithRange:NSMakeRange(from, to)];
}

- (NSString*) getRandomSystemFont {
    
    NSUInteger randIndex = arc4random() % [self.allFonts count];
    
    return [self.allFonts objectAtIndex:randIndex];
}

- (NSUInteger) getRandomStingSize {
    
    return (int)arc4random() % 20 + 1;
}

- (UIColor *) getRandomColor {
    float r = ((arc4random() % 256) / 255.f);
    float g = ((arc4random() % 256) / 255.f);
    float b = ((arc4random() % 256) / 255.f);
    
    return [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.f];
}

@end
