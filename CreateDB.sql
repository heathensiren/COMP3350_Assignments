-- Dropping tables
DROP TABLE Minor
DROP TABLE Major
DROP TABLE StudentRegistry
DROP TABLE Timetable
DROP TABLE StudentEnrolment
DROP TABLE AcademicProgram 
DROP TABLE CoursesPerTimePeriod
DROP TABLE CourseOffering
DROP TABLE Room
DROP TABLE Facilities
DROP TABLE Campus
DROP TABLE TimePeriod
DROP TABLE StaffAllocation
DROP TABLE StaffName
DROP TABLE Staff
DROP TABLE SubOrganisationalUnit
DROP TABLE OrganisationalUnit

--Creating the tables

--Organisational Unit table
CREATE TABLE OrganisationalUnit (
orgCode			CHAR (10) PRIMARY KEY,
name			VARCHAR (100) NOT NULL,
description		VARCHAR (100) ,
contactNo		INT,
)
go

--Data for Organisational Unit 
INSERT INTO OrganisationalUnit VALUES ('CoESE','College of Engineering and Science', 'Organisational Unit for students in Engineering and Science','57659987')
INSERT INTO OrganisationalUnit VALUES ('CoM','College of Medicine','Organisational Unit for students of Medicine and Medical Programs','67354789')
INSERT INTO OrganisationalUnit VALUES ('CoL','College of Law and Justice','Organisational Unit for students of Law and Legal Practices','18734008')
INSERT INTO OrganisationalUnit VALUES ('CoFA','College of Fine Arts','Organisational Unit for students of the Fine Arts','5667193')
INSERT INTO OrganisationalUnit VALUES ('CoP','College of Philosophy','Organisational Unit for students of Philosphy','58430061')
go

--select * from OrganisationalUnit

