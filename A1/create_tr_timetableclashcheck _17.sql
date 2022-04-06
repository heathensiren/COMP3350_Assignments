/*
	Author: Kaitlin Murray and Minnie Bumnapol
	Student Numbers: c3324150 and c3320409
	Description: create_tr_timetableclashcheck.sql
	Enforces no student or staff member has any timetable clashes
*/
DROP TRIGGER timetableClashStudent
DROP TRIGGER timetableClashStaff

CREATE TRIGGER timetableClashStaff       -- creating the trigger
ON StudentTimeSlot
FOR INSERT, UPDATE AS BEGIN



