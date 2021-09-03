<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Состояние</h5>
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
        <label class="col-sm-2 col-form-label">Системный тип состояния</label>
        <div class="col-sm-8">
            <select class="custom-select" name="stateType"  required>
                <option value="">Системный тип состояния</option>
                <#if stateTypeList??>
                    <#list stateTypeList as stateTypeFor>
                        <option <#if stateModel??> <#if stateTypeFor == stateModel.stateType> selected </#if> </#if>
                        <#if stateType??> <#if stateTypeFor == stateType> selected </#if> </#if>
                        value="${stateTypeFor} ">${stateTypeFor.getName()}</option>
                    </#list>
                </#if>
            </select>
            <#if bidTypeError??>
            <div class="invalid-feedback">${bidTypeError}</div>
            </#if>
        </div>
    </div>

    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Сокращение</label>
        <div class="col-sm-8">
            <input class="form-control ${(briefError??)?string('is-invalid','')}" required id = "brief" type="text" name="brief" placeholder="Сокращение" <#if stateModel??> value="${stateModel.brief}" <#else> <#if brief??> value="${brief}" </#if> </#if>>
            <#if briefError??>
                <div class="invalid-feedback">${briefError}</div>
            </#if>
        </div>
    </div>


    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Наименование</label>
        <div class="col-sm-8">
            <input class="form-control ${(nameError??)?string('is-invalid','')}" required id = "name" type="text" name="name" placeholder="Наименование" <#if stateModel??> value="${stateModel.brief}" <#else> <#if name??> value="${name}" </#if> </#if>>
            <#if nameError??>
                <div class="invalid-feedback">${nameError}</div>
            </#if>
        </div>
    </div>



    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Правило заявки</label>
        <div class="col-sm-8">
            <select class="custom-select"  name="bidRule" required <#if bidRuleDisabled??> <#if bidRuleDisabled == true> disabled </#if> </#if>>
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
    <button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>

</@c.page>