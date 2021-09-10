<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Переход по состоянию</h5>
<#if deleteError??>
<div class="alert alert-danger" role="alert">
    ${deleteError}
</div>
</#if>
<form method="post" enctype='multipart/form-data' >
    <div class="form-group">
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input class="form-control" type="hidden" name="bidRule"  <#if bidRule??> value="${bidRule.id?c}" </#if>>

    </div>

    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Правило заявки</label>
        <div class="col-sm-8">
            <select class="custom-select ${(bidRuleError??)?string('is-invalid','')}"  name="bidRule" required <#if bidRuleDisabled??> <#if bidRuleDisabled == true> disabled </#if> </#if>>
                <option value="">Правило заявки</option>
                <#if bidRuleList??>
                    <#list bidRuleList as bidRuleFor>
                        <option <#if bidRule??> <#if bidRuleFor.id == bidRule.id> selected </#if> </#if> value="${bidRuleFor.id?c} ">${bidRuleFor.name}</option>
                    </#list>
                </#if>
            </select>

            <#if bidRuleError??>
                <div class="invalid-feedback">${bidRuleError}</div>
            </#if>
        </div>
    </div>


    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Состояние источник</label>
        <div class="col-sm-8">
            <select class="custom-select ${(sourceStateError??)?string('is-invalid','')}" name="sourceState"  required>
                <option value="">Состояние источник</option>
                <#if sourceStateList??>
                    <#list sourceStateList as sourceStateFor>
                        <option <#if transitionModel??> <#if sourceStateFor.id?c == transitionModel.getSourceStateId()?c> selected </#if> </#if>
                        <#if sourceState??> <#if sourceStateFor.id?c == sourceState.id?c> selected </#if> </#if>
                        value="${sourceStateFor.id?c}">${sourceStateFor.name}</option>
                    </#list>
                </#if>
                </select>
            <#if sourceStateError??>
                <div class="invalid-feedback">${sourceStateError}</div>
            </#if>
        </div>
    </div>


    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Системный тип действия</label>
        <div class="col-sm-8">
            <select class="custom-select ${(actionTypeError??)?string('is-invalid','')}" name="actionType"  required>
                <option value="">Системный тип действия</option>
                <#if actionTypeList??>
                    <#list actionTypeList as actionTypeFor>
                        <option <#if transitionModel??> <#if actionTypeFor == transitionModel.actionType> selected </#if> </#if>
                        <#if actionType??> <#if actionTypeFor == actionType> selected </#if> </#if>
                        value="${actionTypeFor} ">${actionTypeFor.getName()}</option>
                    </#list>
                </#if>
            </select>
            <#if actionTypeError??>
                <div class="invalid-feedback">${actionTypeError}</div>
            </#if>
        </div>
    </div>


    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Наименование действия</label>
        <div class="col-sm-8">
            <input class="form-control ${(actionNameError??)?string('is-invalid','')}" required id = "actionName" type="text" name="actionName" placeholder="Наименование действия" <#if transitionModel??> value="${transitionModel.brief}" <#else> <#if name??> value="${name}" </#if> </#if>>
            <#if actionNameError??>
                <div class="invalid-feedback">${actionNameError}</div>
            </#if>
        </div>
    </div>


    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Целевое состояние</label>
        <div class="col-sm-8">
            <select class="custom-select" name="targetState"  required>
                <option value="">Целевое состояние</option>
                <#if targetStateList??>
                    <#list targetStateList as targetStateFor>
                        <option <#if transitionModel??> <#if targetStateFor.id?c == transitionModel.getTargetStateId()?c> selected </#if> </#if>
                        <#if targetState??> <#if targetStateFor.id?c == targetState.id?c> selected </#if> </#if>
                        value="${targetStateFor.id?c} ">${targetStateFor.name}</option>
                    </#list>
                </#if>
            </select>
            <#if bidTypeError??>
                <div class="invalid-feedback">${bidTypeError}</div>
            </#if>
        </div>
    </div>

    <div id="InstitutionLookup">
    </div>

    <div class="form-group row">
        <button class="btn btn-primary" type="submit">Сохранить</button>
    </div>
</form>


<script>
        var paramInstitution = new Map;
        paramInstitution.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramInstitution.set("lookupName", 'institution');
        paramInstitution.set("lookupLabel", 'Ответственный за целевое состояние');
        var t =  <#if institutionError??> "${institutionError}" <#else> null </#if>;
        paramInstitution.set("institutionError", t);
        paramInstitution.set("institutionSelectId",<#if institutionLeader??>  ${institutionLeader.id} <#else> 0 </#if> );
        paramInstitution.set("institutionValueName", "id");
</script>

<script src="/js/institutionLookup.js"> </script>

</@c.page>