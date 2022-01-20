CREATE DATABASE productsales;

use productsales;

CREATE TABLE products (
	ProductID varchar(255),
	ProductName varchar(255),
	ProductBCost int,      		-- ProductBuyingCost
	ProductSCost int,			-- ProductSellingCost
    Discount int,
	ProductinStock int
);

CREATE TABLE billing (
		BillingID varchar(255),
    	BillingDateTime varchar(255),
    	BillingTaxNum int,
    	Items int			-- Items used to fetch number of products
);

INSERT INTO products(ProductID,ProductName,ProductBCost,ProductSCost,Discount,ProductinStock)VALUES("P100","Milk",20,20,50,100);

SELECT * FROM products;

