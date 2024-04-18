package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.Position;
import com.example.rma.domain.Subdivision;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.repository.InstitutionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InstitutionService {

    @Autowired
    private UserService userService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private InstitutionRepo institutionRepo;

    @Autowired
    private SubdivisionService subdivisionService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @Autowired
    private PresenceWorkService presenceWorkService;

    @Autowired
    private ActuallyWorkService actuallyWorkService;

    public List<InstitutionDto> findColleaguesByInstitution(Institution institution){

        Position position = positionService.findActiveByInstitutionAndGeneral(institution);
        //если он является руководителем до ищем коллег как руководителей его подразделения
        if(position.getInstitution().getId().equals(institution.getId())){
            List<InstitutionDto> institutionDtoList = new ArrayList<>();
            List<Subdivision> subdivisionList = subdivisionService.getSubdivisionByParent(position.getSubdivision().getParent());
            for (Subdivision s: subdivisionList) {
                if(!isLeaderByInstitution(institution, s)){
                    institutionDtoList.add( findInstitutionDtoByInstitution( userService.findInstitutionByUser(s.getLeader())));
                }
            }
            return institutionDtoList;
        }
        // ищем коллег по своему подр. не обязательно должность должна быть основной
        return institutionRepo.findInstitutionDtoColleaguesByInstitutionAndPosition(institution, position.getId() );
    }

    public List<InstitutionDto> findColleaguesPositionByInstitution(Institution institution){

        Position position = positionService.findActiveByInstitutionAndGeneral(institution);
        // ищем коллег по своему подр. не обязательно должность должна быть основной
        return institutionRepo.findInstitutionDtoColleaguesByInstitutionAndPosition(institution, position.getId() );
    }

    public InstitutionDto findLeaderByInstitution(Institution institution){
        Position position = positionService.findActiveByInstitutionAndGeneral(institution);
        InstitutionDto institutionDto = null;

        //если он руководитель то его руководитель вышестоящкго подраздел
        if(isLeaderByInstitution(institution, position.getSubdivision())){
            Subdivision parentSubdivision = position.getSubdivision().getParent();
            if(parentSubdivision != null){
                institutionDto= findInstitutionDtoByInstitution(userService.findInstitutionByUser(parentSubdivision.getLeader()));
            }
        }else {
            Institution leader = userService.findInstitutionByUser(position.getSubdivision().getLeader());
            institutionDto = findInstitutionDtoByInstitution(leader);
        }
        return institutionDto;
    }

    /**
     * Поиск подчиненных
     * @param institution
     * @return
     */
    public List<InstitutionDto> findSubordinatesByInstitution(Institution institution){
        List<InstitutionDto> institutionDtoList = new ArrayList<>();
        Position position = positionService.findActiveByInstitutionAndGeneral(institution);
        if(position.getInstitution().getId().equals(institution.getId())){
            //добавляем всх в его подразделении
            institutionDtoList.addAll(institutionRepo.findInstitutionDtoColleaguesByInstitutionAndPosition(institution, position.getId() ));
            System.out.println("под " + institutionDtoList);
            //добавляем лидеров подченненных подразделений
            List<Subdivision> subdivisionList = subdivisionService.getSubdivisionByParent(position.getSubdivision());
            for (Subdivision s: subdivisionList) {
                institutionDtoList.add( findInstitutionDtoByInstitution( userService.findInstitutionByUser(s.getLeader())));
            }
        }

        return institutionDtoList;
    }

    public List<InstitutionDto> findChainLeaderByInstitution(Institution institution){
        List<InstitutionDto> institutionDtoList = new ArrayList<>();
        Institution findInstitution = new Institution();
        findInstitution = institution;
        Subdivision subdivision = subdivisionService.findSubdivisionByInstitution(findInstitution);

        //если руководитель подразделения то начинаеи цепочку через подразделение
        if(isLeaderByInstitution(institution, subdivision)){
            subdivision = subdivision.getParent();
        }

        while (true){
            if(subdivision != null){
                Subdivision parentSubdivision = subdivision.getParent();
                if(parentSubdivision != null){
                    subdivision = parentSubdivision;
                    findInstitution =  userService.findInstitutionByUser(subdivision.getLeader());
                    institutionDtoList.add(0, findInstitutionDtoByInstitution(findInstitution));
                }else {
                    break;
                }
            }else {
                break;
            }
        }

        return institutionDtoList;
    }

    private boolean isLeaderByInstitution(Institution institution, Subdivision subdivision) {
        return userService.findInstitutionByUser(subdivision.getLeader()).getId().equals(institution.getId());
    }

    public InstitutionDto findInstitutionDtoByInstitution(Institution institution){
        return institutionRepo.findInstitutionDtoByInstitution(institution.getId());
    }

    public Institution findInstitutionByInstitutionDto(InstitutionDto institutionDto){
        return institutionRepo.findById(institutionDto.getId()).orElse(null);
    }

    public Page<InstitutionDto> findInstitutionBySubdivision(Subdivision subdivision, Pageable pageable){
        return institutionRepo.findInstitutionDtoBySubdivision(subdivision, pageable);
    }

    public List<InstitutionDto> enrichmentInstitutionDto(List<InstitutionDto> institutionDtoList){
        institutionDtoList = workScheduleService.setWorkScheduleListToInstitutionDtoForToDay(institutionDtoList);
        institutionDtoList = presenceWorkService.setPresenceWorkTimeSumListToInstitutionDtoForToday(institutionDtoList);
        institutionDtoList = presenceWorkService.setPresenceInfoListToInstitutionDtoForForToday(institutionDtoList);
        institutionDtoList = actuallyWorkService.setSumActToListInstitutionDtoForToday(institutionDtoList);

        return institutionDtoList;
    }

    public List<InstitutionDto> findInstitutionDtoListByInstitutions(List<Institution> institutionList){
        List<InstitutionDto> institutionDtoList = new ArrayList<>();
        for (Institution institution: institutionList) {
            institutionDtoList.add(findInstitutionDtoByInstitution(institution));
        }
        return institutionDtoList;
    }

    public List<Institution> findInstitutionByEnterprise(Enterprise enterprise){
        return institutionRepo.findByEnterprise(enterprise);
    }

}
