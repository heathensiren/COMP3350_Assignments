/*	Author: Kaitlin Murray and Minnie Bumnanpol
	Student Numbers: c3324150 and c3320409
	Description: Testing timetable clashes
*/

--Error for student
INSERT INTO TimetableStudent VALUES (5,'C3320409');
INSERT INTO TimetableStudent VALUES (12,'C9675848');

--Works for student
INSERT INTO TimetableStudent VALUES (1,'C3320409');
INSERT INTO TimetableStudent VALUES (9,'C3304630');

--Error for staff
INSERT INTO TimetableStaff VALUES (2,'TJ732');
INSERT INTO TimetableStaff VALUES (5,'KR418');

--Works for staff
INSERT INTO TimetableStaff VALUES (6,'KR418');
INSERT INTO TimetableStaff VALUES (4,'TJ732');







