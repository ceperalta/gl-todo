//
//  ControladorPrincipalNSObject.h
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CategoriasControlador.h"

@class CategoriasControlador;

@interface ControladorPrincipalNSObject : NSObject

@property (retain, nonatomic) CategoriasControlador *categoriasControlador;

- (void) iniciar;
- (void) cargarHome;
- (void) volverPrimerVista_desdeUIViewController:(UIViewController*)desdeUIViewController;
- (void) mostrarActivityIndicator_msg:(NSString*)msgNSString;
- (void) mostrarAlerta_msg:(NSString*)msgNSString;
- (void) ocultarActivityIndicator;
- (void) ocultarTeclado;
- (void) cargarTareasParaCategoriaSeleccionada_IDCatInt:(int)IDCatInt;
- (void) cargarTodasLasTareas;
- (void) ocultarMenuSlideAnimando;
- (void) mostrarVistaNuevaTarea;
- (void) cerrarVistaNuevaTarea;
- (void) cerrarYRecargarTareasMasCategorias;

@end
