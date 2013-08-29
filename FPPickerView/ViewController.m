//
//  ViewController.m
//  FPPickerView
//
//  Created by XAV-MAC13 on 28/06/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+FPPickerViewTextField.h"
#import "Test.h"
@interface ViewController ()
{
    __weak IBOutlet UITextField *textField2;
    __weak IBOutlet UITextField *textField;
    FPPickerView* pickerView;
    FPPickerView* pickerView2;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSMutableArray* array=[[NSMutableArray alloc]init];
    Test* test=[[Test alloc]init];
    test.name=@"rrrr";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"fffff";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"ttttt";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"mmmmmm";
    [array addObject:test];
    pickerView=[textField addDropDownWithTitles:array titleVariableName:@"name" andTintColor:[UIColor brownColor]];
    
    
    array=[[NSMutableArray alloc]init];
     test=[[Test alloc]init];
    test.name=@"aaaa";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"bbbbb";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"ccccc";
    [array addObject:test];
    test=[[Test alloc]init];
    test.name=@"ddddd";
    [array addObject:test];
    pickerView2=[textField2 addDropDownWithTitles:array titleVariableName:@"name" andTintColor:[UIColor purpleColor]];
    pickerView2.position=FPPickerViewPositionUp;
  	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
