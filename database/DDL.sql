SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
-- Project Step 3 Draft
-- Aileen Tang and Jennifer Hoang
--
-- Host: mysql.eecs.oregonstate.edu    Database: `cs340_hoangje`

-- !!!!!!IMPORTANT!!!!!!!
-- Make sure you UNCHECK 'Enable foreign key checks' if you are copying and pasting the SQL into phpMyAdmin. 
-- If you don't, it won't import properly! 
-- phpMyAdmin doesn't like creating the foreign key constraints at the same time as the table. 
-- If you `source DDL.sql` from CLI it works fine.

--
-- Table structure for table `Users`
--

CREATE OR REPLACE TABLE Users(
    userID INT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL, 
    email VARCHAR(50),
    constraint UNIQUE(userID),
    PRIMARY KEY (userID)
);

--
-- Dumping data for table `Users`
--

INSERT INTO Users (name, email) VALUES 
    ("Momo", "babygirlmomo@gmail.com"),
    ("Aileen", "tangai@oregonstate.edu"),
    ("Catherine", "catherine@hello.com"),
    ("Jennifer", NULL);

--
-- Table structure for table `Tasks`
--

CREATE OR REPLACE TABLE Tasks(
    taskID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline DATETIME(0) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    constraint UNIQUE(taskID),
    PRIMARY KEY (taskID)
);

--
-- Dumping data for table `Tasks`
--

INSERT INTO Tasks (userID, name, description, deadline, priorityLevel) VALUES 
    (2, "Project Draft 1", "Step 1 draft", "2023-03-07 11:59:59", "Low"),
    (2, "Quiz 1", "Relational DB and design", "2023-03-13 11:59:59", "Medium"),
    (1, "Beach Walk", "Get some sandy paws", "2023-03-20 11:59:59", "Low"),
    (3, "Chase Sapphire Bill", "Pay credit card bill", "2023-02-15 11:59:59", NULL);
--
-- Table structure for table `Categories`
--

CREATE OR REPLACE TABLE Categories(
    categoryID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    constraint UNIQUE(categoryID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    PRIMARY KEY (categoryID)
);

--
-- Dumping data for table `Categories`
--

INSERT INTO Categories (userID, name, description) VALUES 
    (2, "project", "Group project for class"), 
    (2, "quiz", "Graded quizzes"), 
    (3, "finance", "Financial management"),
    (1, "events", NULL);

--
-- Table structure for table `Subtasks`
--

CREATE OR REPLACE TABLE Subtasks(
    subtaskID INT(20) NOT NULL AUTO_INCREMENT,
    taskID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline DATETIME(0) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    constraint UNIQUE(subtaskID),
    PRIMARY KEY (subtaskID)
);

--
-- Dumping data for table `Subtasks`
--
INSERT INTO Subtasks (taskID, name, description, priorityLevel, deadline) VALUES 
    (2, "Read module 1", NULL, "Medium", "2023-03-05 11:59:59"), 
    (4, "Check statement", "Make sure purchases are correct", NULL, "2023-02-10 11:59:59"),  
    (2, "Read module 2", NULL, NULL, "2023-03-06 11:59:59");


--
-- Table structure for table `Teammates`
--

CREATE OR REPLACE TABLE Teammates(
    teammateID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(12),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    constraint UNIQUE(teammateID),
    PRIMARY KEY (teammateID)
);

--
-- Dumping data for table `Teammates`
--

INSERT INTO Teammates (userID, name, email, phone) VALUES 
    (4, "Jacob", "jacob@gmail.com", "3104356709"), 
    (2, "John", "john@gmail.com", "6267809120"), 
    (3, "Ashley", "ashley@gmail.com", "6577083415");

--
-- Table structure for table `TaskAndTeammates`
--

CREATE OR REPLACE TABLE TaskAndTeammates(
    taskID int,
    teammateID int,
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, teammateID)
);

--
-- Dumping data for table `TaskAndTeammates`
--

INSERT INTO TaskAndTeammates (taskID, teammateID) VALUES 
    (1, 2), 
    (2, 2), 
    (2, 3);

--
-- Table structure for table `SubtaskAndTeammates`
--

CREATE OR REPLACE TABLE SubtaskAndTeammates(
    subtaskID int,
    teammateID int,
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, teammateID)
);

--
-- Dumping data for table `SubtaskAndTeammates`
--

INSERT INTO SubtaskAndTeammates (subtaskID, teammateID) VALUES 
    (1, 3), 
    (3, 3), 
    (3, 2);

--
-- Table structure for table `TaskAndCategories`
--

CREATE OR REPLACE TABLE TaskAndCategories(
    taskID int,
    categoryID int,
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, categoryID)
);

--
-- Dumping data for table `TaskAndCategories`
--

INSERT INTO TaskAndCategories (taskID, categoryID) VALUES 
    (1, 1), 
    (2, 2), 
    (3, 4), 
    (4, 3);

--
-- Table structure for table `SubtaskAndCategories`
--

CREATE OR REPLACE TABLE SubtaskAndCategories(
    subtaskID int,
    categoryID int,
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, categoryID)
);

--
-- Dumping data for table `SubtaskAndCategories`
--

INSERT INTO SubtaskAndCategories ( subtaskID, categoryID ) VALUES 
    (1, 1), 
    (2, 4), 
    (3, 1);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;