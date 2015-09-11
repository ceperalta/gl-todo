//
//  LoginWidget.m
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

// Todos los nombres de xib, h y m deben ser iguales

#import "CrearCuentaWidget.h"




@interface CrearCuentaWidget ()
    @property (nonatomic, retain) UIView *uiView;
@end

@implementation CrearCuentaWidget




- (IBAction)cancelarUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado cancelarUIButton_presionado];
}

- (IBAction)crearCuentaUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado crearCuentaUIButton_presionado];
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
