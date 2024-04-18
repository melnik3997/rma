CREATE TABLE t_calendar_close
(
    id             BIGINT NOT NULL,
    calendar_id    BIGINT,
    institution_id BIGINT,
    date_protocol  TIMESTAMP without time zone,
    CONSTRAINT pk_t_calendar_close PRIMARY KEY (id)
);

ALTER TABLE t_calendar_close
    ADD CONSTRAINT FK_T_CALENDAR_CLOSE_ON_CALENDAR FOREIGN KEY (calendar_id) REFERENCES t_calendar (id);

ALTER TABLE t_calendar_close
    ADD CONSTRAINT FK_T_CALENDAR_CLOSE_ON_INSTITUTION FOREIGN KEY (institution_id) REFERENCES t_institution (id);