<#import "parts/common.ftlh" as c >
<@c.page>

<div class="row align-items-start">
    <div class="col-8">
        <h5 class="mb-3 ">График работы <#if institution??> ${institution.getFullName()}</#if> </h5>
    </div>
    <div class="col-4">
        <a type="button" class="btn btn-primary mb-3 float-right" href="/workSchedule/${institution.id}">Изменить график</a>
    </div>
</div>

<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Время начала</th>
        <th scope="col">Время окнончания</th>
        <th scope="col">Активный</th>
        <th scope="col">Рабочее время</th>
        <th scope="col">Обеденное время</th>
        <th scope="col">Время обеда входит в рабочее время</th>
    </tr>
    </thead>
    <tbody>
    <#list workScheduleList as workSchedule>
    <tr>
        <td>${workSchedule.timeBegin}</td>
        <td>${workSchedule.timeFinish}</td>
        <td><#if workSchedule.active> Да <#else> Нет </#if> </td>
        <td>${workSchedule.workTime?c}</td>
        <td>${workSchedule.lunchBreak?c}</td>
        <td><#if workSchedule.lunchBreakIn> Да <#else> Нет </#if> </td>
    </tr>

    </#list>
    </tbody>
</table>
</@c.page>