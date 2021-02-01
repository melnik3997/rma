INSERT INTO t_user( id, active, password, username)
VALUES (1	,	true	,	'123456'	, 'admin');

INSERT INTO t_user_role(
	user_id, role)
	VALUES (1, 'ADMIN'),(1, 'USER') ;