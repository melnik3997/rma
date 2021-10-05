<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Заявки</h5>

<form method="get" action="/bidCreate"  enctype='multipart/form-data' >
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>

<div class="input-group mb-3">
    <div class="input-group-prepend">
        <label class="input-group-text" for="inputGroupSelect01">Добавить заявку</label>
    </div>
    <select class="custom-select" name="bidRule"  id="inputGroupSelect01" required>
            <option value="">Виды заявок</option>
            <#if bidRuleList??>
                <#list bidRuleList as bidRuleFor>
                    <option value="${bidRuleFor.id?c} ">${bidRuleFor.getName()}</option>
                </#list>
            </#if>
    </select>
    <div class="input-group-append ">
        <button class="btn btn-outline-secondary m-0 " type="submit">Добавить</button>
    </div>
</div>
</form>

<form method="get" action="/bid"  enctype='multipart/form-data' >
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
    <div class="form-row">
        <div class="col-5">
            <div  id="InstitutionLookup2">
            </div>
        </div>

        <div class="col-7">
            <div  id="InstitutionLookup">
            </div>
        </div>
    </div>
    <div class="form-row">
        <div class="col-5">
            <div  id="InstitutionLookup3">
            </div>
        </div>
        <div class="col-5">
            <button type="submit" class="btn btn-primary">Найти</button>
        </div>
    </div>

</form>

<table class="table table-hover mb-3">
    <thead>
    <tr>
        <th scope="col">Вид заявки</th>
        <th scope="col">Сотрудник</th>
        <th scope="col">Автор</th>
        <th scope="col">Ответсвенный</th>
        <th scope="col">Текущее состояние</th>
    </tr>
    </thead>
    <tbody>
    <#list dealObjectList as dealObject>
    <tr data-target="#order${dealObject.id?c}" data-toggle="collapse">
        <td>${dealObject.getBidRuleName()}</td>
        <td>${dealObject.getEmployeeFIO()}</td>
        <td>${dealObject.getAuthorFIO()}</td>
        <td>${dealObject.getResponsibleFIO()}</td>
        <td>${dealObject.getProtocolStateName()}</td>
    </tr>
    <tr>
        <td id="order${dealObject.id?c}" class="card-body  collapse" colspan="6">
            <div class="row align-items-start">
                <div class="col-4">
                    <h6 class=" mb-3 ">Выполнение дейсвия</h6>
                </div>
                <div class="col-4">
                    <a  type="button" class="btn btn-primary mb-3" href="">Откатить дейсвие</a >
                </div>
                <div class="col-4">
                    <div class="dropdown show">
                        <a class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Выполнить действие
                        </a>
                        <#list dealObject.availableTransitionList as availableTransition>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="/bid/${dealObject.id?c}/action/${availableTransition.id?c}">${availableTransition.actionName}</a>
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
            <table class="table">
                <thead class="table-primary">
                <tr>
                    <th scope="col">Состояние</th>
                    <th scope="col">Действие</th>
                    <th scope="col">Пользователь</th>
                    <th scope="col">Время и дата</th>
                </tr>
                </thead>
                <tbody class="table-primary">
                <#list dealObject.protocolList as protocol>
                <tr>
                    <td>${protocol.getTransitionTargetStateName()}</td>
                    <td>${protocol.getTransitionActionName()}</td>
                    <td>${protocol.getUserName()}</td>
                    <td>${protocol.dateProtocol}</td>

                </tr>
                </#list>
                </tbody>
            </table>

        </td>
    </tr>

    </#list>
    </tbody>
</table>
<script>
        var paramInstitution2 = new Map;
        paramInstitution2.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramInstitution2.set("lookupName", 'employee');
        paramInstitution2.set("lookupLabel", 'Сотрудник');
        paramInstitution2.set("institutionError", <#if leaderError??> "${institutionError}" <#else> null </#if>);
        paramInstitution2.set("institutionSelectId",<#if employee??>  ${employee.id} <#else> 0 </#if> );
        paramInstitution2.set("institutionValueName", "id");

        var paramInstitution = new Map;
        paramInstitution.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramInstitution.set("lookupName", 'responsible');
        paramInstitution.set("lookupLabel", 'Ответственный');
        paramInstitution.set("institutionError", <#if leaderError??> "${institutionError}" <#else> null </#if>);
        paramInstitution.set("institutionSelectId",<#if responsible??>  ${responsible.id} <#else> 0 </#if> );
        paramInstitution.set("institutionValueName", "id");

        var paramInstitution3 = new Map;
        paramInstitution3.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramInstitution3.set("lookupName", 'author');
        paramInstitution3.set("lookupLabel", 'Автор');
        paramInstitution3.set("institutionError", <#if leaderError??> "${institutionError}" <#else> null </#if>);
        paramInstitution3.set("institutionSelectId",<#if author??>  ${author.id} <#else> 0 </#if> );
        paramInstitution3.set("institutionValueName", "id");


</script>
<script src="/js/institutionLookup.js"> </script>
<script src="/js/institutionLookup2.js"> </script>
<script src="/js/institutionLookup3.js"> </script>


</@c.page>