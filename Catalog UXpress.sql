-- Active: 1792076078144@@127.0.0.1@3306@catalog_uxpress@almacen3a
-- CREACION DE LA BD 
CREATE DATABASE catalog_uxpress

-- Seleccionar la base de datos para crear su estructura 
USE catalog_uxpress;

-- Crear la tabla SUCURSAL
CREATE TABLE sucursal(
    codigoSucursal VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    dirCalle VARCHAR(30) NOT NULL,
    dirNumero VARCHAR(30) NOT NULL,
    dirColonia VARCHAR(30) NOT NULL
);

-- Crear la tabla ESTADO_ENTREGA
CREATE TABLE estado_entrega(
    codigo VARCHAR(5) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Crear la tabla ESTADO_PEDIDO
CREATE TABLE estado_pedido(
    codigo VARCHAR(5) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Crear la tabla REPARTIDOR
CREATE TABLE repartidor(
    numeroRepartidor INT PRIMARY KEY AUTO_INCREMENT,
    nombrePila VARCHAR(40) NOT NULL,
    primerApell VARCHAR(30) NOT NULL,
    segundoApell VARCHAR(30),
    dirCalle VARCHAR(100) NOT NULL,
    dirNumero VARCHAR(80) NOT NULL,
    dirColonia VARCHAR(20) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- Crear la tabla CLIENTE
CREATE TABLE cliente(
    numCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombrePila VARCHAR(40) NOT NULL,
    primerApell VARCHAR(30) NOT NULL,
    segundoApell VARCHAR(30)
); 

-- Crear la tabla DIRECCION
CREATE TABLE direccion(
    numDireccion INT PRIMARY KEY AUTO_INCREMENT,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(80) NOT NULL,
    colonia VARCHAR(20) NOT NULL,
    cliente INT NOT NULL,
    FOREIGN KEY (cliente) REFERENCES cliente(numCliente)
);

-- Crear la tabla VENDEDOR 
CREATE TABLE vendedor(
    numEmpleado INT PRIMARY KEY AUTO_INCREMENT,
    nombrePila VARCHAR(40) NOT NULL,
    primerApell VARCHAR(30) NOT NULL,
    segundoApell VARCHAR(30),
    dirCalle VARCHAR(100) NOT NULL,
    dirNumero VARCHAR(80) NOT NULL,
    dirColonia VARCHAR(20) NOT NULL,
    sucursal VARCHAR(5) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (sucursal) REFERENCES sucursal(codigoSucursal)
);

-- Crear la tabla CATALOGO
CREATE TABLE catalogo(
    numCatalogo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    vigenciaInicio DATE NOT NULL,
    vigenciaFin DATE NOT NULL,
    sucursal VARCHAR(5) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (sucursal) REFERENCES sucursal(codigoSucursal)
);

-- Crear la tabla ENTREGA
CREATE TABLE entrega(
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    fechaEntrega DATE NOT NULL,
    entregaConfirmada BOOLEAN NOT NULL DEFAULT FALSE,
    estadoEntrega VARCHAR(5) NOT NULL,
    sucursal VARCHAR(5) NOT NULL,
    repartidor INT NOT NULL,
    direccion INT NOT NULL,
    FOREIGN KEY (estadoEntrega) REFERENCES estado_entrega(codigo),
    FOREIGN KEY (sucursal) REFERENCES sucursal(codigoSucursal),
    FOREIGN KEY (repartidor) REFERENCES repartidor(numeroRepartidor),
    FOREIGN KEY (direccion) REFERENCES direccion(numDireccion)
);

-- Crear la tabla PRODUCTO
CREATE TABLE producto(
    SKU VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
);

-- Crear la tabla PEDIDO
CREATE TABLE pedido(
    numPedido INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    cantArticulos INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    IVA DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    catalogo INT NOT NULL,
    vendedor INT NOT NULL,
    estadoPedido VARCHAR(5) NOT NULL,
    entrega INT,
    cliente INT NOT NULL,
    FOREIGN KEY (catalogo) REFERENCES catalogo(numCatalogo),
    FOREIGN KEY (vendedor) REFERENCES vendedor(numEmpleado),
    FOREIGN KEY (estadoPedido) REFERENCES estado_pedido(codigo),
    FOREIGN KEY (entrega) REFERENCES entrega(codigo),
    FOREIGN KEY (cliente) REFERENCES cliente(numCliente)
);

-- Crear la tabla PAGO
CREATE TABLE pago(
    numTransaccion INT PRIMARY KEY AUTO_INCREMENT,
    concepto VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    numPago INT NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL,
    pedido INT NOT NULL,
    cliente INT NOT NULL,
    FOREIGN KEY (pedido) REFERENCES pedido(numPedido),
    FOREIGN KEY (cliente) REFERENCES cliente(numCliente)
);

-- Crear la tabla CAT_PROD
CREATE TABLE cat_prod(
    catalogo INT NOT NULL,
    producto VARCHAR(20) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (catalogo, producto),
    FOREIGN KEY (catalogo) REFERENCES catalogo(numCatalogo),
    FOREIGN KEY (producto) REFERENCES producto(SKU)
);

-- Crear la tabla STOCK
CREATE TABLE stock(
    sucursal VARCHAR(5) NOT NULL, 
    producto VARCHAR(20) NOT NULL,
    cantStock int NOT NULL DEFAULT 0,
    PRIMARY KEY(sucursal,producto),
    FOREIGN KEY (sucursal) REFERENCES sucursal(codigoSucursal),
    FOREIGN KEY (producto) REFERENCES producto(SKU)
);

-- Crear la tabla PED_PROD
CREATE TABLE ped_prod(
    pedido INT NOT NULL,
    producto VARCHAR(20) NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10, 2) NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (pedido, producto),
    FOREIGN KEY (pedido) REFERENCES pedido(numPedido),
    FOREIGN KEY (producto) REFERENCES producto(SKU)
);


-- Crear la tabla TEL_CLIENTE
CREATE TABLE tel_cliente(
    cliente INT NOT NULL,
    numTel VARCHAR(15) NOT NULL,
    PRIMARY KEY (cliente, numTel),
    FOREIGN KEY (cliente) REFERENCES cliente(numCliente)
);

-- Crear la tabla TEL_VENDEDOR
CREATE TABLE tel_vendedor(
    vendedor INT NOT NULL,
    numTel VARCHAR(15) NOT NULL,
    PRIMARY KEY (vendedor, numTel),
    FOREIGN KEY (vendedor) REFERENCES vendedor(numEmpleado)
);

-- Crear la tabla TEL_REPARTIDOR
CREATE TABLE tel_repartidor(
    repartidor INT NOT NULL,
    numTel VARCHAR(15) NOT NULL,
    PRIMARY KEY (repartidor, numTel),
    FOREIGN KEY (repartidor) REFERENCES repartidor(numeroRepartidor)
);

