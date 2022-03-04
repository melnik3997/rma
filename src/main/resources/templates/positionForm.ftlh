<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Должность</h5>
<#if deleteError??>
<div class="alert alert-danger" role="alert">
    ${deleteError}
</div>
</#if>
<form method="post" enctype='multipart/form-data' >
    <div class="form-group">
        <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input class="form-control" type="hidden" name="positionId"  <#if positionModel??> value="${positionModel.id?c}" </#if>>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Название должности</label>
    <div class="col-sm-8">
        <select class="custom-select"  name="post" required  >
<option value="">Название должности</option>
<#if postList??>
<#list postList as postL>
<option <#if positionModel??> <#if postL.id == positionModel.getPostId()> selected </#if> </#if>
<#if post??> <#if postL.id == post.id> selected </#if> </#if>
value="${postL.id?c} ">${postL.name}</option>
</#list>
</#if>
</select>

<#if postIdError??>
<div class="invalid-feedback">${postIdError}</div>
</#if>
</div>
</div>

<div id="InstitutionLookup">
</div>

<div id="subdivisionLookup">
</div>

<div class="form-group">
    <div class="form-check">
        <input class="form-check-input" type="checkbox" id="general" name="general">
        <label class="form-check-label" for="general">
            Основная
        </label>
    </div>
</div>

<div class="form-group row">
<button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>

<#if positionModel??>
<form method="post" enctype='multipart/form-data' action="/positionUser/${userId?c}/delete/${positionModel.id?c}">
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="enterpriseId" value="${enterprise.id?c}"/>
    <div class="form-group row">
        <button class="btn btn-secondary " type="submit">Удалить    </button>
    </div>
</form>
</#if>

<script>
        var paramInstitution = new Map;
        paramInstitution.set("enterpriseId", <#if enterprise??> ${enterprise.id?c} <#else> 0 </#if>);
        paramInstitution.set("lookupName", 'institution');
        paramInstitution.set("lookupLabel", 'Сотрудник');
        paramInstitution.set("institutionError", <#if leaderError??> "${institutionError}" <#else> null </#if>);
        paramInstitution.set("institutionSelectId",<#if institution??>  ${institution.id?c} <#else> 0 </#if> );
        paramInstitution.set("institutionDisable", true);

        var paramSubdivision = new Map;
        paramSubdivision.set("enterpriseId", <#if enterprise??> ${enterprise.id?c} <#else> 0 </#if>);
        paramSubdivision.set("lookupName", 'subdivision');
        paramSubdivision.set("lookupLabel", 'Подразделение');
        paramSubdivision.set("subdivisionError", <#if subdivisionError??> "${subdivisionError}" <#else> null </#if>);
        paramSubdivision.set("subdivisionSelectId",<#if subdivision??>  ${subdivision.id?c} <#else> 0 </#if> );
        paramSubdivision.set("subdivisionRequired", true);
</script>

<script src="/js/institutionLookup.js"> </script>
<script src="/js/subdivisionLookup.js"> </script>
</@c.page>