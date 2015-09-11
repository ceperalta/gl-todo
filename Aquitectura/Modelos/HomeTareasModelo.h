//
//  HomeTareasModelo.h
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeTareasControlador.h"
#import "TareaDTO.h"

@class HomeTareasControladorm, TareaDTO;

@interface HomeTareasModelo : NSObject

- (void) tomarTareas;
- (id) init_HomeTareasControlador:(HomeTareasControlador*)homeTareasControlador;
- (void) tomarTareasParaCat_idCatInt:(int)idCatInt;
- (void) eliminarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO;


@end
