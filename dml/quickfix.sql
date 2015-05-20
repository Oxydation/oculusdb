UPDATE appointment app INNER JOIN calendarentry cal ON app.calendarentry = cal.id
SET app.status = "FINISHED"
WHERE cal.start <= CURRENT_DATE();

UPDATE appointment app INNER JOIN calendarentry cal ON app.calendarentry = cal.id
SET app.status = "PENDING"
WHERE cal.start > CURRENT_DATE();

UPDATE appointment app INNER JOIN calendarentry cal ON app.calendarentry = cal.id
SET cal.end = ADDTIME(cal.start, '0:30:00');