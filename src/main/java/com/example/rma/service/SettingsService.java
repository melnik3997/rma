package com.example.rma.service;

import com.example.rma.domain.Settings;
import com.example.rma.domain.dto.SettingsDto;
import com.example.rma.repository.SettingsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SettingsService {
    @Autowired
    private SettingsRepo settingsRepo;

    public SettingsDto getSettingsDtoForObj(Object[] object) {
        SettingsDto settingsDto = new SettingsDto();

        if((object[0] instanceof Long) ){
            settingsDto.setsId((Long) object[0]);
        }else if (object[0] instanceof BigInteger){
            settingsDto.setsId(((BigInteger) object[0]).longValue());
        }
        if(object[1] instanceof String){
            settingsDto.setSysName((String) object[1]);
        }
        if(object[2] instanceof String){
            settingsDto.setType((String) object[2]);
        }
        if(object[3] instanceof String){
            settingsDto.setVal((String) object[3]);
        }
        return settingsDto;
    }

    public List<SettingsDto> getSettingsDtoList(List<Object[]> objects){
        List<SettingsDto> settingsDtoList = new ArrayList<SettingsDto>();

        for (Object[] obj : objects) {
            settingsDtoList.add(getSettingsDtoForObj(obj));
        }

        return settingsDtoList;
    }

    public List<SettingsDto> getAllSettingsDto(){
        List<Object[]> settingsObjectList = settingsRepo.findAllSettings();

        return getSettingsDtoList(settingsObjectList);
    }

    private SettingsDto getSettingsBySysNameAndType(String sysName, String value ){

        return parsObjectArrToSettingDto(settingsRepo.findSettingsByValue(sysName, value));
    }

    public SettingsDto getSettingsBySysName(String sysName){
        return getSettingsBySysNameAndType("SysName", sysName);
    }

    public int getIntSettingsBySysName(String sysName){
        int i = 0;
        try {
             i = Integer.parseInt(getSettingsBySysName(sysName).getVal());
        }catch (Exception e){
            i = 0;
        }
        return i;
    }

    public boolean getBooleanSettingsBySysName(String sysName){
        boolean b = false;
        try {
            b = Boolean.parseBoolean(getSettingsBySysName(sysName).getVal());
        }catch (Exception e){
            b = false;
        }
        return b;
    }

    public SettingsDto getSettingsBySId(Long sId){

        return parsObjectArrToSettingDto(settingsRepo.findSettingsBySId(sId));
    }

    public Long findMaxSId(){
        return settingsRepo.findMaxSId();
    }
    public void save(Settings settings){
        settingsRepo.save(settings);
    }

    public SettingsDto parsObjectArrToSettingDto(List<Object[]> objects){
        SettingsDto settingsDto = new SettingsDto();

        for (Object[] object : objects ) {

            String sysName = (String) object[1];

            switch (sysName) {
                case  ("Type"):
                    settingsDto.setType((String) object[2]);
                    break;
                case ("SysName"):
                    settingsDto.setSysName((String) object[2]);
                    break;
                case ("Val"):
                    settingsDto.setVal((String) object[2]);
                    break;
            }
        }
        Object sID = objects.get(0)[0];

        if((sID instanceof Long) ){
            settingsDto.setsId((Long) sID);
        }else if (sID instanceof BigInteger){
            settingsDto.setsId(((BigInteger) sID).longValue());
        }else if (sID instanceof Integer){
            settingsDto.setsId(((Integer) sID).longValue());
        }
        return settingsDto;
    }


    public Map<String, String> saveSetting(String sysName, String type, String value){
        Map<String, String> error = new HashMap<>();
        if(StringUtils.isEmpty(sysName) || StringUtils.isEmpty(type) || StringUtils.isEmpty(value)){
            error.put("error", "Не передан обязательный параметр");
            return error;
        }
        Long maxSID;
        maxSID = findMaxSId();
        if(maxSID == null)
            maxSID = 0L;

        maxSID++;
        Settings settings = new Settings();
        settings.setsId(maxSID);
        settings.setSysName("Type");
        settings.setValue(type);
        save(settings);


        Settings settings1 = new Settings();
        settings1.setsId(maxSID);
        settings1.setSysName("SysName");
        settings1.setValue(sysName);
        save(settings1);

        Settings settings2 = new Settings();
        settings2.setsId(maxSID);
        settings2.setSysName("Val");
        settings2.setValue(value);
        save(settings2);
        return error;
    }

    public Map<String, String> editSetting(Long sId, String sysName, String type, String value) {
        Map<String, String> error = new HashMap<>();
        if(sId == 0 || StringUtils.isEmpty(sysName) || StringUtils.isEmpty(type) || StringUtils.isEmpty(value)){
            error.put("error", "Не передан обязательный параметр");
            return error;
        }

        settingsRepo.editBySIdAndSysName(sId, "SysName", sysName);
        settingsRepo.editBySIdAndSysName(sId, "Type", type);
        settingsRepo.editBySIdAndSysName(sId, "Val", value);

        return error;
    }

    public void deleteBySID(Long sId){
        settingsRepo.deleteBySID(sId);
    }
}
