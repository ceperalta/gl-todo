//
//  InicialUIViewController.m
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "HomeUIViewController.h"
#import "ControladorPrincipalNSObject.h"
#import "CeldaTablaTareasWidget.h"
#import "HomeTareasControlador.h"
#import "TareaDTO.h"


@interface HomeUIViewController () <UITableViewDelegate, UITableViewDataSource, protocoloCeldaTablaTareasWidget>
@property (nonatomic, retain) ControladorPrincipalNSObject *controladorPrincipalRefNSObject;
@property (nonatomic, assign) BOOL menuAbiertoBool;
@property (retain, nonatomic) NSMutableArray *tareasNSMutableArray;
@property (retain, nonatomic) NSIndexPath *indexPathCellABorrarNSIndexPath;
@property (retain, nonatomic) CeldaTablaTareasWidget *celdaEnEliminacionCeldaTablaTareasWidget;
@end

@implementation HomeUIViewController


- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject{
    NSLog(@"%s", __FUNCTION__);
    
    _controladorPrincipalRefNSObject = controladorPrincipalNSObject;
    _homeTareasControlador = [[HomeTareasControlador alloc] init_contenedorHomeUIViewController:self];
    
    return [self initWithNibName:@"HomeVistaNib" bundle:nil];
}

- (void) mostrarCargadorTablaTareas{
     NSLog(@"%s", __FUNCTION__);
    _cargadorTareasUIActivityIndicatorView.hidden = false;
}

- (void) ocultarTablaYMostrarCargador{
    NSLog(@"%s", __FUNCTION__);
 
    _tareasUITableView.hidden = true;
    _cargadorTareasUIActivityIndicatorView.hidden = false;
}

- (void) ocultarCargadorTablaTareas{
     NSLog(@"%s", __FUNCTION__);
    _cargadorTareasUIActivityIndicatorView.hidden = true;
}

- (void) cargarTareasEnTabla_tareasNSMutableArray:(NSMutableArray*)tareasNSMutableArray{
     NSLog(@"%s", __FUNCTION__);
    _tareasNSMutableArray = tareasNSMutableArray;
    
    _tareasUITableView.dataSource = self;
    _tareasUITableView.delegate = self;
    _tareasUITableView.hidden = false;
    
    [_tareasUITableView reloadData];
}


-(void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    _menuAbiertoBool = false;
    _barraNavegacionWidget.delegado = self;
    
    _tareasUITableView.dataSource = nil;
    _tareasUITableView.delegate = nil;
    _tareasUITableView.hidden = true;
    _cargadorTareasUIActivityIndicatorView.hidden = true;
    
}

- (void)dealloc{
   NSLog(@"%s", __FUNCTION__);
}

#pragma mark -
#pragma mark _tablaCategoriasUITableView-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%s", __FUNCTION__);
    return _tareasNSMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __FUNCTION__);
    CeldaTablaTareasWidget *cell = [tableView dequeueReusableCellWithIdentifier:@"IDCeldaTareas"];
    
    cell.delegado = self;
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"CeldaTablaTareasWidget" bundle:nil] forCellReuseIdentifier:@"IDCeldaTareas"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"IDCeldaTareas"];
    
        cell.delegado = self;
    }
    return cell;
}


#pragma mark -
#pragma mark _tablaCategoriasUITableView-UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(CeldaTablaTareasWidget *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __FUNCTION__);
    
    TareaDTO *tareaDTO = (TareaDTO*)[_tareasNSMutableArray objectAtIndex:indexPath.row];
    
    NSLog(@"willDisplayCellentrega tarea: %@ ", tareaDTO.tareaNSString);
    
    cell.tareaUILabel.text = tareaDTO.tareaNSString;
    cell.categoriaUILabel.text = tareaDTO.categoriaNSString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}


#pragma mark -
#pragma mark BarraNavegacionWidgetProtocol

- (void) btnNuevaTareaPresionado{
    [_controladorPrincipalRefNSObject mostrarVistaNuevaTarea];
}

- (void) btnMenuPresionado{
    NSLog(@"%s", __FUNCTION__);
    [self.delegado cambiarEstadoMenu];
}

#pragma mark -
#pragma mark protocoloCeldaTablaTareasWidget

- (void) btnEliminarPresionado_celdaCeldaTablaTareasWidget:(CeldaTablaTareasWidget *)celdaCeldaTablaTareasWidget{
    NSLog(@"%s", __FUNCTION__);
    
    _celdaEnEliminacionCeldaTablaTareasWidget = celdaCeldaTablaTareasWidget;
    
    _indexPathCellABorrarNSIndexPath = [_tareasUITableView indexPathForCell:celdaCeldaTablaTareasWidget];
    
    celdaCeldaTablaTareasWidget.btnEliminarUIButton.hidden = true;
    [celdaCeldaTablaTareasWidget.cargadorSobreEliminarUIActivityIndicatorView startAnimating];
    celdaCeldaTablaTareasWidget.cargadorSobreEliminarUIActivityIndicatorView.hidden = false;

    [_homeTareasControlador eliminarTarea_tareaTareaDTO:[_tareasNSMutableArray objectAtIndex:_indexPathCellABorrarNSIndexPath.row]];
}


- (void) eliminarCeldaConAnimacion{
    NSLog(@"%s", __FUNCTION__);
    
    [_tareasNSMutableArray removeObjectAtIndex:_indexPathCellABorrarNSIndexPath.row];
    
    NSArray *idPathCellAEliminarNSArray = [[NSArray alloc] initWithObjects: _indexPathCellABorrarNSIndexPath, nil];
    
    [_tareasUITableView beginUpdates];
    [_tareasUITableView deleteRowsAtIndexPaths:idPathCellAEliminarNSArray withRowAnimation:UITableViewRowAnimationFade];
    [_tareasUITableView endUpdates];
    
    //TODO: falta hacerlo al terminar animación
    // se debe volver ya que afecta a cell que no han sido eliminadas
    [self ocultarCargadorEliminaTareaYVolverBtnEliminar];
}

- (void) ocultarCargadorEliminaTareaYVolverBtnEliminar{
    NSLog(@"%s", __FUNCTION__);
    [_celdaEnEliminacionCeldaTablaTareasWidget.cargadorSobreEliminarUIActivityIndicatorView stopAnimating];
    _celdaEnEliminacionCeldaTablaTareasWidget.cargadorSobreEliminarUIActivityIndicatorView.hidden = true;
    _celdaEnEliminacionCeldaTablaTareasWidget.btnEliminarUIButton.hidden = false;
}

@end
