CREATE DATABASE Student_CourseDB;
SHOW DATABASES;
USE Student_CourseDB;
-- SHOW TABLES;
DROP TABLE Department;
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) UNIQUE NOT NULL
);

-- DROP TABLE Student;
CREATE TABLE Student (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN (
								  'Male',
								  'Female',
								  'Other'
								)),
	Date_of_birth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    RegistrationDate DATE DEFAULT (CURRENT_DATE()),
	DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- DROP TABLE Course;
CREATE TABLE Course (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseTitle VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
	DepartmentID INT REFERENCES Department(DepartmentID) 
);

-- DROP TABLE Instructor;
CREATE TABLE Instructor (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	Gender VARCHAR(10) NOT NULL CHECK (Gender IN (
								  'Male',
								  'Female',
								  'Other'
								)),
	DepartmentID INT REFERENCES Department(DepartmentID)
    );
    
-- Enrollment Table (Student-Course junction)
-- DROP TABLE CourseStudent;
CREATE TABLE CourseStudent (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Grade VARCHAR(2),
    PRIMARY KEY(StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE
);

-- CourseInstructor Table (Course-Instructor junction)
-- DROP TABLE CourseInstructor;
CREATE TABLE CourseInstructor (
    CourseID INT NOT NULL,
    InstructorID INT NOT NULL,
    PRIMARY KEY (CourseID, InstructorID), --  composite primary key 
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) ON DELETE CASCADE
);

-- Insert values into Department
INSERT INTO Department (DepartmentName) VALUES 
('Computer Science'),
('Information Technology'),
('Accounting');

-- Insert Students for the given Department
INSERT INTO Student (FirstName, LastName, Gender,Date_of_birth, Email, RegistrationDate, DepartmentID) VALUES
('Milkomi', 'Daniel', 'Male','2022-01-12','milkomi.daniel@xyz.com', '2023-09-01', 1),
('Titi', 'Daniel', 'Female','2010-01-12','titi.daniel@xyz.com', '2023-09-02', 1),
('Luke', 'Smith', 'Male','2010-09-23','lukesmith@xyz.com', '2023-09-24', 2),
('Nimo', 'Kenesa', 'Male','2011-12-12','nimoken@xyz.com', '2023-09-01', 2),
('Abdi', 'Chala', 'Male','2000-11-05','abdi_chala@xyz.com', '2023-09-18', 3),
('Aster', 'Dawit', 'Female','2010-08-17','asterda@xyz.com', '2023-09-01', 3);

-- Insert into Course
INSERT INTO Course (CourseTitle, Credits, DepartmentID) VALUES
('Introduction to Programming', 4, 1),
('Database Systems', 3, 1),
('Priciples of Accounting', 3,3),
('Python', 3,2),
('Software Engineering', 4,1),
('Fundamentals of Marketing', 3,3);

-- Insert into Instructor
INSERT INTO Instructor (FirstName, LastName, Gender, DepartmentID)
VALUES
  ('Lami', 'Guta', 'Male',1),     
  ('Sifan', 'Daniel','Female', 1),    
  ('Fufa', 'Daba', 'Male', 2),       
  ('Tola' , 'Boka','Male', 2);      
  
-- Insert into CourseStudent
INSERT INTO CourseStudent (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'),  
(1, 2, 'B'),  
(2, 4, 'A'),  
(2, 2, 'B'),  
(3, 4, 'C'),  
(4, 4, 'A'),  
(5, 3, 'A'),
(6, 3, 'A'); 

-- Insert into CourseInstructor what to teach
 INSERT INTO CourseInstructor(CourseID, InstructorID) VALUES
(1, 1),  
(1, 2),  
(2, 2),  
(2, 1),  
(4, 3); 

-- QUERIES
-- 1.  Show students with their department names
SELECT 
    FirstName, LastName, Gender, DepartmentName
FROM 
    Student s
JOIN 
    Department d ON s.DepartmentID = d.DepartmentID;

-- 2.  Show instructors with their department names
SELECT 
    FirstName, LastName, Gender, DepartmentName
FROM 
    Instructor i
JOIN 
    Department d ON i.DepartmentID = d.DepartmentID;
  
  -- 3.  Show courses a student takese 
  SELECT FirstName, LastName, DepartmentName 
  FROM
    Student s
  JOIN
    Department d On s.DepartmentID = d.DepartmentID;
    
-- 4.  Show Female Students from CS dept
  SELECT FirstName, LastName, Gender, DepartmentName 
  FROM
     Student s
  JOIN
    Department d On s.DepartmentID = d.DepartmentID
    WHERE s.Gender="Female" AND d.DepartmentName = "Computer Science";