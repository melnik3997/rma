<#import "parts/common.ftlh" as c >
<@c.page>
    <nav aria-label="breadcrumb alert-light">
        <ol class="breadcrumb alert-light  pl-0">
            <li class="breadcrumb-item"><a href="/enterprise">Предприятия</a></li>
            <li class="breadcrumb-item active" aria-current="page">Правила заявок</li>
        </ol>
    </nav>

    <div class="row align-items-start">
        <div class="col-8">
            <h5 class="mb-3 ">Правила заявок <#if enterprise??> ${enterprise.name}</#if> </h5>
        </div>
        <div class="col-4">
            <a type="button" class="btn btn-primary mb-3 float-right"
               href="/enterprise/${enterprise.id?c}/bidRuleList/add">Добавить правило заявок</a>
        </div>
    </div>

    <#if activeError??>
        <div class="alert alert-danger" role="alert">
            ${activeError}
        </div>
    </#if>

    <div class="row align-items-center">
        <table class="table table-hover mb-3">
            <thead>
            <tr>
                <th scope="col">Название</th>
                <th scope="col">Тип заявки</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <#list bidRuleActiveList as bidRule>
                <tr>
                    <td>${bidRule.name}</td>
                    <td>${bidRule.getBidTypeName()}</td>
                    <td>
                        <div class="dropdown show">
                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Опции
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="/bidRule/${bidRule.id?c}/stateMachineList">Модель
                                    состояний</a>
                                <a class="dropdown-item" href="/bidRule/${bidRule.id?c}/deactivate">Диактивировать</a>
                            </div>
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
            <h5 class=" mb-3 ">Отключеные</h5>
            <table class="table table-hover mb-3">
                <thead>
                <tr>
                    <th scope="col">Название</th>
                    <th scope="col">Тип заявки</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <#list bidRuleUnActiveList as bidRule>
                    <tr>
                        <td>${bidRule.name}</td>
                        <td>${bidRule.getBidTypeName()}</td>
                        <td>
                            <div class="dropdown show">
                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                   id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                   aria-expanded="false">
                                    Опции
                                </a>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    <a class="dropdown-item" href="/bidRule/${bidRule.id?c}/stateMachineList">Модель
                                        состояний</a>
                                    <a class="dropdown-item" href="/bidRule/${bidRule.id?c}/active">Активировать</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </#list>
            </table>
        </div>
    </div>
</@c.page>