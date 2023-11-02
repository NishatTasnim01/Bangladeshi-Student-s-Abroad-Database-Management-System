-- Create the database
USE master;
GO
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Bangladeshi_Scholars_Abroad')
    DROP DATABASE Bangladeshi_Scholars_Abroad;
CREATE DATABASE Bangladeshi_Scholars_Abroad;
GO

-- Use the database
USE Bangladeshi_Scholars_Abroad;
GO

-- Create the Student table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Gender VARCHAR(10),
    Address VARCHAR(255),
    Email VARCHAR(100),
    Passport_ID VARCHAR(20)
);
GO

-- Create the Academic Profile table
CREATE TABLE Academic_Profile (
    Program_Name VARCHAR(100),
    Year_Accomplished VARCHAR(10),
    Grade VARCHAR(5),
    Student_ID INT,
    CONSTRAINT PK_Academic_Profile PRIMARY KEY (Program_Name, Student_ID),
    CONSTRAINT FK_Student_AcademicProfile FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);
GO

-- Create the Extra-Curricular Activity table
CREATE TABLE Extra_Curricular_Activity (
    Activity_ID INT PRIMARY KEY,
    Activity_Name VARCHAR(100)
);
GO

-- Create the Achieves_Activity table (Many-to-Many Relationship)
CREATE TABLE Achieves_Activity (
    Student_ID INT,
    Activity_ID INT,
    CONSTRAINT PK_Achieves PRIMARY KEY (Student_ID, Activity_ID),
    CONSTRAINT FK_Student_Achieves FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT FK_Activity_Achieves FOREIGN KEY (Activity_ID) REFERENCES Extra_Curricular_Activity(Activity_ID)
);
GO

-- Create the International Exam table
CREATE TABLE International_Exam (
    Exam_ID INT PRIMARY KEY,
    Exam_Name VARCHAR(100),
    Exam_Year VARCHAR(10),
    Score VARCHAR(10)
);
GO

-- Create the Give_I_Exam table (Many-to-Many Relationship)
CREATE TABLE Give_I_Exam (
    Student_ID INT,
    Exam_ID INT,
    CONSTRAINT PK_GiveExam PRIMARY KEY (Student_ID, Exam_ID),
    CONSTRAINT FK_Student_GiveIExam FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT FK_Exam_GiveIExam FOREIGN KEY (Exam_ID) REFERENCES International_Exam(Exam_ID)
);
GO

-- Create the Country table
CREATE TABLE Country (
    Country_Name VARCHAR(100) PRIMARY KEY,
    Official_Language VARCHAR(100),
    Currency VARCHAR(50),
    Time_Zone VARCHAR(50)
);
GO

-- Create the Foreign Institution table
CREATE TABLE Foreign_Institution (
    Institution_ID INT PRIMARY KEY,
    Institution_Name VARCHAR(100),
    Program_of_Study VARCHAR(100),
    Admission_Year VARCHAR(10),
    Country_Name VARCHAR(100),
    CONSTRAINT FK_Country_ForeignInstitution FOREIGN KEY (Country_Name) REFERENCES Country(Country_Name)
);
GO

-- Create the Scholarship table
CREATE TABLE Scholarship (
    Scholarship_ID INT PRIMARY KEY,
    Student_ID INT,
    Scholarship_Name VARCHAR(100),
    Institution_ID INT,
    CONSTRAINT FK_Student_Scholarship FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT FK_Institution_Scholarship FOREIGN KEY (Institution_ID) REFERENCES Foreign_Institution(Institution_ID)
);
GO

-- Create the Abroad Journey table
CREATE TABLE Abroad_Journey (
    Country_Name VARCHAR(100) PRIMARY KEY,
    Start_Year VARCHAR(10),
    End_Year VARCHAR(10),
    CONSTRAINT FK_Country_AbroadJourney FOREIGN KEY (Country_Name) REFERENCES Country(Country_Name)
);
GO

