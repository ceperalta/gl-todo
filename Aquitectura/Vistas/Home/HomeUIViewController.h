//
//  InicialUIViewController.h
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "BarraNavegacionWidget.h"
#import "HomeTareasControlador.h"
#import "TareaDTO.h"

@class HomeTareasControlador;

@protocol HomeUIViewControllerProtocol <NSObject>
@required
- (void) cambiarEstadoMenu;
@end

@interface HomeUIViewController : UIViewController <BarraNavegacionWidgetProtocol>

@property (weak, nonatomic) IBOutlet BarraNavegacionWidget *barraNavegacionWidget;
@property (weak, nonatomic) id<HomeUIViewControllerProtocol>delegado;

@property (weak, nonatomic) IBOutlet UITableView *tareasUITableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargadorTareasUIActivityIndicatorView;

@property (nonatomic, retain) HomeTareasControlador *homeTareasControlador;




- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject;

- (void) ocultarTablaYMostrarCargador;
- (void) mostrarCargadorTablaTareas;
- (void) ocultarCargadorTablaTareas;
- (void) cargarTareasEnTabla_tareasNSMutableArray:(NSMutableArray*)tareasNSMutableArray;
- (void) ocultarCargadorEliminaTareaYVolverBtnEliminar;
- (void) eliminarCeldaConAnimacion;

@end

