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
    [self.globButtons addObject:[NSString stringWithFormat:@"Nineteen Hundred Eighty Four - George Orwell"]];

    _countryNames = @[@"Australia (AUD)", @"People's Republic of China (CNY)",
                      @"France (EUR)", @"Great Britain (GBP)", @"Japan (JPY)"];
    
    _exchangeRates = @[ @0.9922f, @6.5938f, @0.7270f,
                        @0.6206f, @81.57f];
}

- (IBAction)showAlert:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Take your pick\n\n\n\n\n\n\n\n"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, 270, 216.0)];
    picker.center = CGPointMake(135.0, 131.0);
    //set the pickers datasource and delegate
    picker.delegate = self;
    picker.dataSource = self;
    [alert.view addSubview:picker];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"OK");
    }]];
    //load with selected row
    int row = (int)self.pickerRow;
    if (row > 0) {
        [picker reloadAllComponents];
        [picker selectRow:row inComponent:0 animated:YES];
    }
    [self presentViewController:alert animated:NO completion:nil];
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _countryNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _countryNames[row];
}

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    // dismiss keyboard
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    // update resullabel
    float rate = [_exchangeRates[row] floatValue];
    float dollars = [_dollarText.text floatValue];
    float result = dollars * rate;
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"%.2f USD = %.2f %@", dollars, result,
                              _countryNames[row]];
    _resultLabel.text = resultString;
    self.pickerRow = row;
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
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
