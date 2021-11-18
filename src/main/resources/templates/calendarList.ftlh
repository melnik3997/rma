<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Календари предприятия ${enterprise.name}</h5>

<a  type="button" class="btn btn-primary mb-3" href="/calendarAdd/${enterprise.id?c}">Добавить календарь</a >
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Год</th>
        <th scope="col">Активный</th>
        <th scope="col">Тип</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list calendarList as calendar>
    <tr>
        <td>${calendar.yearInt?c}</td>
        <td><#if calendar.active> Да <#else> Нет </#if> </td>
        <td>${calendar.getCalendarTypeString()}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="/calendar/${calendar.id?c}">Открыть</a>
                </div>
            </div>
        </td>
    </tr>

    </#list>
    </tbody>
</table>
</@c.page>