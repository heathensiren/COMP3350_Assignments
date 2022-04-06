/* There should not be a timetable clash for a student or staff member
If a student or staff member is assigned a timeslot that overlaps with an existing timetable slot then it should be rejected and a warning message generated
Trigger checkTimetableClashStudent and checkTimeTableClashStaff 
STEPS:
1. Declare cursor and read data 
2. Connect all data with the temp values and inserted data 
3. If time linked to timetable id overlaps with student or staff number then raise error and rollback transaction*/

DROP TRIGGER checkTimetableClashStaff
DROP TRIGGER checkTimetableClashStudent
GO

CREATE TRIGGER checkTimetableClashStudent
ON TimetableStudent
FOR UPDATE, INSERT
AS
BEGIN

	DECLARE studentCursor CURSOR			--Declaring a cursor for students to access multiple results
	FOR
	SELECT timetableID, studentID, date, startTime, endTime	
	FROM Timetable t, TimetableStudent ts
	WHERE t.timetableID =ts.timetable
	FOR READ ONLY							--Setting to read only to prevent updates

	--Setting temp variables 
	DECLARE @timetable		INT
	DECLARE @student		CHAR (10)
	DECLARE @date			DATE
	DECLARE @startTime		TIME
	DECLARE @endTime		TIME
	DECLARE @count			INT
		SET @count = 0
	DECLARE @currentCount	INT
		SET @currentCount = 0

	OPEN studentCursor			--Opens and populates the cursor 
	FETCH FROM studentCursor INTO @timetable, @student, @date, @startTime, @endTime

	WHILE @@FETCH_STATUS = 0		--While there are more rows
	BEGIN
		SELECT @count = COUNT(*)
		FROM Inserted i,			--New data inserted into timetable
			 Timetable t,
			 TimetableStudent ts
			 
			 -- Connecting all id's and dates and then checking the timetable clash 
		WHERE	t.date = @date					AND
				t.timetableID = ts.timetable	AND
				((t.startTime > @startTime AND t.startTime < @endTime) OR (t.endTime > @startTime AND t.endTime > @endTime))

		IF @currentCount > @count
		BEGIN
			SET @count = @currentCount
		END

		FETCH NEXT FROM studentCursor INTO @timetable, @student, @date, @startTime, @endTime

	END

	DEALLOCATE studentCursor

	IF @count > 0
	BEGIN
		RAISERROR('Clash in timetable for the student.', 11, 1)
		ROLLBACK TRANSACTION
	END
END
GO

CREATE TRIGGER checkTimetableClashStaff
ON TimetableStaff
FOR UPDATE, INSERT
AS
BEGIN

	DECLARE staffCursor CURSOR			--Declaring a cursor for staff to access multiple results
		FOR
		SELECT timetableID, staffID, date, startTime, endTime	
		FROM Timetable t, TimetableStaff ts
		WHERE t.timetableID =ts.timetable
		FOR READ ONLY							--Setting to read only to prevent updates

		--Setting temp variables 
		DECLARE @timetable		INT
		DECLARE @staff			CHAR (10)
		DECLARE @date			DATE
		DECLARE @startTime		TIME
		DECLARE @endTime		TIME
		DECLARE @count			INT
			SET @count = 0
		DECLARE @currentCount	INT
			SET @currentCount = 0

		OPEN staffCursor			--Opens and populates the cursor 
		FETCH FROM staffCursor INTO @timetable, @staff, @date, @startTime, @endTime

		WHILE @@FETCH_STATUS = 0		--While there are more rows
		BEGIN
			SELECT @count = COUNT(*)
			FROM Inserted i,			--New data inserted into timetable
				 Timetable t,
				 TimetableStaff tss
			 
				 -- Connecting all id's and dates and then checking the timetable clash 
			WHERE	t.date = @date					AND
					t.timetableID = tss.timetable	AND
					((t.startTime > @startTime AND t.startTime < @endTime) OR (t.endTime > @startTime AND t.endTime > @endTime))

			IF @currentCount > @count
			BEGIN
				SET @count = @currentCount
			END

			FETCH NEXT FROM staffCursor INTO @timetable, @staff, @date, @startTime, @endTime

		END

		DEALLOCATE staffCursor

		IF @count > 0
		BEGIN
			RAISERROR('Clash in timetable for the staff.', 11, 1)
			ROLLBACK TRANSACTION
		END
END
GO