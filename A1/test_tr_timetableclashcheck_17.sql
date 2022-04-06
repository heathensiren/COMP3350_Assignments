/*	Author: Kaitlin Murray and Minnie Bumnanpol
	Student Numbers: c3324150 and c3320409
	Description: Testing business rules
*/

--Error for staff
INSERT INTO TimetableStaff VALUES (2,'TJ732');
INSERT INTO TimetableStaff VALUES (11,'JM717');
INSERT INTO TimetableStaff VALUES (5,'KR418');

--Error for student
INSERT INTO TimetableStudent VALUES (5,'C3320409');
INSERT INTO TimetableStudent VALUES (8,'C3304630');
INSERT INTO TimetableStudent VALUES (12,'C9675848');

--Works for staff
INSERT INTO TimetableStaff VALUES (12,'TJ732');
INSERT INTO TimetableStaff VALUES (10,'JM717');

--Works for student
INSERT INTO TimetableStudent VALUES (1,'C3320409');
INSERT INTO TimetableStudent VALUES (2,'C3304630');