-- Sub Organisational Unit table 
CREATE TABLE SubOrganisationalUnit (
name		VARCHAR (100) PRIMARY KEY,
orgUnit		CHAR (10),

CONSTRAINT fkSubOrgUnit
FOREIGN KEY (orgUnit) references OrganisationalUnit(orgCode) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

-- Data for Sub Org Unit 
INSERT INTO SubOrganisationalUnit VALUES ('School of Engineering', 'CoESE')
INSERT INTO SubOrganisationalUnit VALUES ('School of Environmental Science','CoESE')
INSERT INTO SubOrganisationalUnit VALUES ('School of Radiology','CoM')
INSERT INTO SubOrganisationalUnit VALUES ('School of Criminal Law', 'CoL')
INSERT INTO SubOrganisationalUnit VALUES ('School of Astronomy', 'CoP')
go
--select * from SubOrganisationalUnit

--Staff table 
CREATE TABLE Staff (
staffID		CHAR (10) PRIMARY KEY,
orgCode		CHAR (10),
status		CHAR (10),
type		CHAR (25),

CONSTRAINT fkStaff
FOREIGN KEY (orgCode) references OrganisationalUnit(orgCode) ON UPDATE CASCADE ON DELETE NO ACTION
)
go
 
--Data for Staff 
INSERT INTO Staff VALUES ('TJ732', 'CoESE', 'Active', 'Academic')
INSERT INTO Staff VALUES ('SP947', 'CoM', 'Active', 'Admin')
INSERT INTO Staff VALUES ('JM717', 'CoL', 'Active', 'Academic ')
INSERT INTO Staff VALUES ('KR418', 'CoFA', 'Active', 'Academic')
INSERT INTO Staff VALUES ('QT420', 'CoP', 'Inactive', 'Admin')
go
--select * from Staff

--StaffName table that has all the personal staff information
CREATE TABLE StaffName (
staffID		CHAR (10),
fName		VARCHAR (20)NOT NULL,
lName		VARCHAR (20)PRIMARY KEY,
contactNo	INT,
street		VARCHAR (20),
city		VARCHAR (20),
state		CHAR (15),
country		VARCHAR (20),

CONSTRAINT fkStaffName
FOREIGN KEY (staffID) references Staff(staffID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

--Data for Staff Name table 
INSERT INTO StaffName VALUES ('TJ732', 'Tyler', 'Jerone', '614368777','Bang St','Newcastle','NSW','Australia')
INSERT INTO StaffName VALUES ('SP947', 'Sophie', 'Peterson', '614899235','Smith St','Merewether','NSW','Australia')
INSERT INTO StaffName VALUES ('JM717', 'Juno','Ming','817363894','Yoo Rd','Singapore','SP','Singapore')
INSERT INTO StaffName VALUES ('KR418', 'Kira','Rae','614322412','Ceylon Circuit','Petersham','NSW','Australia')
INSERT INTO StaffName VALUES ('QT420', 'Queenie','Tori','614148238','Tantrum Rd','Wyneville','QLD','Australia')
go
--select * from StaffName

--Staff allocation table. This is info for what role staff do within the uni
CREATE TABLE StaffAllocation (
staffID		CHAR (10),
startDate	DATE,
endDate		CHAR (20),
role		CHAR (20),

FOREIGN KEY (staffID) references Staff(staffID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

--Data for staff allocation
INSERT INTO StaffAllocation VALUES ('TJ732', '2014-03-27', '2022-03-29', 'Professor')
INSERT INTO StaffAllocation VALUES ('SP947','2015-07-06', 'Current', 'PhD Researcher')
INSERT INTO StaffAllocation VALUES ('JM717','2022-02-20', '2022-11-20', 'Professor')
INSERT INTO StaffAllocation VALUES ('KR418','2016-10-08','Current', 'Lecturer')
INSERT INTO StaffAllocation VALUES ('QT420','2021-03-05', 'Current','Support Admin')
go
--select * from StaffAllocation

--Time period table. This is for semesters and trimesters
CREATE TABLE TimePeriod (
timeID		CHAR (10) PRIMARY KEY,
name		CHAR (20),
year		SMALLINT NOT NULL CHECK(year BETWEEN 2020 AND 2023),
startDate	DATE,
endDate		DATE,
)
go

-- Data for time period 
INSERT INTO TimePeriod VALUES ('S1_2022','Semester 1', 2022, '2022-02-20', '2022-06-03')
INSERT INTO TimePeriod VALUES ('S2_2022','Semester 2', 2022, '2022-07-03', '2022-11-20')
INSERT INTO TimePeriod VALUES ('S1_2023','Semester 1', 2023, '2023-02-25', '2023-06-07')
INSERT INTO TimePeriod VALUES ('T1_2022','Trimester 1', 2022, '2022-01-30', '2022-04-20')
INSERT INTO TimePeriod VALUES ('T2_2022', 'Trimester 2', 2022, '2022-05-02', '2022-08-03')
INSERT INTO TimePeriod VALUES ('T3_2022', 'Trimester 3', 2022, '2022-08-28', '2022-11-25')
go
--select * from TimePeriod

--Campus table
CREATE TABLE Campus (
campusID	CHAR (10) PRIMARY KEY,
name		VARCHAR (25) NOT NULL,
city		VARCHAR (20),
country		VARCHAR (20),
)
go

--Data for campus 

INSERT INTO Campus VALUES ('CAL','Callaghan Campus','Callaghan','Australia')
INSERT INTO Campus VALUES ('SIN','Singapore Campus','Singapore','Singapore')
INSERT INTO Campus VALUES ('OUR','Ourimbah Campus','Central Coast','Australia')
INSERT INTO Campus VALUES ('SYD','Sydney Campus','Sydney','Australia')
INSERT INTO Campus VALUES ('NEW','Newcastle Campus','Newcastle','Australia')
go
--select * from Campus

-- Facilities table 
CREATE TABLE Facilities (
buildingID		CHAR (10) PRIMARY KEY,
campusID		CHAR (10),
roomNo			CHAR (10),
buildingName	VARCHAR (20),

CONSTRAINT fkFacilities
FOREIGN KEY (campusID) references Campus(campusID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

-- Data for facilities 
INSERT INTO Facilities VALUES ('ES','CAL','ES124','Engineering S')
INSERT INTO Facilities VALUES ('SS','SIN','S101','Social Building')
INSERT INTO Facilities VALUES ('BB','OUR','BG209','Business Building')
INSERT INTO Facilities VALUES ('EF','SYD','EF103','Engineering F')
INSERT INTO Facilities VALUES ('DB','NEW','D100','Design Building')
go
--select * from Facilities

--Room table
CREATE TABLE Room (
roomID		CHAR (10) PRIMARY KEY,
buildingID	CHAR (10),
capacity	INT DEFAULT 10 CHECK (capacity between 10 and 100),

CONSTRAINT fkRoom
FOREIGN KEY (buildingID) references Facilities(buildingID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

-- Data for room
INSERT INTO Room VALUES ('ES124','ES', 20)
INSERT INTO Room VALUES ('S101','SS', 15)
INSERT INTO Room VALUES ('BG209','BB', 25)
INSERT INTO Room VALUES ('EF103','EF',10)
INSERT INTO Room VALUES ('D100','DB',20)
go
--select * from Room

-- Course offering table. Has info for a single course 
CREATE TABLE CourseOffering (
courseID		CHAR (10) PRIMARY KEY,
name			VARCHAR (50) NOT NULL UNIQUE,
staffID			CHAR (10),
prerequisites	VARCHAR (20),
campusID		CHAR (10),
credits			INT DEFAULT 10,
description		VARCHAR (100),
courseType		CHAR (15),

CONSTRAINT fkCourseOffering
FOREIGN KEY (staffID) references Staff(staffID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (campusID) references Campus(campusID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

-- Data for course offering
INSERT INTO CourseOffering VALUES ('COMP3350','Advanced Databases','TJ732','COMP1140','CAL',default,'Learn more about databases','Directed')
INSERT INTO CourseOffering VALUES ('HUMA2070','AUSLAN I','JM717',null,'SIN',default,'Learn sign languages','Elective')
INSERT INTO CourseOffering VALUES ('BUS1001','Introduction to Business Studies','TJ732',null,'OUR',default,'Intro to business and related','Core')
INSERT INTO CourseOffering VALUES ('DSGN3000','Design and Textiles','KR418','DSGN2090','SYD',20,'Learn about design and textiles with some prac work','Core')
INSERT INTO CourseOffering VALUES ('ENG3500','Introduction to Engineering Management','TJ732',null,'NEW',default,'Engineering management and more','Directed')
go
--select * from CourseOffering

--Courses for each time period table
CREATE TABLE CoursesPerTimePeriod (
courseID CHAR (10),
timeID CHAR (10),
timeName CHAR (20),

FOREIGN KEY (timeID) references TimePeriod(timeID),
FOREIGN KEY (courseID) references CourseOffering (courseID) 
)

--Data for coursespertimeperiod
INSERT INTO CoursesPerTimePeriod VALUES (
INSERT INTO CoursesPerTimePeriod VALUES (
INSERT INTO CoursesPerTimePeriod VALUES (
INSERT INTO CoursesPerTimePeriod VALUES (
INSERT INTO CoursesPerTimePeriod VALUES (
go
select * from CoursesPerTimePeriod
-- Academic Program table
CREATE TABLE AcademicProgram (
pCode					CHAR (10) PRIMARY KEY,
name					VARCHAR NOT NULL UNIQUE,
staffID					CHAR (10),
courseID				CHAR (10),
credits					INT CHECK (credits > 100),
level					VARCHAR, 
certificationAchieved	VARCHAR, 

CONSTRAINT fkAcademicProgram
FOREIGN KEY (staffID) references Staff(staffID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (courseID) references CourseOffering(courseID) ON UPDATE NO ACTION ON DELETE NO ACTION
)
go

-- Data for academic program

-- Student enrolment table. This is info about students enrolled in an academic program
CREATE TABLE StudentEnrolment (
studentID		CHAR (10) PRIMARY KEY,
pCode			CHAR (10),
timeID			CHAR (10),
dateEnrolled	DATE,
dateCompleted	DATE,
status			BIT DEFAULT 0 CHECK (status between 0 and 1),

CONSTRAINT fkStudentEnrolment
FOREIGN KEY (pCode) references AcademicProgram(pCode) ON UPDATE NO ACTION ON DELETE NO ACTION,
FOREIGN KEY (timeID) references TimePeriod(timeID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

--Data for student enrolment

--Timetable table. This has all timetable info for a single course. 
CREATE TABLE Timetable (
courseID	CHAR (10),
buildingID	CHAR (10),
date		DATE,
startTime	TIME,
endTime		TIME,
reason		VARCHAR,

FOREIGN KEY (courseID) references CourseOffering(courseID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (buildingID) references Facilities(buildingID) ON UPDATE NO ACTION ON DELETE NO ACTION
)
go
-- Data for timetable 

-- Student registry table. This is info for a student enrolled in a single course. 
CREATE TABLE StudentRegistry (
studentID		CHAR (10),
courseID		CHAR (10),
dateRegistered	DATE,
finalMark		INT DEFAULT 0 CHECK (finalMark BETWEEN 0 and 100),
finalGrade		CHAR (5),

FOREIGN KEY (studentID) references StudentEnrolment(studentID) ON UPDATE NO ACTION ON DELETE NO ACTION,
FOREIGN KEY (courseID) references CourseOffering(courseID) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

-- Data for student registry

-- Major table. Info about major course
CREATE TABLE Major (
pCode		CHAR (10),
name		VARCHAR,
description VARCHAR,
credits		INT DEFAULT 10 CHECK (credits > 9),

FOREIGN KEY (pCode) references AcademicProgram(pCode) ON UPDATE CASCADE ON DELETE NO ACTION
)
go

--Data for major

-- Minor table. Info about minor course
CREATE TABLE Minor (
pCode		CHAR (10),
name		VARCHAR,
description VARCHAR,
credits		INT DEFAULT 10 CHECK (credits > 9),

FOREIGN KEY (pCode) references AcademicProgram(pCode) ON UPDATE CASCADE ON DELETE NO ACTION
)
go 

-- Data for minor 