-- Create the Departure table
CREATE TABLE Departure (
    Student_ID INT,
    Country_Name VARCHAR(100),
    CONSTRAINT PK_Departure PRIMARY KEY (Student_ID, Country_Name),
    CONSTRAINT FK_Student_Departure FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT FK_Country_Departure FOREIGN KEY (Country_Name) REFERENCES Country(Country_Name)
);
GO

-- Insert data into Student table
INSERT INTO Student (Student_ID, Full_Name, Gender, Address, Email, Passport_ID)
VALUES
    (1, 'Md Arafat Kabir', 'Male', '123 Gulshan Avenue, Dhaka', 'arafat@email.com', 'AB123456'),
    (2, 'Nishat Tasnim', 'Female', '763 Station Road, Sylhet', 'nishat@email.com', 'CD789012'),
    (3, 'Nazneen Nahar', 'Female', '011 GHI Avenue, Comilla', 'nazneen.nahar@email.com', 'EF345678'),
    (4, 'Suriya Islam Afrin', 'Female', '101 Pine St, City4', 'suriya.afrin@email.com', 'GH901234'),
    (5, 'Mujahid Hasan', 'Male', '768 Duramari, Thakurgaon', 'hasanmujahid@email.com', 'IJ567890'),
    (6, 'Mehedi Hasan', 'Male', '12 Hazipara, Sirajganj', 'mehedi238@email.com', 'KL123456'),
    (7, 'Foysal Hossain', 'Male', '54 Nabinagar Savar, Dhaka', 'foysal.hossain@email.com', 'MN234567'),
    (8, 'Soma Das', 'Female', '234 MNO Lane, Narayanganj', 'das.soma@email.com', 'OP345678'),
    (9, 'Sheikh Muhammad Ashik', 'Male', '393 Agrabad C/A, Chittagong', 'muhammadashik2@email.com', 'QR456789'),
    (10, 'Naimul Islam', 'Male', '686 Khilgaon, Dhaka', 'naimul@email.com', 'ST567890');

-- Insert data into Academic_Profile table
INSERT INTO Academic_Profile (Program_Name, Year_Accomplished, Grade, Student_ID)
VALUES
  ('SSC', '2017', 'A+', 1),
  ('HSC', '2019', 'A+', 1),
  ('BSC', '2023', 'A+', 1),
  ('BSC', '2022', 'A+', 2),
  ('MSC', '2019', 'A+', 3),
  ('SSC', '2021', 'A', 4),
  ('BSC', '2020', 'B+', 5),
  ('HSC', '2022', 'A', 6),
  ('BSC', '2018', 'C+', 7),
  ('MSC', '2021', 'B', 8),
  ('BSC', '2021', 'B', 9),
  ('BSC', '2018', 'B', 10);

-- Insert data into Extra_Curricular_Activity table
INSERT INTO Extra_Curricular_Activity (Activity_ID, Activity_Name)
VALUES
  (1, 'Drama Club'),
  (2, 'Poetry Club'),
  (3, 'Research Club'),
  (4, 'Debate Team'),
  (5, 'Math Club'),
  (6, 'Drama Club'),
  (7, 'Environmental Club'),
  (8, 'Music Band'),
  (9, 'Sports Team - Basketball'),
  (10, 'Student Council');

-- Insert data into Achieves_Activity table
INSERT INTO Achieves_Activity (Student_ID, Activity_ID)
VALUES
  (1, 1),
  (2, 2),
  (2, 4),
  (2, 5),
  (3, 6),
  (4, 7),
  (4, 8),
  (4, 9),
  (5, 10),
  (6, 1),
  (6, 2),
  (7, 3),
  (7, 4),
  (8, 5),
  (8, 6),
  (9, 7),
  (9, 8),
  (9, 9),
  (10, 10);

-- Insert data into International_Exam table
INSERT INTO International_Exam (Exam_ID, Exam_Name, Exam_Year, Score)
VALUES
  (1, 'TOEFL', '2022', '95.5'),
  (2, 'IELTS', '2021', '7.5'),
  (3, 'SAT', '2023', '1450'),
  (4, 'GRE', '2022', '320'),
  (5, 'GMAT', '2021', '680'),
  (6, 'ACT', '2023', '28'),
  (7, 'DELE', '2022', '85.0'),
  (8, 'HSK', '2021', '200'),
  (9, 'MCAT', '2021', '520'),
  (10, 'PTE Academic', '2022', '79.5');

