<#import "parts/common.ftlh" as c >
<@c.page>

    <div class="row align-items-start">
        <div class="col-8">
            <h3 class="mb-3 ">Сотрудники</h3>
        </div>
        <div class="col-8">
            <h5 class="mb-3 ">Подразделение ${subdivision.name} </h5>
        </div>
    </div>

    <div class="row align-items-center">
        <table class="table table-hover mb-3">
            <thead>
            <tr>
                <th scope="col">ФИО</th>
                <th scope="col">Должность</th>
                <th scope="col">Присутсвие</th>
                <th scope="col">Начало работы</th>
                <th scope="col">График</th>
                <th scope="col">Списания</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <#list institutionDtoList as institutionDto>
                <tr>
                    <td>${institutionDto.getFullName()}</td>
                    <td>${institutionDto.getPositionName()}</td>
                    <td><#if institutionDto.workNow> Да <#else> Нет </#if></td>
                    <td><#if institutionDto.startWork??>${institutionDto.startWork} </#if></td>
                    <td class = "my-0 p-0 day-${institutionDto.getWorkScheduleDtoDayType()} text-center">
                        <#if institutionDto.getWorkScheduleDtoTimeBegin()??>
                            <#if institutionDto.getWorkScheduleDtoDayType() == 'WORK' || institutionDto.getWorkScheduleDtoDayType() == 'PRE_HOLIDAY'>
                                ${institutionDto.getWorkScheduleDtoTimeBegin()} - ${institutionDto.getWorkScheduleDtoTimeFinish()}
                                <br>
                                Часы: ${institutionDto.getWorkScheduleDtoWorkTime()?c}<br>
                                Обед: ${institutionDto.getWorkScheduleDtoLunchBreak()?c}<br>
                                Отработано: ${institutionDto.presenceWorkTimeSum?c}
                            </#if>
                            <#else>
                            Отсутсвует информация
                        </#if>
                    </td>
                    <td>${institutionDto.sumActualluWork}</td>
                    <td>
                        <div class="dropdown show">
                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Опции
                            </a>

                        </div>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
    <hr>
    <div class="row align-items-end">
        <div class="col">
            <h5 class=" mb-3 "> Нарушение режима работы </h5>
            <table class="table table-hover mb-3">
                <thead>
                <tr>
                    <th scope="col">Название должности</th>
                    <th scope="col">Подразделение</th>
                    <th scope="col">Основная</th>
                    <th scope="col">Дата начала</th>
                    <th scope="col">Дата окончания</th>
                </tr>
                </thead>
                <tbody>
                <#list positionListDis as position>
                    <tr>
                        <td>${position.getPostName()}</td>
                        <td>${position.getSubdivisionName()}</td>
                        <td><#if position.general> Да <#else> Нет </#if> </td>
                        <td>${position.getDateStartString()}</td>
                        <td>${position.getDateEndString()}</td>
                    </tr>
                </#list>
            </table>
        </div>
    </div>
</@c.page>