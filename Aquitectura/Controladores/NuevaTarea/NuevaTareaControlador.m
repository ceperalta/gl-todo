//
//  NuevaTareaControlador.m
//  Aquitectura
//
//  Created by Carlos Peralta on 9/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "NuevaTareaControlador.h"
#import "NuevaTarea.h"
#import "NuevaTareaModelo.h"
#import "CategoriaDTO.h"


@interface NuevaTareaControlador()

@property (weak, nonatomic) NuevaTarea *nuevaTareaUIViewController;
@property (retain, nonatomic) NuevaTareaModelo *nuevaTareaModelo;

@end


@implementation NuevaTareaControlador

- (id) init_nuevaTareaUIViewController:(NuevaTarea*)nuevaTareaUIViewController{
    NSLog(@"%s", __FUNCTION__);
    
    _nuevaTareaUIViewController = nuevaTareaUIViewController;
    _nuevaTareaModelo = [[NuevaTareaModelo alloc] init_NuevaTareaControlador:self];
    
    return self;
}

- (void) agregarTarea_tareaNSString:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    [_nuevaTareaModelo agregarTarea_tareaTareaDTO:tareaTareaDTO];
}

- (void) terminoAgregarTarea{
    NSLog(@"%s", __FUNCTION__);
    [_nuevaTareaUIViewController cerrarYRecargarTareasMasCategorias];
}

- (void) terminoAgregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO{
    NSLog(@"%s", __FUNCTION__);

    _nuevaTareaUIViewController.tareaNuevaTareaDTO.idCategoriaParaEstaTareaInt = categoriaCategoriaDTO.idCategoriaInt;
    [self agregarTarea_tareaNSString:_nuevaTareaUIViewController.tareaNuevaTareaDTO];
}

- (void) agregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    [_nuevaTareaModelo agregarCategoria_categoriaCategoriaDTO:categoriaCategoriaDTO];
}

- (void) agregarTareaAccionRequerida{
    NSLog(@"%s", __FUNCTION__);
    
    [_nuevaTareaUIViewController bloquearComponentesYMostrarCargadorSobreBtnAgregar];
    
    if (_nuevaTareaUIViewController.categoriaNuevaCategoriaDTO != nil && _nuevaTareaUIViewController.categoriaNuevaCategoriaDTO.idCategoriaInt == -1) {
        [self agregarCategoria_categoriaCategoriaDTO:_nuevaTareaUIViewController.categoriaNuevaCategoriaDTO];
    }else{
        [self agregarTarea_tareaNSString:_nuevaTareaUIViewController.tareaNuevaTareaDTO];
    }
}

@end