-- Insert data into Give_I_Exam table
INSERT INTO Give_I_Exam (Student_ID, Exam_ID)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 7),
  (4, 8),
  (6, 1),
  (6, 2),
  (7, 3),
  (7, 4),
  (8, 5),
  (8, 6),
  (10, 9),
  (10, 10);

-- Insert data into Country table
INSERT INTO Country (Country_Name, Official_Language, Currency, Time_Zone)
VALUES
  ('United States', 'English', 'USD', 'GMT-5'),
  ('United Kingdom', 'English', 'GBP', 'GMT+0'),
  ('Canada', 'English, French', 'CAD', 'GMT-4'),
  ('Australia', 'English', 'AUD', 'GMT+10'),
  ('Germany', 'German', 'EUR', 'GMT+1'),
  ('Japan', 'Japanese', 'JPY', 'GMT+9'),
  ('France', 'French', 'EUR', 'GMT+1'),
  ('Brazil', 'Portuguese', 'BRL', 'GMT-3'),
  ('China', 'Mandarin', 'CNY', 'GMT+8'),
  ('India', 'Hindi, English', 'INR', 'GMT+5.5');

-- Insert data into Foreign_Institution table
INSERT INTO Foreign_Institution (Institution_ID, Institution_Name, Program_of_Study, Admission_Year, Country_Name)
VALUES
  (1, 'Harvard University', 'Computer Science', '2020', 'United States'),
  (2, 'University of Toronto', 'Business Administration', '2019', 'Canada'),
  (3, 'University of Oxford', 'Physics', '2021', 'United Kingdom'),
  (4, 'University of Sydney', 'Engineering', '2020', 'Australia'),
  (5, 'Technical University of Munich', 'Mechanical Engineering', '2022', 'Germany'),
  (6, 'University of Tokyo', 'Mathematics', '2018', 'Japan'),
  (7, 'Sorbonne University', 'French Literature', '2019', 'France'),
  (8, 'Peking University', 'Economics', '2021', 'China'),
  (9, 'Indian Institute of Technology Delhi', 'Computer Engineering', '2020', 'India'),
  (10, 'University of São Paulo', 'Medicine', '2017', 'Brazil');

-- Insert data into Scholarship table
INSERT INTO Scholarship (Scholarship_ID, Student_ID, Scholarship_Name, Institution_ID)
VALUES
  (1, 1, 'Merit Scholarship', 1),
  (2, 2, 'Achievement Scholarship', 2),
  (3, 3, 'Excellence Scholarship', 3),
  (4, 4, 'Leadership Scholarship', 4),
  (5, 5, 'Innovation Scholarship', 5),
  (6, 6, 'Diversity Scholarship', 6),
  (7, 7, 'Community Service Scholarship', 7),
  (8, 8, 'Research Scholarship', 8),
  (9, 9, 'Sports Scholarship', 9),
  (10, 10, 'Need-Based Scholarship', 10);

-- Insert data into Abroad Journey table
INSERT INTO Abroad_Journey (Country_Name, Start_Year, End_Year)
VALUES
  ('United States', '2023', '2029'),
  ('Canada', '2023', '2028'),
  ('United Kingdom', '2022', '2027'),
  ('Australia', '2022', '2027'),
  ('Germany', '2023', '2028'),
  ('Japan', '2023', '2027'),
  ('France', '2019', '2022'),
  ('China', '2023', '2026'),
  ('India', '2021', '2026'),
  ('Brazil', '2018', '2022');

-- Insert data into Departure table
INSERT INTO Departure (Student_ID, Country_Name)
VALUES
  (1, 'United States'),
  (2, 'Canada'),
  (3, 'United Kingdom'),
  (4, 'Australia'),
  (5, 'Germany'),
  (6, 'Japan'),
  (7, 'France'),
  (8, 'China'),
  (9, 'India'),
  (10, 'Brazil');

  -- Select data from the Student table
SELECT * FROM Student;

