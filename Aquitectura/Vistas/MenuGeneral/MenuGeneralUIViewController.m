//
//  MenuGeneralUIViewController.m
//  Aquitectura
//
//  Created by Carlos Peralta on 31/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "MenuGeneralUIViewController.h"
#import "CeldaTablaCategoriasWidgetUITableViewCell.h"
#import "ControladorPrincipalNSObject.h"
#import "CategoriasControlador.h"
#import "CategoriaDTO.h"

@interface MenuGeneralUIViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (retain, nonatomic) ControladorPrincipalNSObject *controladorPrincipalRefNSObject;
@property (assign, nonatomic) BOOL esCargaInicialTodasLasTareasBOOL;


@end

@implementation MenuGeneralUIViewController



- (id)iniciarConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject{
    NSLog(@"%s", __FUNCTION__);
    
    _controladorPrincipalRefNSObject = controladorPrincipalNSObject;
    _categoriasControlador = [[CategoriasControlador alloc] init_MenuGeneralUIViewController:self];
    
    _esCargaInicialTodasLasTareasBOOL = true;
    
    return [self initWithNibName:@"MenuGeneralUIViewController" bundle:nil];
}


- (IBAction)cerrarSesionUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [_delegado cerrarSesionUIButton_presionado];
}

- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    _tablaCategoriasUITableView.delegate = nil;
    _tablaCategoriasUITableView.dataSource = nil;
    _tablaCategoriasUITableView.hidden = true;
    _cargadorUIActivityIndicatorView.hidden = false;

}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"%s", __FUNCTION__);
    //[self seleccionarLaCategoriaTODAS];
}


- (void) seleccionarLaCategoriaTODAS{
    NSLog(@"%s", __FUNCTION__);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_tablaCategoriasUITableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:
     UITableViewScrollPositionTop];
    
    [_tablaCategoriasUITableView.delegate tableView:_tablaCategoriasUITableView didSelectRowAtIndexPath:indexPath];
}


- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
   
}

- (void) mostrarCargadorTablaTareas{
    _cargadorUIActivityIndicatorView.hidden = false;
}

- (void) ocultarCargadorTablaTareas{
    _cargadorUIActivityIndicatorView.hidden = true;
}

- (void) cargarCategoriasEnTabla_categoriasNSArray:(NSArray*)categoriasNSArray{
    NSLog(@"%s", __FUNCTION__);
    _categoriasNSArray = categoriasNSArray;
    
    _tablaCategoriasUITableView.dataSource = self;
    _tablaCategoriasUITableView.delegate = self;
    _tablaCategoriasUITableView.hidden = false;
    
    [_tablaCategoriasUITableView reloadData];
}

#pragma mark -
#pragma mark _tablaCategoriasUITableView-UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%s", __FUNCTION__);
    return _categoriasNSArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __FUNCTION__);
    CeldaTablaCategoriasWidgetUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDCeldaCategorias"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"CeldaTablaCategoriasWidgetUITableViewCell" bundle:nil] forCellReuseIdentifier:@"IDCeldaCategorias"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"IDCeldaCategorias"];
    }
    return cell;
}


#pragma mark -
#pragma mark _tablaCategoriasUITableView-UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(CeldaTablaCategoriasWidgetUITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __FUNCTION__);
   
    CategoriaDTO *categoriaDTO = (CategoriaDTO*)[_categoriasNSArray objectAtIndex:indexPath.row];
    
    cell.textoUILabel.text = categoriaDTO.categoriaNombreNSString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    
    CategoriaDTO *categoriaDTO = (CategoriaDTO*)[_categoriasNSArray objectAtIndex:indexPath.row];
    int idCatSel = categoriaDTO.idCategoriaInt;
    
    if (idCatSel == -1){
        if(!_esCargaInicialTodasLasTareasBOOL) {
            [_controladorPrincipalRefNSObject ocultarMenuSlideAnimando];
            [_controladorPrincipalRefNSObject cargarTodasLasTareas];
        }
    }else{
        _esCargaInicialTodasLasTareasBOOL = false;
        [_controladorPrincipalRefNSObject cargarTareasParaCategoriaSeleccionada_IDCatInt:idCatSel];
    }
    
}

@end
