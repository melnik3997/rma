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
                <th class="text-center" scope="col">График</th>
                <th class="text-center" scope="col">Списания</th>
            </tr>
            </thead>
            <tbody>
            <#list institutionDtoList as institutionDto>
                <tr>
                    <td>${institutionDto.getFullName()}</td>
                    <td>${institutionDto.getPositionName()}</td>
                    <td class="text-center"><#if institutionDto.workNow> Да <#else> Нет </#if></td>
                    <td class="text-center"><#if institutionDto.startWork??>${institutionDto.startWork} </#if></td>
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
                    <td class="text-center">${institutionDto.sumActualluWork} <strong>/</strong> ${institutionDto.getWorkTime()}</td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
    <hr>
    <div class="col-8">
        <h5 class="mb-3 ">Списания за неделю </h5>
    </div>
    <div id="lineChartActuallyWork">
        <line-chart></line-chart>
    </div>
    <div class="col-8">
        <h5 class="mb-3 ">Присутсвие за неделю </h5>
    </div>
    <div id="lineChartPresenceWorkTime">
        <line-chart></line-chart>
    </div>
    <script>
        var subdivisionParam = <#if subdivision??> ${subdivision.id?c}
        <#else>
        0
        </#if>
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
    <script src="https://unpkg.com/vue-chartjs/dist/vue-chartjs.min.js"></script>
    <script src="/js/chart/lineChartActuallyWork.js"></script>
    <script src="/js/chart/lineChartPresenceWorkTime.js"></script>
</@c.page>