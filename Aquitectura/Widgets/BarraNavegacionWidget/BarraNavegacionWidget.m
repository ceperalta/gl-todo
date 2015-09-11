//
//  BarraNavegacionWidget.m
//  Aquitectura
//
//  Created by Carlos Peralta on 28/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "BarraNavegacionWidget.h"

@interface BarraNavegacionWidget()

@property (weak,nonatomic) UIView *uiView;

@end

@implementation BarraNavegacionWidget


- (IBAction)nuevaTareaUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado btnNuevaTareaPresionado];
}

- (IBAction)menuUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado btnMenuPresionado];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"%s", __FUNCTION__);
    self = [super initWithFrame:frame];
    if (self) {
        [self configurar];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __FUNCTION__);
    self = [super initWithCoder:coder];
    if (self) {
        [self configurar];
    }
    return self;
}

- (void) configurar{
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"configurar widget: %@",NSStringFromClass(self.class));
    
    NSBundle *nsBundle = [NSBundle bundleForClass:self.class];
    
    UINib *uiNib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nsBundle];
    
    _uiView = (UIView*)[[uiNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    _uiView.frame = self.bounds;
    _uiView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:_uiView];
    
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end
