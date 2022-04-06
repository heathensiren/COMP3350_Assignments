/*	Author: Kaitlin Murray and Minnie Bumnanpol
	Student Numbers: c3324150 and c3320409
	Description:Stored Procedure

	Parameters:studentNumber � Student number of the student registering for courses
	CourseOfferingList� Course offering list contains a Table-Valued Parameter
	that has the course offering identifiers (e.g. CourseOfferingIds) that a student
	wants to register to.
	Functionality: Register the student specified in the studentNumber to the courses offerings
	specified in the CourseOfferingList.

	If any errors occur during an insert of a particular row (e.g. already registered,
	have not completed the pre-requisite knowledge, etc.), a warning should be
	raised with the relevant error message while the rest of the inserts should
	proceed.
*/

DROP PROCEDURE IF EXISTS usp_RegisterForCourses
	DROP TYPE IF EXISTS CourseOfferingList
	go

	CREATE TYPE CourseOfferingList as Table
	(
		studentID CHAR (10),	-- parse in the student ID.
		courseID CHAR(10)		-- parse in the course ID.

	)
	go


	CREATE PROCEDURE usp_RegisterForCourses @courseOfferingList courseOfferingList READONLY
AS
BEGIN

	DECLARE
		@studentID CHAR(10),
		@courseID CHAR(10)
		

	
	-- Declare a cursor to traverse the input parameter row by row
	DECLARE curCourseOfferingList CURSOR
		FOR
		SELECT c.studentID, c.courseID 
		FROM @courseOfferingList c 
	FOR READ ONLY

	--Cursor opening 
	OPEN curCourseOfferingList
	FETCH NEXT FROM curCourseOfferingList INTO @studentID, @courseID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @count INT
		
		-- Find out whether the registration exists
		SELECT @count = COUNT(*)
		FROM Register r
		WHERE r.courseID = @courseID AND r.studentID = @studentID
		
		IF @count > 0 -- Registration exists
		BEGIN
				RAISERROR('This Student has already signed up for this course',11,1)
			--RETURN -- Exit out of the procedure to provident incorrect data being passed forward.
		END
		ELSE -- New registration
		BEGIN
			BEGIN TRY
				-- Insert a new record
				INSERT INTO Register(studentID,courseID) 
				VALUES (@studentID, @courseID)
			END TRY
			BEGIN CATCH
				DECLARE @errMsg NVARCHAR(255)
				SELECT @errMsg = ERROR_MESSAGE()  
				-- error 
				RAISERROR (@errMsg, 10, 1)
			END CATCH
		END
		

		-- Fetch the next row
		FETCH NEXT FROM curCourseOfferingList INTO @studentID, @courseID
		
	END -- End of While
	

	-- Close cursor
	CLOSE curCourseOfferingList
	
	-- Deallocate cursor
	DEALLOCATE curCourseOfferingList
END
GO 

