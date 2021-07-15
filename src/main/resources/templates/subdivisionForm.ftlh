<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Подразделение</h5>

<form method="post" enctype='multipart/form-data' >
  <div class="form-group">
      <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
      <input class="form-control" type="hidden" name="enterprise"  <#if enterprise??> value="${enterprise.id}" </#if>>
      <input class="form-control" type="hidden" name="subdivisionId"  <#if subdivisionModel??> value="${subdivisionModel.id}" </#if>>
  </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Сокращение</label>
      <div class="col-sm-8">
        <input class="form-control ${(briefError??)?string('is-invalid','')}" id = "brief" type="text" name="brief" placeholder="Сокращение" <#if subdivisionModel??> value="${subdivisionModel.brief}"<#else> <#if brief??> value="${brief}" </#if> </#if>>
        <#if briefError??>
          <div class="invalid-feedback">${briefError}</div>
        </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Наименование</label>
      <div class="col-sm-8">
        <input class="form-control ${(nameError??)?string('is-invalid','')}" id = "name" type="text" name="name" placeholder="Наименование" <#if subdivisionModel??> value="${subdivisionModel.name}" <#else> <#if name??> value="${name}" </#if> </#if>>
         <#if nameError??>
           <div class="invalid-feedback">${nameError}</div>
         </#if>
      </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Вышестоящее подразделение</label>
      <div class="col-sm-8">
        <select class="custom-select"  name="parentId" <#if parentRequired == true> required </#if> <#if parentDisabled??> disabled </#if> >
          <option value="">Вышестоящее подразделение</option>
          <#if parentList??>
          <#list parentList as parent>
          <option <#if subdivisionModel??> <#if parent.id == subdivisionModel.getParentId()> selected </#if> </#if> value="${parent.id } ">${parent.name}</option>
          </#list>
           </#if>
        </select>

       <#if institutionIdError??>
         <div class="invalid-feedback">${institutionIdError}</div>
       </#if>
      </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Управляющий</label>
      <div class="col-sm-8">
        <select class="custom-select"  name="leaderId" required>
          <option value="">Управляющий</option>
          <#if institutionList??>
          <#list institutionList as institution>
          <option <#if subdivisionModel??> <#if institution.getUserId() == subdivisionModel.getUserId()> selected </#if> <#else> </#if> <#if leader??> <#if institution.getUserId() == leader.id> selected </#if> </#if>
          value="${institution.getUserId() } ">${institution.getFullName()}</option>
    </#list>
    </#if>
    </select>

     <#if institutionIdError??>
     <div class="invalid-feedback">${institutionIdError}</div>
     </#if>
     </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 col-form-label">Организация</label>
      <div class="col-sm-8">
        <select class="custom-select"  name="enterpriseId" required <#if enterpriseDisabled == true> disabled </#if>>
          <option value="">Организация</option>
            <#if enterpriseList??>
              <#list enterpriseList as enterpriseFor>
                <option <#if enterprise??> <#if enterpriseFor.id == enterprise.id> selected </#if> </#if> value="${enterpriseFor.id} ">${enterpriseFor.name}</option>
              </#list>
            </#if>
        </select>

        <#if enterpriseIdError??>
          <div class="invalid-feedback">${enterpriseIdError}</div>
        </#if>
      </div>
    </div>

  <button class="btn btn-primary" type="submit">Сохранить</button>
</form>
<!--
<#if subdivisionModelId??>
<form method="post" enctype='multipart/form-data'  >
  <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  <input type="hidden" name="subdivisionId" value="${subdivisionModelId}"/>
  <button class="btn btn-secondary" type="submit">Удалить</button>
</form>
</#if>
-->
</@c.page>