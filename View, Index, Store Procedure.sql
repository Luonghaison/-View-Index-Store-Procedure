create database ProductDB;
USE ProductDB;
drop database ProductDB;

CREATE TABLE Products (
    Id int primary key auto_increment, 
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(255) NOT NULL,
    productPrice FLOAT NOT NULL,
    productAmount INT NOT NULL,
    productDescription VARCHAR(1000),
    productStatus VARCHAR(50) NOT NULL
);


INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('P001', 'Product 1', 10.99, 100, 'This is product 1', 'Available'),
('P002', 'Product 2', 20.99, 50, 'This is product 2', 'Available'),
('P003', 'Product 3', 5.99, 200, 'This is product 3', 'Out of stock'),
('P004', 'Product 4', 15.99, 75, 'This is product 4', 'Available'),
('P005', 'Product 5', 7.99, 150, 'This is product 5', 'Available');

-- •	Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index IX_Products_productCode on Products(productCode)

-- •	Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
CREATE INDEX IX_Products_productName_productPrice ON Products (productName, productPrice);

-- •	Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';

-- •	Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
CREATE VIEW ProductInfo AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;
SELECT * FROM ProductInfo;

-- •	Tiến hành sửa đổi view
ALTER VIEW ProductInfo AS
SELECT productCode, productName, productPrice, productStatus, productDescription
FROM Products;

-- •	Tiến hành xoá view
DROP VIEW ProductInfo;

-- •	Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END;
// delimiter ;
CALL GetAllProducts;

-- •	Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE AddProduct(IN productCode VARCHAR(50), IN productName VARCHAR(255), IN productPrice DECIMAL(10,2), IN productAmount INT, IN productDescription TEXT, IN productStatus VARCHAR(50))
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (productCode, productName, productPrice, productAmount, productDescription, productStatus);
END;
// delimiter ;
CALL AddProduct('PD005', 'Product 5', 12.50, 150, 'This is product 5', 'In stock');

-- •	Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER //
CREATE PROCEDURE UpdateProduct(IN productId INT, IN productCode VARCHAR(50), IN productName VARCHAR(255), IN productPrice DECIMAL(10,2), IN productAmount INT, IN productDescription TEXT, IN productStatus VARCHAR(50))
BEGIN
    UPDATE Products SET productCode = productCode, productName = productName, productPrice = productPrice, productAmount = productAmount, productDescription = productDescription, productStatus = productStatus
    WHERE Id = productId;
END;
// delimiter ;
CALL UpdateProduct(1, 'PD001', 'Product 1 updated', 15.99, 120, 'This is updated product 1', 'In stock');

-- • Tạo store procedure xoá sản phẩm theo id
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN productId INT)
BEGIN
    DELETE FROM Products WHERE Id = productId;
END;
// delimiter ;
CALL DeleteProduct(2);
