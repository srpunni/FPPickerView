//
//  FPPickerView.m
//  FPPickerView
//
//  Created by XAV-MAC13 on 28/06/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "FPPickerView.h"
#import "TraingularView.h"
#import <QuartzCore/QuartzCore.h>
@interface FPPickerView()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    __weak IBOutlet TraingularView *topArrowImageView;
    __weak IBOutlet TraingularView *arrowDownImageView;
    __weak IBOutlet UIView *pickerBackgroundView;
    __strong IBOutlet UIPickerView *pickerView;
    __weak IBOutlet UIToolbar *toolbar;
    int tempSelectedIndex;
    BOOL isVisible;
}

@end
@implementation FPPickerView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self=[[[NSBundle mainBundle] loadNibNamed:@"FPPickerView" owner:self options:nil] objectAtIndex:0];
    NSLog(@"HHHH=%@",pickerView);
    

    return self;
}
+(FPPickerView*) pickerViewOnTextField:(UITextField*)textField withItems:(NSMutableArray*)array andTitleVariableName:(NSString*)propertyVariableName
{
    return [FPPickerView pickerViewOnTextField:textField withItems:array andTitleVariableName:propertyVariableName andColor:[UIColor blackColor]];
}
+(FPPickerView*) pickerViewOnTextField:(UITextField*)textField withItems:(NSMutableArray*)array andTitleVariableName:(NSString*)propertyVariableName andColor:(UIColor*)tColor
{
    [TraingularView setColor:tColor];
    FPPickerView* fpPickerView=[[FPPickerView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [fpPickerView->pickerBackgroundView setBackgroundColor:tColor];
    [fpPickerView->toolbar setTintColor:tColor];
    fpPickerView.selectedIndex=0;
    fpPickerView.position=FPPickerViewPositionDown;
    fpPickerView.dropDownTextField=textField;
    fpPickerView.borderWidth=10;
    fpPickerView->pickerView.delegate=fpPickerView;
    fpPickerView.dropDownTextField.delegate=fpPickerView;
    fpPickerView.items=array;
    fpPickerView.titlePropertyVariableName=propertyVariableName;
    
    [fpPickerView setSize:CGSizeMake(200, 240)];
    
       
    fpPickerView->pickerBackgroundView.layer.cornerRadius=7;
    fpPickerView->toolbar.layer.cornerRadius=7;
    fpPickerView->toolbar.layer.masksToBounds=YES;
    
    return fpPickerView;
}
-(void) updatePickerPosition
{
    CGRect tfFrame=self.dropDownTextField.frame;
    
    float x=tfFrame.origin.x+((tfFrame.size.width-self.frame.size.width)/2.0);
    float y=tfFrame.origin.y+tfFrame.size.height;
    self->arrowDownImageView.hidden=YES;
     self->topArrowImageView.hidden=NO;
    if (self.position==FPPickerViewPositionUp) {
        y=tfFrame.origin.y-self.frame.size.height;
        self->topArrowImageView.hidden=YES;
        self->arrowDownImageView.hidden=NO;
    }
    self.frame=CGRectMake(x, y, self.frame.size.width, self.frame.size.height);

}
#pragma -mark UIPickerViewDataSource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int rows=self.items.count;
    if ([self.datasource respondsToSelector:@selector(numberOfRowsInPickerView:)]) {
        rows=[self.datasource numberOfRowsInPickerView:self];
    }
    return rows;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma -mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title=@"";
    if ([self.delegate respondsToSelector:@selector(pickerView:titleForRowAtIndex:)]) {
        title=  [self.delegate pickerView:self titleForRowAtIndex:row];
    }
   else if (self.items.count>row) {
        id object=[self.items objectAtIndex:row];
       if ([object isKindOfClass:[NSString class]]) {
           title=object;
       }
       else
       {
        title=[object valueForKey:self.titlePropertyVariableName];
       }
    }
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    tempSelectedIndex=row;
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRowAtIndex:)]) {
        return [self.delegate pickerView:self didSelectRowAtIndex:row];
    }
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectObject:)]) {
        return [self.delegate pickerView:self didSelectObject:[self.items objectAtIndex:row]];
    }
}
#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (isVisible) {
        [self hidePicker];
    }
    else
    {
        [self showPicker];
         [pickerView reloadAllComponents];
    }
   
   
    NSLog(@"HHH=%@",self.items);
    return NO;
}
-(void) showPicker
{
    [self hideOtheres];
    [self.dropDownTextField.superview endEditing:YES];
    [self updatePickerPosition];
    [self removeFromSuperview];
    [self.dropDownTextField.superview addSubview:self];
    [pickerView selectRow:0 inComponent:0 animated:YES];  
    
    self.alpha=0;
    toolbar.alpha=0;
    pickerView.alpha=0;
    pickerBackgroundView.alpha=0;
    [UIView animateWithDuration:.7 animations:^{
        self.alpha=1;
        toolbar.alpha=1;
        pickerView.alpha=1;
        pickerBackgroundView.alpha=1;
        
    } completion:^(BOOL finished) {
        [pickerView selectRow:self.selectedIndex inComponent:0 animated:YES];
        isVisible=YES;
    }];
   
    
}
-(void) hidePicker
{
  
    
    [UIView animateWithDuration:.7 animations:^{
        self.alpha=0;
        toolbar.alpha=0;
        pickerView.alpha=0;
        pickerBackgroundView.alpha=0;
        
    } completion:^(BOOL finished) {
        isVisible=NO;
        [self removeFromSuperview];
    }];
    
}
-(void)hideOtheres
{
    for (UIView* vw in self.dropDownTextField.superview.subviews) {
        if ([vw isKindOfClass:[FPPickerView class]]&&vw!=self&&((FPPickerView*)vw)->isVisible) {
            [((FPPickerView*)vw) hidePicker];
        }
    }
}
-(void) setSize:(CGSize)size
{
   
    size.height=216+self.borderWidth;
    
    CGRect rect=self.frame;
    rect.size.width=size.width;
    rect.size.height=size.height+arrowDownImageView.frame.size.height;
    self.frame=rect;
    
    
    
    
    
    rect=pickerBackgroundView.frame;
    rect.size.width=size.width;
    rect.size.height=size.height-topArrowImageView.frame.size.height;
    rect.origin.y=topArrowImageView.frame.size.height;
    pickerBackgroundView.frame=rect;
    
    rect=toolbar.frame;
    rect.size.width=size.width;
    rect.origin.x=0;
    rect.origin.y=0;
    toolbar.frame=rect;
    
    rect=topArrowImageView.frame;
    rect.origin.x=(self.frame.size.width-rect.size.width)/2.0;
    topArrowImageView.frame=rect;
    
    rect=pickerView.frame;
    rect.size.width=toolbar.frame.size.width-(2*self.borderWidth);
    NSLog(@"%f  %f   %d",pickerBackgroundView.frame.size.height,toolbar.frame.size.height,self.borderWidth);
    float height=pickerBackgroundView.frame.size.height-toolbar.frame.size.height-self.borderWidth;
    rect.size.height=height;
    rect.origin.x=self.borderWidth;
    rect.origin.y=toolbar.frame.size.height;
   // pickerView=[[UIPickerView alloc] initWithFrame:rect];
   // [pickerBackgroundView addSubview:pickerView];
    pickerView.frame=rect;
    pickerView.delegate=self;
    pickerView.dataSource=self;
    rect=arrowDownImageView.frame;
    rect.origin=CGPointMake(topArrowImageView.frame.origin.x, pickerBackgroundView.frame.size.height+topArrowImageView.frame.size.height);
    arrowDownImageView.frame=rect;
    NSLog(@"%@   ==%f",pickerView,height);
    
}
- (IBAction)cancelButtonTapped:(id)sender {
    [self hidePicker];
}
- (IBAction)clearButtonTapped:(id)sender {
    self.dropDownTextField.text=@"";
    [self hidePicker];
}
- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
        [self hidePicker];
        [self performSelector:@selector(updateTextField) withObject:nil afterDelay:.5];
}
-(void) updateTextField
{
    @try {
        self.selectedIndex=tempSelectedIndex;
        id object=[self.items objectAtIndex:self.selectedIndex];
        
        if ([object isKindOfClass:[NSString class]]) {
            self.dropDownTextField.text=object;
        }
        else
        {
            NSString* title=[object valueForKey:self.titlePropertyVariableName];
            self.dropDownTextField.text=title;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"hh=%@",exception);
    }
    

}
@end
