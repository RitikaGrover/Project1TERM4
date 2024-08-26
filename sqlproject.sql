use PersonalBudgetDB;


CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each user
    UserName VARCHAR(100) NOT NULL,         -- The user's name
    Email VARCHAR(100) UNIQUE NOT NULL,     -- The user's email address (must be unique)
    Password VARCHAR(100) NOT NULL          -- The user's password (stored as a hashed value ideally)
);
CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each account
    AccountName VARCHAR(100) NOT NULL,         -- The name of the account (e.g., "Savings Account")
    UserID INT,                                -- Foreign key linking to the User table
    Balance DECIMAL(10, 2) DEFAULT 0,          -- Current balance of the account
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- Establishing a relationship with the User table
);

CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each category
    CategoryName VARCHAR(100) NOT NULL          -- Name of the category (e.g., "Salary", "Rent")
);

CREATE TABLE Income (
    IncomeID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each income record
    Amount DECIMAL(10, 2) NOT NULL,           -- The amount of income
    Date DATE NOT NULL,                       -- The date the income was received
    Source VARCHAR(100),                      -- Source of the income (e.g., "Company A")
    AccountID INT,                            -- Foreign key linking to the Account table
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)  -- Establishing a relationship with the Account table
);
CREATE TABLE Expense (
    ExpenseID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each expense record
    Amount DECIMAL(10, 2) NOT NULL,            -- The amount of the expense
    Date DATE NOT NULL,                        -- The date the expense was incurred
    Description VARCHAR(255),                 -- A description of the expense (e.g., "Groceries at Store X")
    CategoryID INT,                           -- Foreign key linking to the Category table
    AccountID INT,                            -- Foreign key linking to the Account table
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),  -- Establishing a relationship with the Category table
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)      -- Establishing a relationship with the Account table
);
CREATE TABLE Budget (
    BudgetID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each budget record
    Amount DECIMAL(10, 2) NOT NULL,           -- The total budget amount for the specified period
    StartDate DATE NOT NULL,                  -- The start date of the budget period
    EndDate DATE NOT NULL,                    -- The end date of the budget period
    UserID INT,                               -- Foreign key linking to the User table
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- Establishing a relationship with the User table
);

CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each transaction
    Amount DECIMAL(10, 2) NOT NULL,                -- The amount involved in the transaction
    Date DATE NOT NULL,                            -- The date of the transaction
    Type ENUM('Income', 'Expense') NOT NULL,       -- The type of transaction: either 'Income' or 'Expense'
    AccountID INT,                                 -- Foreign key linking to the Account table
    CategoryID INT,                                -- Foreign key linking to the Category table (only applicable for expenses)
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),  -- Establishing a relationship with the Account table
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)  -- Establishing a relationship with the Category table
);
-- Insert a user
INSERT INTO User (UserName, Email, Password) VALUES ('John Doe', 'john@example.com', 'password123');

-- Insert a category
INSERT INTO Category (CategoryName) VALUES ('Salary'), ('Rent'), ('Groceries');

-- Insert an account
INSERT INTO Account (AccountName, UserID, Balance) VALUES ('Savings Account', 1, 1000.00);

-- Insert income
INSERT INTO Income (Amount, Date, Source, AccountID) VALUES (2000.00, '2024-08-01', 'Company A', 1);

-- Insert an expense
INSERT INTO Expense (Amount, Date, Description, CategoryID, AccountID) VALUES (500.00, '2024-08-02', 'Rent for August', 2, 1);

-- Insert a budget
INSERT INTO Budget (Amount, StartDate, EndDate, UserID) VALUES (1500.00, '2024-08-01', '2024-08-31', 1);

-- Insert a transaction (if using the Transaction table instead of separate Income/Expense tables)
INSERT INTO Transaction (Amount, Date, Type, AccountID, CategoryID) VALUES (2000.00, '2024-08-01', 'Income', 1, NULL);
INSERT INTO Transaction (Amount, Date, Type, AccountID, CategoryID) VALUES (500.00, '2024-08-02', 'Expense', 1, 2);
SELECT e.ExpenseID, e.Amount, e.Date, e.Description, c.CategoryName
FROM Expense e
JOIN Category c ON e.CategoryID = c.CategoryID
JOIN Account a ON e.AccountID = a.AccountID
JOIN User u ON a.UserID = u.UserID
WHERE u.UserID = 1;

SELECT 
    SUM(CASE WHEN t.Type = 'Income' THEN t.Amount ELSE 0 END) AS TotalIncome,
    SUM(CASE WHEN t.Type = 'Expense' THEN t.Amount ELSE 0 END) AS TotalExpenses
FROM Transaction t
JOIN Account a ON t.AccountID = a.AccountID
JOIN User u ON a.UserID = u.UserID
WHERE u.UserID = 1;
describe account;
-- Insert into User table
INSERT INTO User (UserName, Email, Password) VALUES
('Alice Johnson', 'alice.johnson@example.com', 'password123'),
('Bob Smith', 'bob.smith@example.com', 'password456');

-- Insert into Account table
INSERT INTO Account (AccountName, UserID, Balance) VALUES
('Checking Account', 1, 1500.00),
('Savings Account', 1, 3000.00),
('Credit Card', 2, -500.00);

-- Insert into Category table
INSERT INTO Category (CategoryName) VALUES
('Salary'), ('Utilities'), ('Groceries'), ('Entertainment'), ('Healthcare');

-- Insert into Income table
INSERT INTO Income (Amount, Date, Source, AccountID) VALUES
(3000.00, '2024-08-01', 'Company ABC', 1),
(1500.00, '2024-08-05', 'Freelance Work', 2);

-- Insert into Expense table
INSERT INTO Expense (Amount, Date, Description, CategoryID, AccountID) VALUES
(100.00, '2024-08-02', 'Electric Bill', 2, 1),
(200.00, '2024-08-10', 'Groceries', 3, 1),
(50.00, '2024-08-12', 'Movie Tickets', 4, 1),
(75.00, '2024-08-15', 'Doctor Visit', 5, 2);

-- Insert into Budget table
INSERT INTO Budget (Amount, StartDate, EndDate, UserID) VALUES
(2000.00, '2024-08-01', '2024-08-31', 1),
(500.00, '2024-08-01', '2024-08-31', 2);
-- List tables
SHOW TABLES;

