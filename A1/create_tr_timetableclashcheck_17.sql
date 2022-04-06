/* There should not be a timetable clash for a student or staff member
If a student or staff member is assigned a timeslot that overlaps with an existing timetable slot then it should be rejected and a warning message generated
Trigger checkTimetableClashStudent and checkTimeTableClashStaff 
STEPS:
1. Search through timetable and count the timestableid and their time
2. Search through student and staff timetable and count the timetableid and student or staff number
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
			 StudentEnrolment se
			 
			 -- Connecting all id's and dates and then checking the timetable clash 
		WHERE	i.timetable = t.timetableID		AND
				i.timetable != @timetable		AND
				i.studentID = se.studentID		AND
				i.studentID = @student			AND
				t.date = @date					AND
				((t.startTime >= @startTime AND t.startTime < @endTime) OR (t.endTime > @startTime AND t.endTime <= @endTime))

		IF @currentCount > @count
		BEGIN
			SET @count = @currentCount
		END

		FETCH NEXT FROM studentCursor INTO @timetable, @student, @date, @startTime, @endTime

	END

	DEALLOCATE studentCursor

	IF @count > 0
	BEGIN
		RAISERROR('Clash in timetable for the student.', 19, 1)
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
				 Staff s,
				 TimetableStaff tss
			 
				 -- Connecting all id's and dates and then checking the timetable clash 
			WHERE	i.timetable = t.timetableID		AND
					i.timetable != @timetable		AND
					i.staffID = s.staffID			AND
					i.staffID = @staff				AND
					t.date = @date					AND
					((t.startTime >= @startTime AND t.startTime < @endTime) OR (t.endTime > @startTime AND t.endTime <= @endTime))

			IF @currentCount > @count
			BEGIN
				SET @count = @currentCount
			END

			FETCH NEXT FROM staffCursor INTO @timetable, @staff, @date, @startTime, @endTime

		END

		DEALLOCATE staffCursor

		IF @count > 0
		BEGIN
			RAISERROR('Clash in timetable for the student.', 19, 1)
			ROLLBACK TRANSACTION
		END
END
GO