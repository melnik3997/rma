<#import "parts/common.ftlh" as c >
<#import "parts/pager.ftlh" as p>
<@c.page>
    <div class="row mb-2">
        <div class="col-7">
            <h5 class="mb-3">Закртие рабочих дней</h5>
        </div>
        <#if error??>
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </#if>
        <div class="col-4">
            <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button"
               aria-expanded="false"
               aria-controls="collapseExample">
                Закрыть день
            </a>
        </div>
    </div>
    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="form-group">
            <form method="get" action="/managerPanelClose" enctype='multipart/form-data'>
                <div class="row">
                    <div class="form-group row col-5">
                        <label class="col-sm-5 col-form-label">Дата закрытия</label>
                        <div class="col-sm-5">
                            <input class="form-control " type="text" name="dateClose" placeholder="Дата закрытия"
                                   id="dateClose">
                        </div>
                    </div>
                    <div class="col-5">
                        <button class="btn btn-primary" type="submit">Добавить</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <form method="get" action="/managerPanel"  enctype='multipart/form-data' >
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div class="form-row">
            <div class="form-group row col-5">
                <label class="col-sm-5 col-form-label">Дата начала</label>
                <div class="col-sm-5">
                    <input class="form-control " type="text" name="dateBegin" placeholder="Дата начала"  id="dateBegin" >
                </div>
            </div>
            <div class="form-group row col-5">
                <label class="col-sm-5 col-form-label">Дата окончания</label>
                <div class="col-sm-5">
                    <input class="form-control " type="text" name="dateEnd" placeholder="Дата окончания"  id="dateEnd" >
                </div>
            </div>
            <div class="col-2">
                <button type="submit" class="btn btn-primary">Найти</button>
            </div>
        </div>
    </form>

    <table class="table table-hover mb-3">
        <thead>
        <tr>
            <th scope="col">Месяц</th>
            <th scope="col">Дата</th>
            <th scope="col">День недели</th>
            <th scope="col">Дата закрытия</th>
            <th scope="col">Сотрудник</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <#list calendarCloseDtoPage.content as calendarCloseDto>
            <tr>
                <td>${calendarCloseDto.calendarMonthInt}</td>
                <td>${calendarCloseDto.calendarDateD} </td>
                <td>${calendarCloseDto.getCalendarDayWeekName()} </td>
                <td>${calendarCloseDto.dateProtocol}</td>
                <td>${calendarCloseDto.institutionFullName}</td>
                <td>
                    <div class="dropdown show">
                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Отчеты
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item"
                               href="/report/spisaniya-sotrudnikov/${calendarCloseDto.id?c}">Списания сотрудников за день</a>
                            <a class="dropdown-item"
                               href="/report/ne-dostatochnye-spisaniya/${calendarCloseDto.id?c}">Не достаточные списания</a>
                        </div>
                    </div>
                </td>
            </tr>

        </#list>
        </tbody>
    </table>
    <@p.pager calendarCloseDtoPage url />
    <script type="text/javascript">

        jQuery.datetimepicker.setLocale('ru');
        $('#dateBegin').datetimepicker({
            timepicker: false,
            datepicker: true,
            format: 'd.m.Y'
            <#if dateBegin??> ,value:"${dateBegin}" </#if>
            ,mask: true,
            locale: 'ru',
            dayOfWeekStart: 1
        });
        $('#dateEnd').datetimepicker({
            timepicker: false,
            datepicker: true,
            format: 'd.m.Y'
            <#if dateEnd??> ,value:"${dateEnd}" </#if>
            ,mask: true,
            locale: 'ru',
            dayOfWeekStart: 1
        });
        $('#dateClose').datetimepicker({
            timepicker: false,
            datepicker: true,
            format: 'd.m.Y'
            <#if dateClose??> ,value:"${dateClose}" </#if>
            ,mask: true,
            locale: 'ru',
            dayOfWeekStart: 1
        });


    </script>
</@c.page>