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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Please wait\n\n\n"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 65.5);
    spinner.color = [UIColor blackColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel");
    }]];
    [self presentViewController:alert animated:NO completion:nil];
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
