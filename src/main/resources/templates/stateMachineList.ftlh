<#import "parts/common.ftlh" as c >
<@c.page>
<div class="row align-items-start">
    <div class="col-4">
        <h5 class=" mb-3 ">Модель состояний ${bidRule.name}</h5>
    </div>
    <div class="col-4">
        <a  type="button" class="btn btn-primary mb-3" href="/bidRule/${bidRule.id?c}/stateMachineList/addState">Добавить состояние</a >
    </div>
    <div class="col-4">
        <a  type="button" class="btn btn-primary mb-3" href="/bidRule/${bidRule.id?c}/stateMachineList/addTransition">Добавить переход</a >
    </div>
</div>
<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Номер</th>
        <th scope="col">Сокращение</th>
        <th scope="col">Наименование</th>
        <th scope="col">Системный тип</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list stateList as state>
    <tr  data-target="#order${state.id?c}" data-toggle="collapse">
        <td>${state.number?c}</td>
        <td>${state.brief}</td>
        <td>${state.name}</td>
        <td>${state.getStateTypeName()}</td>
        <td>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Опции
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="">Открыть</a>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td id="order${state.id?c}" class="card-body  collapse" colspan="6">
            <table class="table">
                <tbody>
                    <#list state.transitionList as transition>
                        <tr>
                            <td>${transition.actionName} (${transition.getActionTypeName()})</td>
                            <td>→</td>
                            <td>${transition.getTargetStateName()} (${transition.getTargetStateTypeName()})</td>
                            <td>
                                <div class="dropdown show">
                                    <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Опции
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        <a class="dropdown-item" href="">Открыть</a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>

        </td>
    </tr>
    </#list>
    </tbody>
</table>
</@c.page>