package com.example.rma.repository;

import com.example.rma.domain.Settings;
import com.example.rma.domain.dto.SettingsDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SettingsRepo extends JpaRepository<Settings, Long> {

    @Query("select max(s.sId) from Settings s")
    public Long findMaxSId();

   /* @Query(value ="select  s_Id, " +
                  "max(case when sys_Name='SysName' then value end) as SysName ," +
                  "max(case when sys_Name='Type'    then value end) as Type, " +
                  "max(case when sys_Name='Val'     then value end)  as Val " +
                  "from t_Settings " +
                  "group by s_Id " +
                  "order by s_Id", nativeQuery = true)*/
    @Query(value ="\tselect s_id, SysName,Type, Val  from crosstab\n" +
            "\t(\n" +
            "\t'select s_id, sys_name, Value from t_settings  order by 1, 2'\n" +
            "\t)\n" +
            "\tas (\n" +
            "\t\ts_id bigint,\n" +
            "\t\tSysName varchar,\n" +
            "\tType varchar,\n" +
            "\t\tVal varchar\n" +
            "\t)", nativeQuery = true)
    public List<Object[]> findAllSettings();
}
