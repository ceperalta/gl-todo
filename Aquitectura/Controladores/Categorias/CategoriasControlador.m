//
//  CategoriasControlador.m
//  Aquitectura
//
//  Created by Carlos Peralta on 7/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "CategoriasControlador.h"
#import "MenuGeneralUIViewController.h"
#import "CategoriasModelo.h"
#import "CategoriaDTO.h"


@interface CategoriasControlador()

@property (retain,nonatomic) MenuGeneralUIViewController *menuGeneralUIViewController;
@property (retain,nonatomic) CategoriasModelo *categoriasModelo;

@end


@implementation CategoriasControlador

- (id) init_MenuGeneralUIViewController:(MenuGeneralUIViewController*)menuGeneralUIViewController{
    NSLog(@"%s", __FUNCTION__);
    
    _menuGeneralUIViewController = menuGeneralUIViewController;
    _categoriasModelo = [[CategoriasModelo alloc] init_HomeCategoriasControlador:self];
    
    return self;
}


- (void) lleganCategorias:(NSArray*)categoriasNSArray{
    NSLog(@"%s", __FUNCTION__);
    [_menuGeneralUIViewController ocultarCargadorTablaTareas];
    
    NSMutableArray *categoriasConTodasNSMutableArray = [[NSMutableArray alloc] init];
    CategoriaDTO *categoriaDTO = [[CategoriaDTO alloc] init];
    categoriaDTO.idCategoriaInt = -1;
    categoriaDTO.categoriaNombreNSString = @"Todas";
    [categoriasConTodasNSMutableArray addObject:categoriaDTO];
    [categoriasConTodasNSMutableArray addObjectsFromArray:categoriasNSArray];
    
    [_menuGeneralUIViewController cargarCategoriasEnTabla_categoriasNSArray:categoriasConTodasNSMutableArray];
    [_menuGeneralUIViewController seleccionarLaCategoriaTODAS];
}

- (void) tomarCategorias{
    NSLog(@"%s", __FUNCTION__);
    
    [_menuGeneralUIViewController mostrarCargadorTablaTareas];
    [_categoriasModelo tomarCategorias];
}

@end
