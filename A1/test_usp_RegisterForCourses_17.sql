/*	Author: Kaitlin Murray and Minnie Bumnanpol
	Student Numbers: c3324150 and c3320409
	Description:Test Data for Stored Procedure
	
*/

SELECT * FROM StudentEnrolment

DECLARE @CourseOfferingList CourseOfferingList

INSERT INTO @CourseOfferingList VALUES ('c3324150', 'COMP3350')


EXEC usp_RegisterForCourses @CourseOfferingList

SELECT * FROM Register


 
