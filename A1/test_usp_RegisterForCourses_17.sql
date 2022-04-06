/*	Author: Kaitlin Murray and Minnie Bumnanpol
	Student Numbers: c3324150 and c3320409
	Description:Test Data for Stored Procedure
	
*/

SELECT * FROM StudentEnrolment

DECLARE @CourseOfferingList CourseOfferingList



INSERT INTO @CourseOfferingList VALUES ('c3324150', 'COMP3350')
INSERT INTO @CourseOfferingList VALUES ('c3324150', 'COMP2240')
INSERT INTO @CourseOfferingList VALUES ('c3320409', 'COMP1140')


EXEC usp_RegisterForCourses @CourseOfferingList

SELECT * FROM Register


 
