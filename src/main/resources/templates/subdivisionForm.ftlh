<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Подразделение</h5>
<#if deleteError??>
<div class="alert alert-danger" role="alert">
  ${deleteError}
</div>
</#if>
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
          <#list parentList as parentL>
          <option <#if subdivisionModel??> <#if parentL.id == subdivisionModel.getParentId()> selected </#if> </#if>
                    <#if parent??> <#if parentL.id == parent.id> selected </#if> </#if>
                        value="${parentL.id } ">${parentL.name}</option>
          </#list>
           </#if>
        </select>

       <#if parentIdError??>
         <div class="invalid-feedback">${parentIdError}</div>
       </#if>
      </div>
    </div>
    <div id="InstitutionLookup">
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
<div class="form-group row">
  <button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>
<#if subdivisionModel??>
<form method="post" enctype='multipart/form-data' action="/subdivisionEnterprise/${enterprise.id}/delete/${subdivisionModel.id}">
  <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
  <input type="hidden" name="enterpriseId" value="${enterprise.id}"/>
  <div class="form-group row">
    <button class="btn btn-secondary " type="submit">Удалить    </button>
  </div>
</form>
</#if>
<script>
        var paramInstitution = new Map;
        paramInstitution.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramInstitution.set("lookupName", 'leaderId');
        paramInstitution.set("lookupLabel", 'Управляющий');
        var t =  <#if leaderError??> "${leaderError}" <#else> null </#if>;
        paramInstitution.set("institutionError", t);
        paramInstitution.set("institutionSelectId",<#if institutionLeader??>  ${institutionLeader.id} <#else> 0 </#if> );
</script>

<script src="/js/institutionLookup.js"> </script>
</@c.page>