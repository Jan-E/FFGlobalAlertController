//
//  FFViewController.m
//  FFGlobalAlertController
//
//  Created by Eric Larson on 06/18/2015.
//  Copyright (c) 2015 ForeFlight. All rights reserved.
//

#import "FFViewController.h"
#import "UIAlertController+Window.h"

@interface FFViewController ()
@property (nonatomic, strong) NSMutableArray *globButtons;
@end

@implementation FFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.globButtons = [[NSMutableArray alloc]init];
    [self.globButtons addObject:[NSString stringWithFormat:@"One"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Two"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Three"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Four"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Five"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Six"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Seven"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Eight"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Nine"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Ten"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Eleven"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Twelve"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Thirteen"]];
    [self.globButtons addObject:[NSString stringWithFormat:@"Fourteen"]];
}

- (IBAction)showAlert:(id)sender
{
    static NSInteger alertCount = 1;
    
    NSString *message = [NSString stringWithFormat:@"This is your alert, you've show %ld alerts", (long)alertCount];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Global Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"One" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"One");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Two" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"OK");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Three" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Three");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destroy"style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destroy");
    }]];
    [alert show];
    alertCount++;
    
    // show a second Alert to simulate an Alert coming in from an unrelated part of your project
    if (alertCount % 2 == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showAlert:nil];
        });
    }
}

- (IBAction)showAlertCombo:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Global Alert" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableArray *selectButtons = self.globButtons;
    for (id obj in selectButtons) {
        NSString *selectButton = obj;
        [alert addAction:[UIAlertAction actionWithTitle:selectButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"button %@", selectButton);
            self.projectField.text = selectButton;
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel");
    }]];
    [alert show];
}

- (IBAction)showAlertField:(id)sender
{
// need local variable for TextField to prevent retain cycle of Alert otherwise UIWindow
// would not disappear after the Alert was dismissed
    __block UITextField *localTextField;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Global Alert" message:@"Enter some text" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"do something with text:%@", localTextField.text);
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        localTextField = textField;
    }];
    [alert show];
}

@end
