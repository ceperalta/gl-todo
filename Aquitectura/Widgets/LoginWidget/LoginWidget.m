//
//  LoginWidget.m
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

// Todos los nombres de xib, h y m deben ser iguales

#import "LoginWidget.h"


@interface LoginWidget ()
    @property (nonatomic, retain) UIView *uiView;
@end

@implementation LoginWidget



- (void) girarAView:(UIView*)vistaDestinoUIView{
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)ingresarUIButton:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado btnIngresarPresionado];
}

- (IBAction)crearCuentaUIButton:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado btnCrearCuentaPresionado];
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

- (void) dealloc
{
    NSLog(@"%s", __FUNCTION__);
}


/*
 
 func setup() {
 view = loadViewFromNib()
 
 view.frame = bounds
 view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight

 addSubview(view)
 }
 
 func loadViewFromNib() -> UIView {
 
 let bundle = NSBundle(forClass: self.dynamicType)
 let nib = UINib(nibName: nibName, bundle: bundle)
 let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
 
 return view
 }
 
 
 */

@end
