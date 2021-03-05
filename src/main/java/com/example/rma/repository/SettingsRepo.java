package com.example.rma.repository;

import com.example.rma.domain.Settings;
import com.example.rma.domain.dto.SettingsDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

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

    @Transactional
    @Modifying
    @Query("delete from Settings  where sId = :seId")
    public void deleteBySID(@Param("seId") final Long sId);

    @Query(value ="select s1.sId, s1.sysName, s1.value \n" +
            "\t\t\t      from Settings  s \n" +
            "\t\t\t     inner join Settings s1\n" +
            "\t\t\t             on s1.sId = s.sId\n" +
            "\t\t\t     where s.sysName = :sysName\n" +
            "\t\t\t       and s.value = :value")
    public List<Object[]>  findSettingsByValue(@Param("sysName") String sysName , @Param("value") String value);

    @Query(value ="select s.sId, s.sysName, s.value \n" +
            "\t\t\t  from Settings  s \n" +
            "\t\t\t where s.sId = :sId")
    public List<Object[]>  findSettingsBySId(@Param("sId") final Long sId);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query("update Settings set value = :value   where sId = :sId and sysName = :sysName")
    public void editBySIdAndSysName(@Param("sId") final Long sId, @Param("sysName") String sysName, @Param("value") String value);
}

