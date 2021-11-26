-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'comments'
CREATE TABLE comments (
    CommentID int generated always as identity (start with  1 increment by 1),
    CommentProductID int  NULL,
    CommentUserID int  NULL,
    Comment1 varchar(1000)  NULL
);

-- Creating table 'orderdetails'
CREATE TABLE orderdetails (
    DetailsID int generated always as identity (start with  1 increment by 1),
    DetailsOrderID int  NULL,
    DetailsProductID int  NULL
);

-- Creating table 'orders'
CREATE TABLE orders (
    OrderID int generated always as identity (start with  1 increment by 1),
    OrderUserID int  NULL,
    OrderCountry varchar(20)  NULL,
    OrderCity varchar(50)  NULL,
    OrderAddress varchar(50)  NULL,
    OrderStatus char(6)  NULL,
    OrderDate date  NULL,
    OrderTrackingNumber varchar(30)  NULL,
    OrderAmount float  NULL
);

-- Creating table 'productcategories'
CREATE TABLE productcategories (
    CategoryID int generated always as identity (start with  1 increment by 1),
    CategoryName varchar(50)  NULL,
    CategoryImage BLOB  NULL
);

-- Creating table 'products'
CREATE TABLE products (
    ProductID int generated always as identity (start with  1 increment by 1),
    ProductCategory int  NULL,
    ProductSubcategory int  NULL,
    ProductName varchar(50)  NULL,
    ProductWeight int  NULL,
    ProductShortDesc nvarchar2(200)  NULL,
    ProductThumb blob  NULL,
    ProductImage blob  NULL,
    ProductStock int  NULL,
    ProductPrice float  NULL
);

-- Creating table 'productsubcategories'
CREATE TABLE productsubcategories (
    SubcategoryID int generated always as identity (start with  1 increment by 1),
    SubcategoryCategoryID int  NULL,
    SubcategoryName varchar(50)  NULL
);

-- Creating table 'users'
CREATE TABLE users (
    UserID int generated always as identity (start with  1 increment by 1),
    UserEmail varchar(100)  NULL,
    UserPassword varchar(30)  NULL,
    UserFirstName varchar(50)  NULL,
    UserLastName varchar(50)  NULL,
    UserMiddleNAme varchar(50)  NULL,
    UserRegistrationDate date  NULL,
    UserCountry varchar(20)  NULL,
    UserCity varchar(50)  NULL,
    UserAddress varchar(50)  NULL,
    UserZip decimal(6,0)  NULL,
    UserPhone decimal(14,0)  NULL,
    Role int  NULL
);

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CommentID] in table 'comments'
ALTER TABLE comments
ADD CONSTRAINT PK_comments
    PRIMARY KEY (CommentID);

-- Creating primary key on [DetailsID] in table 'orderdetails'
ALTER TABLE orderdetails
ADD CONSTRAINT PK_orderdetails
    PRIMARY KEY (DetailsID);

-- Creating primary key on [OrderID] in table 'orders'
ALTER TABLE orders
ADD CONSTRAINT PK_orders
    PRIMARY KEY (OrderID);

-- Creating primary key on [CategoryID] in table 'productcategories'
ALTER TABLE productcategories
ADD CONSTRAINT PK_productcategories
    PRIMARY KEY  (CategoryID);

-- Creating primary key on [ProductID] in table 'products'
ALTER TABLE products
ADD CONSTRAINT PK_products
    PRIMARY KEY  (ProductID);

-- Creating primary key on [SubcategoryID] in table 'productsubcategories'
ALTER TABLE productsubcategories
ADD CONSTRAINT PK_productsubcategories
    PRIMARY KEY (SubcategoryID);

-- Creating primary key on [UserID] in table 'users'
ALTER TABLE users
ADD CONSTRAINT PK_users
    PRIMARY KEY (UserID);

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CommentProductID] in table 'comments'
ALTER TABLE comments
ADD CONSTRAINT FK_CommentProductPK
    FOREIGN KEY (CommentProductID)
    REFERENCES products
        (ProductID);

-- Creating non-clustered index for FOREIGN KEY 'FK_CommentProductPK'
CREATE INDEX IX_FK_CommentProductPK
ON comments
    (CommentProductID);

-- Creating foreign key on [DetailsOrderID] in table 'orderdetails'
ALTER TABLE orderdetails
ADD CONSTRAINT FK_DetailsOrderFK
    FOREIGN KEY (DetailsOrderID)
    REFERENCES orders
        (OrderID);

-- Creating non-clustered index for FOREIGN KEY 'FK_DetailsOrderFK'
CREATE INDEX IX_FK_DetailsOrderFK
ON orderdetails
    (DetailsOrderID);

-- Creating foreign key on [DetailsProductID] in table 'orderdetails'
ALTER TABLE orderdetails
ADD CONSTRAINT FK_DetailsProductFK
    FOREIGN KEY (DetailsProductID)
    REFERENCES products
        (ProductID);

-- Creating non-clustered index for FOREIGN KEY 'FK_DetailsProductFK'
CREATE INDEX IX_FK_DetailsProductFK
ON orderdetails
    (DetailsProductID);

-- Creating foreign key on OrderUserID in table 'orders'
ALTER TABLE orders
ADD CONSTRAINT FK_OrdersUsersFK
    FOREIGN KEY (OrderUserID)
    REFERENCES users
        (UserID);

-- Creating non-clustered index for FOREIGN KEY 'FK_OrdersUsersFK'
CREATE INDEX IX_FK_OrdersUsersFK
ON orders
    (OrderUserID);

-- Creating foreign key on [ProductCategory] in table 'products'
ALTER TABLE products
ADD CONSTRAINT FK_ProductCategoriesFK
    FOREIGN KEY (ProductCategory)
    REFERENCES productcategories
        (CategoryID);

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductCategoriesFK'
CREATE INDEX IX_FK_ProductCategoriesFK
ON products
    (ProductCategory);

-- Creating foreign key on [SubcategoryCategoryID] in table 'productsubcategories'
ALTER TABLE productsubcategories
ADD CONSTRAINT FK_SubCategoryFK
    FOREIGN KEY (SubcategoryCategoryID)
    REFERENCES productcategories
        (CategoryID);

-- Creating non-clustered index for FOREIGN KEY 'FK_SubCategoryFK'
CREATE INDEX IX_FK_SubCategoryFK
ON productsubcategories
    (SubcategoryCategoryID);

-- Creating foreign key on [ProductSubcategory] in table 'products'
ALTER TABLE products
ADD CONSTRAINT FK_ProductSubcategoriesFK
    FOREIGN KEY (ProductSubcategory)
    REFERENCES productsubcategories
        (SubcategoryID);

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductSubcategoriesFK'
CREATE INDEX IX_FK_ProductSubcategoriesFK
ON products
    (ProductSubcategory);

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------