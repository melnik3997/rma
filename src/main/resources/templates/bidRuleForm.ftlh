<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Правило заявки</h5>
<#if deleteError??>
<div class="alert alert-danger" role="alert">
    ${deleteError}
</div>
</#if>
<form method="post" enctype='multipart/form-data' >
    <div class="form-group">
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input class="form-control" type="hidden" name="enterprise"  <#if enterprise??> value="${enterprise.id?c}" </#if>>

</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Наименование</label>
    <div class="col-sm-8">
        <input class="form-control ${(nameError??)?string('is-invalid','')}" required id = "name" type="text" name="name" placeholder="Наименование" <#if bidRuleModel??> value="${bidRuleModel.name}" <#else> <#if name??> value="${name}" </#if> </#if>>
<#if nameError??>
<div class="invalid-feedback">${nameError}</div>
</#if>
</div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Системный тип заявки</label>
    <div class="col-sm-8">
        <select class="custom-select" name="bidType"  required>
            <option value="">Системный тип заявки</option>
            <#if bidTypeList??>
            <#list bidTypeList as bidTypeFor>
            <option <#if bidRuleModel??> <#if bidTypeFor == bidRuleModel.bidType> selected </#if> </#if>
                      <#if bidType??> <#if bidTypeFor == bidType> selected </#if> </#if>
                  value="${bidTypeFor} ">${bidTypeFor.getName()}</option>
</#list>
</#if>
</select>

<#if bidTypeError??>
<div class="invalid-feedback">${bidTypeError}</div>
</#if>
</div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Организация</label>
    <div class="col-sm-8">
        <select class="custom-select"  name="enterprise" required <#if enterpriseDisabled == true> disabled </#if>>
    <option value="">Организация</option>
    <#if enterpriseList??>
    <#list enterpriseList as enterpriseFor>
    <option <#if enterprise??> <#if enterpriseFor.id == enterprise.id> selected </#if> </#if> value="${enterpriseFor.id?c} ">${enterpriseFor.name}</option>
</#list>
</#if>
</select>

<#if enterpriseError??>
<div class="invalid-feedback">${enterpriseError}</div>
</#if>
</div>
</div>

<div class="form-group row">
    <button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>

</@c.page>