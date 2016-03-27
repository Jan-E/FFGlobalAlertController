//
//  FFViewController.h
//  FFGlobalAlertController
//
//  Created by Eric Larson on 06/18/2015.
//  Copyright (c) 2015 ForeFlight. All rights reserved.
//

@import UIKit;

@interface FFViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *countryNames;
@property (strong, nonatomic) NSArray *exchangeRates;
@property (nonatomic) NSInteger pickerRow;
@property (nonatomic) IBOutlet UITextField *dollarText;
@property (nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic) IBOutlet UITextField *projectField;
@property (nonatomic) IBOutlet UITextField *usernameText;
@property (nonatomic) IBOutlet UITextField *passwordText;

@end
