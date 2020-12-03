INSERT INTO t_user( id, active, password, username)
VALUES (2	,	true	,	'123456'	, 'admin');

INSERT INTO t_user_role(
	user_id, role)
	VALUES (2, 'ADMIN'),(1, 'USER') ;