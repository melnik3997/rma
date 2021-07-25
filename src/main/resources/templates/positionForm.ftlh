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
        <input class="form-control" type="hidden" name="positionId"  <#if positionModel??> value="${positionModel.id}" </#if>>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Название должности</label>
    <div class="col-sm-8">
        <select class="custom-select"  name="postId" required  >
<option value="">Название должности</option>
<#if postList??>
<#list postList as postL>
<option <#if positionModel??> <#if postL.id == positionModel.getPostId()> selected </#if> </#if>
<#if post??> <#if postL.id == post.id> selected </#if> </#if>
value="${postL.id } ">${postL.name}</option>
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
<div class="form-group row">
<button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>

<#if positionModel??>
<form method="post" enctype='multipart/form-data' action="/positionUser/${userId}/delete/${positionModel.id}">
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="enterpriseId" value="${enterprise.id}"/>
    <div class="form-group row">
        <button class="btn btn-secondary " type="submit">Удалить    </button>
    </div>
</form>
</#if>

<script>
        var paramIn = new Map;
        paramIn.set("enterpriseId", <#if enterprise??> ${enterprise.id} <#else> 0 </#if>);
        paramIn.set("lookupName", 'institution');
        paramIn.set("lookupLabel", 'Сотрудник');
        paramIn.set("institutionError", <#if leaderError??> "${institutionError}" <#else> null </#if>);
        paramIn.set("institutionSelectId",<#if institution??>  ${institution.id} <#else> 0 </#if> );
</script>

<script src="/js/institutionLookup.js"> </script>
</@c.page>