# 1
SELECT teacher_name FROM (
	SELECT t.name AS teacher_name, cs.id AS cs_id 
	FROM Teacher t
	LEFT OUTER JOIN ClassSubject cs ON cs.teacher_id = t.id
) teacher_class
WHERE cs_id IS NULL

# 2
SELECT p.name AS pupil_name, COUNT(*) number_of_fives
FROM Pupil p
JOIN PupilSubject ps ON ps.pupil_id = p.id
WHERE ps.grade = 5
GROUP BY p.name

# 3
SELECT CONCAT(c.year, c.name) AS class, AVG(ps.grade) AS avg_grade
FROM Class c
JOIN ClassSubject cs ON cs.class_id = c.id
JOIN Subject s ON s.id = cs.subject_id
JOIN PupilSubject ps ON ps.subject_id = s.id
GROUP BY c.year, c.name

# 4
SELECT c.year, AVG(ps.grade) AS avg_grade
FROM Class c
JOIN ClassSubject cs ON cs.class_id = c.id
JOIN Subject s ON s.id = cs.subject_id
JOIN PupilSubject ps ON ps.subject_id = s.id
GROUP BY c.year, c.name

# 5
SELECT t.name AS teacher_name, CONCAT(c.year, c.name) AS class, s.name
FROM ClassSubject cs
JOIN Teacher t ON t.id = cs.teacher_id
JOIN Class c ON c.id = cs.class_id
JOIN Subject s ON s.id = cs.subject_id
WHERE c.homeroom_teacher_id = t.id

# 6
SELECT c.year, c.name, s.name, AVG(ps.grade)
FROM ClassSubject cs
JOIN Class c ON c.id = cs.class_id
JOIN Subject s ON s.id = cs.subject_id
JOIN PupilSubject ps ON ps.subject_id = s.id
GROUP BY c.id, s.id

# 7
(
  SELECT t.name, AVG(ps.grade) AS avg_grade
  FROM ClassSubject cs
  JOIN Class c ON c.id = cs.class_id
  JOIN Subject s ON s.id = cs.subject_id
  JOIN PupilSubject ps ON ps.subject_id = s.id
  JOIN Teacher t ON t.id = cs.teacher_id
  GROUP BY c.id, s.id
  ORDER BY avg_grade
  LIMIT 5
)
UNION
(
  SELECT t.name, AVG(ps.grade) AS avg_grade
  FROM ClassSubject cs
  JOIN Class c ON c.id = cs.class_id
  JOIN Subject s ON s.id = cs.subject_id
  JOIN PupilSubject ps ON ps.subject_id = s.id
  JOIN Teacher t ON t.id = cs.teacher_id
  GROUP BY c.id, s.id
  ORDER BY avg_grade DESC
  LIMIT 5
)
