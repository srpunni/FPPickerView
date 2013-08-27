//
//  UITextField+FPPickerViewTextField.h
//  FPPickerView
//
//  Created by XAV-MAC13 on 28/06/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPickerView.h"
@interface UITextField (FPPickerViewTextField)
-(FPPickerView*) addDropDownWithTitles:(NSMutableArray*)titles titleVariableName:(NSString*)variableName;
-(FPPickerView*) addDropDownWithTitles:(NSMutableArray*)titles titleVariableName:(NSString*)variableName andTintColor:(UIColor*)tintColor;
@end
