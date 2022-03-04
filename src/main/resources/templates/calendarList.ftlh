<#import "parts/common.ftlh" as c >
<#import "parts/pager.ftlh" as p>
<@c.page>
    <nav aria-label="breadcrumb alert-light">
        <ol class="breadcrumb alert-light pl-0">
            <li class="breadcrumb-item"><a href="/enterprise">Предприятия</a></li>
            <li class="breadcrumb-item active" aria-current="page">Календари</li>
        </ol>
    </nav>
    <h5 class=" mb-3 ">Календари предприятия ${enterprise.name}</h5>

    <a type="button" class="btn btn-primary mb-3" href="/calendarAdd/${enterprise.id?c}">Добавить календарь</a>
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
        <#list calendarList.content as calendar>
            <tr>
                <td>${calendar.yearInt?c}</td>
                <td><#if calendar.active> Да <#else> Нет </#if> </td>
                <td>${calendar.getCalendarTypeString()}</td>
                <td>
                    <div class="dropdown show">
                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
    <@p.pager calendarList url />
</@c.page>