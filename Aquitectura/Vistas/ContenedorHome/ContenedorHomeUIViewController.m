//
//  ContenedorHomeUIViewController.m
//  Aquitectura
//
//  Created by Carlos Peralta on 31/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "ContenedorHomeUIViewController.h"
#import "ControladorPrincipalNSObject.h"
#import "MenuGeneralUIViewController.h"
#import "HomeUIViewController.h"

@interface ContenedorHomeUIViewController () <UIGestureRecognizerDelegate,MenuGeneralUIViewControllerProtocol>
    @property (nonatomic, retain) ControladorPrincipalNSObject *controladorPrincipalRefNSObject;
    @property (nonatomic, assign) BOOL menuAbiertoBool;
@end

@implementation ContenedorHomeUIViewController

- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject{
    NSLog(@"%s", __FUNCTION__);
    
    _controladorPrincipalRefNSObject = controladorPrincipalNSObject;
    
    // Crear vista Home
    _homeUIViewController = [[HomeUIViewController alloc] inciaConSuNibYControlador_ControladorPrincipalNSObject:controladorPrincipalNSObject];
    _homeUIViewController.delegado = self;
    [self addChildViewController:_homeUIViewController];
    [_homeUIViewController didMoveToParentViewController:self];
    [self.view addSubview:_homeUIViewController.view];
    
    // Sombra
    [_homeUIViewController.view.layer setCornerRadius:4];
    [_homeUIViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [_homeUIViewController.view.layer setShadowOpacity:0.8];
    [_homeUIViewController.view.layer setShadowOffset:CGSizeMake(-2, -2)];
    
    
    // Crear vista Menú abajo del home...
    _menuGeneralUIViewController = [[MenuGeneralUIViewController alloc] iniciarConSuNibYControlador_ControladorPrincipalNSObject:_controladorPrincipalRefNSObject];
    _menuGeneralUIViewController.delegado = self;
    [self addChildViewController:_menuGeneralUIViewController];
    [_menuGeneralUIViewController didMoveToParentViewController:self];
    _menuGeneralUIViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_menuGeneralUIViewController.view];
    [self.view sendSubviewToBack:_menuGeneralUIViewController.view];
    
    [self setupGestures];
    
    
    return [self initWithNibName:@"ContenedorHomeUIViewController" bundle:nil];
}

-(void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    _menuAbiertoBool = false;
}

-(void)setupGestures {
    NSLog(@"%s", __FUNCTION__);
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_homeUIViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        [self moverACeroOAbrir];
    }

    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if ([sender view].frame.origin.x > -0.9) {
            [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
            [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        }
    }
}

- (void) moverACeroOAbrir{
    NSLog(@"%s", __FUNCTION__);
    if (_homeUIViewController.view.frame.origin.x > 170) {
        [self moverMenu_abrirBool:true];
    }else{
        [self moverMenu_abrirBool:false];
    }
}

- (void) moverMenu_abrirBool:(BOOL)abrirBool{
    NSLog(@"%s", __FUNCTION__);
    if (abrirBool) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _homeUIViewController.view.frame = CGRectMake(265, 0, _homeUIViewController.view.frame.size.width, _homeUIViewController.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                         }];
        _menuAbiertoBool = true;
    }else{
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _homeUIViewController.view.frame = CGRectMake(0, 0, _homeUIViewController.view.frame.size.width, _homeUIViewController.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                         }];
        _menuAbiertoBool = false;
    }
}

- (void) cerrarMenuAnimado{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _homeUIViewController.view.frame = CGRectMake(0, 0, _homeUIViewController.view.frame.size.width, _homeUIViewController.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
    }];
    _menuAbiertoBool = FALSE;
}

- (void) cambiarEstadoMenu{
    NSLog(@"%s", __FUNCTION__);
    if(_menuAbiertoBool){
        [self moverMenu_abrirBool:false];
    }else{
        [self moverMenu_abrirBool:true];
    }
    
}

- (void) cerrarSesionUIButton_presionado{
    NSLog(@"%s", __FUNCTION__);
    [_controladorPrincipalRefNSObject volverPrimerVista_desdeUIViewController:self];
}

- (void)dealloc
{
   NSLog(@"%s", __FUNCTION__);
}

@end
