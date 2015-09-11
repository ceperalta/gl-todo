//
//  CeldaTablaTareasWidget.m
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "CeldaTablaTareasWidget.h"

@interface CeldaTablaTareasWidget()

@property (assign,nonatomic) CGPoint centroOriginalCGPoint;
@property (assign,nonatomic) BOOL noAbrioSuficienteParaMostrarEliminarBOOL;
@property (assign,nonatomic) BOOL estaAbiertoBOOL;

@end


@implementation CeldaTablaTareasWidget

- (void)awakeFromNib {
    NSLog(@"%s", __FUNCTION__);
  
    _estaAbiertoBOOL = false;
    
    _cargadorSobreEliminarUIActivityIndicatorView.hidden = true;
    
    [self configurarGesto];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    
    [super setSelected:selected animated:animated];
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

-(void)configurarGesto {
    NSLog(@"%s", __FUNCTION__);
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moverCelda:)];
    panRecognizer.delegate = self;
    [_vistaPrincipalUIView addGestureRecognizer:panRecognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    NSLog(@"%s", __FUNCTION__);
    
    CGPoint translation = [gestureRecognizer translationInView:[_vistaPrincipalUIView superview]];
   
    NSLog(@"%f",translation.x);
    
    // Comprobamos si se trata de un gesto horizontal, si incia hacia la izquierda o ya está abierto, para habilitar el gesto. Sino da paso al otro gestos como el necesario para abrir el menú
    if (fabsf(translation.x) > fabsf(translation.y) && (translation.x < 0.1 || _estaAbiertoBOOL)) {
        return YES;
    }
    return NO;
}

- (IBAction)btnElimininarUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
 
    [_delegado btnEliminarPresionado_celdaCeldaTablaTareasWidget:self];
}

-(void)moverCelda:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
         _centroOriginalCGPoint = _vistaPrincipalUIView.center;
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, _vistaPrincipalUIView.frame.origin.y,
                                          _vistaPrincipalUIView.bounds.size.width, _vistaPrincipalUIView.bounds.size.height);
        
        CGRect frameALTamanioViewBtnEliminar = CGRectMake( -_vistaBtnEliminarUIView.frame.size.width, _vistaPrincipalUIView.frame.origin.y,
                                          _vistaPrincipalUIView.bounds.size.width, _vistaPrincipalUIView.bounds.size.height);
        
        if (!_noAbrioSuficienteParaMostrarEliminarBOOL) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _vistaPrincipalUIView.frame = originalFrame;
                                 _estaAbiertoBOOL = false;
                             }
             ];
        }else{
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _vistaPrincipalUIView.frame = frameALTamanioViewBtnEliminar;
                                 _estaAbiertoBOOL = true;
                             }
             ];
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:_vistaPrincipalUIView];
        _vistaPrincipalUIView.center = CGPointMake(_centroOriginalCGPoint.x + translation.x, _centroOriginalCGPoint.y);
        _noAbrioSuficienteParaMostrarEliminarBOOL = _vistaPrincipalUIView.frame.origin.x < (-_vistaPrincipalUIView.frame.size.width / 2);
    }
}



@end
