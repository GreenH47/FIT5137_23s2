-- Articles table
CREATE TABLE Articles (
    articleCode VARCHAR2(255) PRIMARY KEY,
    articleName VARCHAR2(255) NOT NULL,
    VendorKey VARCHAR2(255) NOT NULL,
    VendorName VARCHAR2(255) NOT NULL,
    categoryInit VARCHAR2(50),
    categoryName VARCHAR2(255),
    TypeInit VARCHAR2(50),
    TypeName VARCHAR2(255) NOT NULL,
    startDate DATE,
    expireDate DATE,
    colourInit VARCHAR2(50),
    colourName VARCHAR2(255),
    sex CHAR(1),
    picture VARCHAR2(255),
    basePrice NUMBER(10, 2),
    salePrice NUMBER(10, 2),
    notes VARCHAR2(255)
);

-- Inventory table
CREATE TABLE Inventory (
    articleCode VARCHAR2(255) NOT NULL,
    barcode VARCHAR2(255) PRIMARY KEY,
    sizes VARCHAR2(255) NOT NULL,
    CurrentBasePrice NUMBER(10, 2),
    CurrentSalePrice NUMBER(10, 2),
    consignment VARCHAR2(255),
    consignmentRp NUMBER(10, 2),
    qty INT NOT NULL,
    status VARCHAR2(50) NOT NULL
);

-- Cashier table
CREATE TABLE Cashier (
    noTrans VARCHAR(255) PRIMARY KEY,
    dateTrans TIMESTAMP(3) NOT NULL,
    typeTrans VARCHAR(255),
    Notes VARCHAR(255),
    UserID VARCHAR(255),
    referenceTrans VARCHAR(255)
);

-- Cashierpayment table
CREATE TABLE Cashierpayment (
    id VARCHAR2(255) PRIMARY KEY,
    noTrans VARCHAR2(255) NOT NULL,
    paidType VARCHAR(255) NOT NULL,
    cardInit VARCHAR(50),
    cardName VARCHAR(255),
    cardNumber VARCHAR(255),
    totalpaid NUMBER(10, 2),
    MachineName VARCHAR(255),
    CompanyCharge NUMBER(10, 2),
    CustomerCharge NUMBER(10, 2),
    ReffNo VARCHAR(255),
    ProgressiveDisc NUMBER(10, 2) NOT NULL
);

-- Cashierdetail table
CREATE TABLE Cashierdetail (
    noTrans VARCHAR2(255) NOT NULL,
    ArticleCode VARCHAR2(255) NOT NULL,
    Barcode VARCHAR(255) NOT NULL,
    sizes VARCHAR(50) NOT NULL,
    qty INT NOT NULL,
    basePrice NUMBER(10, 2),
    salePrice NUMBER(10, 2),
    DiscountType NUMBER(1),
    discountPersen NUMBER(10),
    discountRupiah NUMBER(10, 2),
    DiscExpenses NUMBER(1),
    consignment NUMBER(1),
    consignmentRp NUMBER(10, 2),
    subTotal NUMBER(10, 2),
    payment NUMBER(10, 2),

    PRIMARY KEY (noTrans, Barcode)
);





-- Adding foreign key relationship for Inventory table
ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Articles
FOREIGN KEY (articleCode)
REFERENCES Articles(articleCode);

-- Adding foreign key relationship for Cashierpayment table
ALTER TABLE Cashierpayment
ADD CONSTRAINT FK_Cashierpayment_Cashier
FOREIGN KEY (noTrans)
REFERENCES Cashier(noTrans);

-- Adding foreign key relationships for Cashierdetail table
ALTER TABLE Cashierdetail
ADD CONSTRAINT FK_Cashierdetail_Cashier
FOREIGN KEY (noTrans)
REFERENCES Cashier(noTrans);

ALTER TABLE Cashierdetail
ADD CONSTRAINT FK_Cashierdetail_Articles
FOREIGN KEY (ArticleCode)
REFERENCES Articles(ArticleCode);

ALTER TABLE Cashierdetail
ADD CONSTRAINT FK_Cashierdetail_Inventory
FOREIGN KEY (Barcode)
REFERENCES Inventory(Barcode);
