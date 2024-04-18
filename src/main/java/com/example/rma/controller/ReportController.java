package com.example.rma.controller;

import com.example.rma.domain.ActuallyWork;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.CalendarClose;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.service.ActuallyWorkService;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleService;
import com.example.rma.service.reports.ReportExcelInstitutionDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private InstitutionService institutionService;
    @Autowired
    private UserService userService;

    @Autowired
    private ActuallyWorkService actuallyWorkService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @PreAuthorize("hasAuthority('MANAGER')")
    @GetMapping("/spisaniya-sotrudnikov/{calendarClose}")
    public void reportSpisaniyaSotrudnikov(@PathVariable CalendarClose calendarClose,
                       @AuthenticationPrincipal User user,
                       HttpServletResponse response) throws IOException {

        Institution institution = userService.findInstitutionByUser(user);
        if(calendarClose != null) {
            List<Institution> institutionList = institutionService.findInstitutionByEnterprise(institution.getEnterprise());
            List<InstitutionDto> institutionDtoList = institutionService.findInstitutionDtoListByInstitutions(institutionList);
            institutionDtoList = actuallyWorkService.setSumActToListInstitutionDto(institutionDtoList, calendarClose.getCalendar());
            institutionDtoList = workScheduleService.setWorkScheduleListToInstitutionDto(institutionDtoList, calendarClose.getCalendar());
            ReportExcelInstitutionDto reportExcelInstitutionDto = new ReportExcelInstitutionDto(institutionDtoList, "Сотрудники", "spisaniya-sotrudnikov-za" + calendarClose.getCalendar().getDateS());
            reportExcelInstitutionDto.export(response);
        }
    }

    @PreAuthorize("hasAuthority('MANAGER')")
    @GetMapping("/ne-dostatochnye-spisaniya/{calendarClose}")
    public void reportNeDostatochnyeSpisaniya(@PathVariable CalendarClose calendarClose,
                                           @AuthenticationPrincipal User user,
                                           HttpServletResponse response) throws IOException {

        Institution institution = userService.findInstitutionByUser(user);
        if(calendarClose != null) {
            List<Institution> institutionList = institutionService.findInstitutionByEnterprise(institution.getEnterprise());
            List<InstitutionDto> institutionDtoList = institutionService.findInstitutionDtoListByInstitutions(institutionList);
            institutionDtoList = actuallyWorkService.setSumActToListInstitutionDto(institutionDtoList, calendarClose.getCalendar());
            institutionDtoList = workScheduleService.setWorkScheduleListToInstitutionDto(institutionDtoList, calendarClose.getCalendar());

            institutionDtoList = institutionDtoList.stream().filter(i -> !i.isNormActualWork()).collect(Collectors.toList());
            ReportExcelInstitutionDto reportExcelInstitutionDto = new ReportExcelInstitutionDto(institutionDtoList, "Сотрудники", "ne-dostatochnye-spisaniya" + calendarClose.getCalendar().getDateS());
            reportExcelInstitutionDto.export(response);
        }
    }


}