-- Select data from the Academic_Profile table
SELECT * FROM Academic_Profile;

-- Select data from the Extra_Curricular_Activity table
SELECT * FROM Extra_Curricular_Activity;

-- Select data from the Achieves_Activity table
SELECT * FROM Achieves_Activity;

-- Select data from the International_Exam table
SELECT * FROM International_Exam;

-- Select data from the Give_I_Exam table
SELECT * FROM Give_I_Exam;

-- Select data from the Country table
SELECT * FROM Country;

-- Select data from the Foreign_Institution table
SELECT * FROM Foreign_Institution;

-- Select data from the Scholarship table
SELECT * FROM Scholarship;

-- Select data from the Abroad_Journey table
SELECT * FROM Abroad_Journey;

-- Select data from the Departure table
SELECT * FROM Departure;


--Query :
-- 1. Retrieve the full list of students.
SELECT * 
FROM Student;

-- 2. Count the total number of students in the "Student" table.
SELECT COUNT(*) AS Total_Students 
FROM Student;

-- 3. Retrieve all the female students whose full names start with the letter 'N'.
SELECT * 
FROM Student
WHERE Full_name LIKE 'N%' AND Gender = 'Female';

-- 4. Retrieve a list of distinct scholarship names from the Scholarship table, sorted in alphabetical order.
SELECT DISTINCT Scholarship_name
FROM Scholarship
ORDER BY Scholarship_Name;

-- 5. Count the number of students who received scholarships.
SELECT COUNT(DISTINCT Student_ID) AS Scholarship_Count
FROM Scholarship;

 -- 6. Retrieve the Student IDs and Full Names of students who have achieved multiple activities.
SELECT Student_ID, Full_Name
FROM Student
WHERE Student_ID IN
(
    SELECT Student_ID
    FROM Achieves_Activity
    GROUP BY Student_ID
    HAVING COUNT(*) > 1
);

-- 7. Select the students who went to abroad without participating in any international exam.
SELECT * FROM Student
WHERE Student_ID NOT IN (SELECT Student_ID FROM Give_I_Exam);

-- 8. Find the highest score among all students in international exams.
SELECT MAX(CAST(Score AS FLOAT)) AS Maximum_International_Exams_Score
FROM International_Exam;

-- 9. Retrieve the information of students who have either a scholarship or have taken an international exam.
SELECT *
FROM Student
WHERE Student_ID IN (SELECT Student_ID FROM Scholarship)
OR Student_ID IN (SELECT Student_ID FROM Give_I_Exam); 

-- 10. Retrieve the students who got into Harvard University
SELECT Student_ID, Full_Name
FROM Student
WHERE Student_ID IN (
    SELECT Student_ID
    FROM Scholarship
    WHERE Institution_ID = (
        SELECT Institution_ID
        FROM Foreign_Institution
        WHERE Institution_Name = 'Harvard University'
    )
);
		   
--- 11. Retrieve a list of all countries from the Country table, ordered in descending alphabetical order by country name.
SELECT *
FROM Country
ORDER BY Country_Name DESC;

-- 12. Count and list the number of abroad journeys that started each year.
SELECT start_year, COUNT(*) AS Year_Statistics_Count
FROM abroad_journey
GROUP BY start_year
ORDER BY start_year;

-- 13. Calculate the students average score for each exam type and show their information.
SELECT exam_name, AVG(CAST(score AS FLOAT)) AS average_score
FROM Student s
JOIN Give_I_Exam ge ON s.student_id = ge.student_id
JOIN International_Exam ie ON ge.exam_id = ie.exam_id
GROUP BY exam_name;

-- 14. List the academic programs that have the highest number of students who accomplished them.
SELECT ap.Program_Name, COUNT(*) AS Student_Count
FROM Academic_Profile ap
GROUP BY ap.Program_Name
ORDER BY Student_Count DESC;

-- 15. List the student IDs and full names of students who have not traveled abroad.
SELECT Student_ID, Full_Name
FROM Student
WHERE Student_ID NOT IN (SELECT DISTINCT Student_ID FROM Abroad_Journey);


