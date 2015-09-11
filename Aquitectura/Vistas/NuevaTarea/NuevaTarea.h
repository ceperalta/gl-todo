//
//  NuevaTarea.h
//  Aquitectura
//
//  Created by Carlos Peralta on 8/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "CategoriaDTO.h"
#import "TareaDTO.h"

@class ControladorPrincipalNSObject, CategoriaDTO, TareaDTO;

@interface NuevaTarea : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nuevaTareaUITextField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoriaUIPickerView;
@property (weak, nonatomic) IBOutlet UITextField *nuevaCategoriaUITextField;
@property (weak, nonatomic) IBOutlet UIButton *agregarNuevaTareaUIButton;

@property (nonatomic, assign) BOOL nuevaTareaTieneCategoriaNuevaBOOL;
@property (retain, nonatomic) CategoriaDTO *categoriaNuevaCategoriaDTO;
@property (retain, nonatomic) TareaDTO *tareaNuevaTareaDTO;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargardorSobreAgregarUIActivityIndicatorView;

- (id)iniciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject categoriasNSArray:(NSArray*)categoriasNSArray;

- (void) bloquearComponentesYMostrarCargadorSobreBtnAgregar;

- (void) cerrarYRecargarTareasMasCategorias;

@end
