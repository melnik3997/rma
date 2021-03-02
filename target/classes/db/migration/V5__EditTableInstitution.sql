alter table if exists t_institution
            RENAME COLUMN  firstName TO first_Name;

alter table if exists t_institution
           RENAME COLUMN  lastName TO last_Name;

alter table if exists t_institution
            RENAME COLUMN  secondName TO second_Name;