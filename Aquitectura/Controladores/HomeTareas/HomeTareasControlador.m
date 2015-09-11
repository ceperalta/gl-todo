//
//  HomeTareasControlador.m
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "HomeTareasControlador.h"
#import "HomeUIViewController.h"
#import "HomeTareasModelo.h"
#import "TareaDTO.h"
#import "App.h"


@interface HomeTareasControlador()

@property (retain,nonatomic) HomeUIViewController *homeUIViewController;
@property (retain,nonatomic) HomeTareasModelo *homeTareasModelo;

@end

@implementation HomeTareasControlador

- (id) init_contenedorHomeUIViewController:(HomeUIViewController*)homeUIViewController{
    NSLog(@"%s", __FUNCTION__);
    
    _homeUIViewController = homeUIViewController;
    _homeTareasModelo = [[HomeTareasModelo alloc] init_HomeTareasControlador:self];
    
    return self;
}

- (void) lleganTareas:(NSArray*)tareasNSArray{
    NSLog(@"%s", __FUNCTION__);
    
    [_homeUIViewController ocultarCargadorTablaTareas];
    
    NSMutableArray *tareasNSMutableArray = [[NSMutableArray alloc] initWithArray:tareasNSArray];
    
    [_homeUIViewController cargarTareasEnTabla_tareasNSMutableArray:tareasNSMutableArray];
}

- (void) tomarTareas{
    NSLog(@"%s", __FUNCTION__);

    [_homeUIViewController mostrarCargadorTablaTareas];
    
    [_homeTareasModelo tomarTareas];
}

- (void) cargarTareasParaIdCat_idCatInt:(int)idCatInt{
    NSLog(@"%s", __FUNCTION__);
    
    [_homeUIViewController ocultarTablaYMostrarCargador];
    
    App *app = (App*)[[UIApplication sharedApplication] delegate];
    [app.controladorPrincipalNSObject ocultarMenuSlideAnimando];
    
    [_homeTareasModelo tomarTareasParaCat_idCatInt:idCatInt];
}


- (void) eliminarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);

    [_homeTareasModelo eliminarTarea_tareaTareaDTO:tareaTareaDTO];
}


- (void) problemasEnEliminacionTarea{
    NSLog(@"%s", __FUNCTION__);
    [_homeUIViewController ocultarCargadorEliminaTareaYVolverBtnEliminar];
}

- (void) elimiacionTareaOK{
    NSLog(@"%s", __FUNCTION__);
    [_homeUIViewController eliminarCeldaConAnimacion];
}



@end








