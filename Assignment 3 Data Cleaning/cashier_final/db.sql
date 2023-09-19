drop table Articles CASCADE CONSTRAINTS;
CREATE TABLE Articles (
    articleCode VARCHAR2(255) PRIMARY KEY,
    articleName VARCHAR2(255) NOT NULL,
    VendorKey VARCHAR2(255)NOT NULL,
    VendorName VARCHAR2(255)NOT NULL,
    categoryInit VARCHAR2(50),
    categoryName VARCHAR2(255),
    TypeInit VARCHAR2(50),
    TypeName VARCHAR2(255)NOT NULL,
    startDate DATE,
    expireDate DATE,
    colourInit VARCHAR2(50),
    colourName VARCHAR2(255),
    sex CHAR(1), -- Assuming 'M', 'F', 'U'. for sex
    picture VARCHAR2(255), 
    basePrice NUMBER(10,2),
    salePrice NUMBER(10,2),
    notes VARCHAR2(255)
);

select * from articles;
SELECT COUNT(*) FROM articles;


drop table Inventory CASCADE CONSTRAINTS;
CREATE TABLE Inventory (
    articleCode VARCHAR2(255) NOT NULL,     -- Not null constraint
    barcode VARCHAR2(255) PRIMARY KEY,      -- Primary Key
    sizes VARCHAR2(255) NOT NULL,           -- Not null constraint
    CurrentBasePrice NUMBER(10,2),
    CurrentSalePrice NUMBER(10,2),
    consignment VARCHAR2(255),
    consignmentRp NUMBER(10,2),
    qty INT NOT NULL,                      -- Not null constraint
    status VARCHAR2(50) NOT NULL,           -- Not null constraint
    FOREIGN KEY (articleCode) REFERENCES Articles(articleCode)  -- Foreign Key constraint
);

drop table Cashier CASCADE CONSTRAINTS;
CREATE TABLE Cashier (
    noTrans VARCHAR(255) PRIMARY KEY,  -- Primary Key
    dateTrans TIMESTAMP(3) NOT NULL,   -- Not null constraint
    typeTrans VARCHAR(255),
    Notes VARCHAR(255),
    UserID VARCHAR(255),
    referenceTrans VARCHAR(255)
);


drop table cashierpayment CASCADE CONSTRAINTS;
CREATE TABLE cashierpayment (
    id VARCHAR2(255) PRIMARY KEY,                 -- Primary Key
    noTrans VARCHAR2(255) NOT NULL,               -- Not null constraint
    paidType VARCHAR(255) NOT NULL,     -- Not null constraint
    cardInit VARCHAR(50),
    cardName VARCHAR(255),
    cardNumber VARCHAR(255),
    totalpaid NUMBER(10,2),
    MachineName VARCHAR(255),
    CompanyCharge NUMBER(10,2),
    CustomerCharge NUMBER(10,2),
    ReffNo VARCHAR(255),
    ProgressiveDisc NUMBER(10,2) NOT NULL,  -- Not null constraint
    FOREIGN KEY (noTrans) REFERENCES Cashier(noTrans)  -- Foreign Key constraint
);


drop table cashierdetail CASCADE CONSTRAINTS;
CREATE TABLE cashierdetail (
    noTrans VARCHAR2(255) NOT NULL,
    ArticleCode VARCHAR2(255) NOT NULL,
    Barcode VARCHAR(255) NOT NULL,
    sizes VARCHAR(50) NOT NULL,
    qty INT NOT NULL,
    basePrice NUMBER(10,2),
    salePrice NUMBER(10,2),
    DiscountType NUMBER(1),
    discountPersen NUMBER(10),
    discountRupiah NUMBER(10,2),
    DiscExpenses NUMBER(1),
    consignment NUMBER(1),
    consignmentRp NUMBER(10,2),
    subTotal NUMBER(10,2),
    payment NUMBER(10,2),

    PRIMARY KEY (noTrans, Barcode),
    FOREIGN KEY (noTrans) REFERENCES Cashier(noTrans),
    FOREIGN KEY (ArticleCode) REFERENCES Articles(ArticleCode),
    FOREIGN KEY (Barcode) REFERENCES Inventory(Barcode)
);



