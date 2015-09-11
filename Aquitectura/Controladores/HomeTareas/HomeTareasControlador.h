//
//  HomeTareasControlador.h
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeUIViewController.h"
#import "TareaDTO.h"

@class HomeUIViewController, TareaDTO;

@interface HomeTareasControlador : NSObject

- (id) init_contenedorHomeUIViewController:(HomeUIViewController*)homeUIViewController;
- (void) tomarTareas;
- (void) lleganTareas:(NSArray*)tareasNSDictionary;
- (void) cargarTareasParaIdCat_idCatInt:(int)idCatInt;
- (void) eliminarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO;
- (void) problemasEnEliminacionTarea;
- (void) elimiacionTareaOK;

@end
