//
//  UITextField+FPPickerViewTextField.m
//  FPPickerView
//
//  Created by XAV-MAC13 on 28/06/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "UITextField+FPPickerViewTextField.h"
#import "FPPickerView.h"
@implementation UITextField (FPPickerViewTextField)
FPPickerView* pickerView;
-(FPPickerView*) addDropDownWithTitles:(NSMutableArray*)titles titleVariableName:(NSString*)variableName
{
    pickerView=[FPPickerView pickerViewOnTextField:self withItems:titles andTitleVariableName:variableName];
    return pickerView;
}
-(FPPickerView*) addDropDownWithTitles:(NSMutableArray*)titles titleVariableName:(NSString*)variableName andTintColor:(UIColor*)tintColor
{
    pickerView=[FPPickerView pickerViewOnTextField:self withItems:titles andTitleVariableName:variableName andColor:tintColor];
    return pickerView;
}
@end
