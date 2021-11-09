<#import "parts/common.ftlh" as c >
<@c.page>

<div class="row align-items-start">
    <div class="col-8">
        <h5 class="mb-3 ">График работы </h5>
    </div>
</div>



<table class="table table-bordered">
    <thead>
        <tr>
            <th style="width: 12%" class="text-center">ФИО</th>
            <#list workScheduleDtoList as workScheduleDto>
                <th style="width: 12%" class="text-center">${workScheduleDto.getDateString()}</th>
            </#list>
        </tr>
    </thead>
    <tbody>
    <#list institutionWorkScheduleDtoList as institutionWorkScheduleDto>
    <tr>
        <td class = "my-auto p-1">${institutionWorkScheduleDto.fio}</td>
        <#list institutionWorkScheduleDto.workScheduleDtoList as workScheduleDto>
        <td class = "my-0 p-0 day-${workScheduleDto.dayType} text-center">
            <#if workScheduleDto.dayType == 'WORK' || workScheduleDto.dayType == 'PRE_HOLIDAY'>
                ${workScheduleDto.timeBegin} - ${workScheduleDto.timeFinish} <br>
                Часы: ${workScheduleDto.workTime?c}<br>
                Обед: ${workScheduleDto.lunchBreak?c}
            </#if>

        </td>
    </#list>

    </tr>

    </#list>
    </tbody>



</table>


</@c.page>