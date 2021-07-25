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
        <input class="form-control" type="hidden" name="postId"  <#if postModel??> value="${postModel.id}" </#if>>
</div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Наименование</label>
        <div class="col-sm-8">
            <input class="form-control ${(nameError??)?string('is-invalid','')}" id="name" type="text" name="name"
                   placeholder="Наименование" <#if postModel??> value="${postModel.name}" <#else> <#if name??> value="${name}"</#if></#if>>
    <#if nameError??>
        <div class="invalid-feedback">${nameError}</div>
    </#if>
</div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Системный тип должности</label>
    <div class="col-sm-8">
        <select class="custom-select" name="postType"  required>
        <option value="">Системный тип должности</option>
        <#if postTypeList??>
            <#list postTypeList as postTypeFor>
                <option <#if postModel??> <#if postTypeFor == postModel.postType> selected </#if> </#if>
                        <#if postType??> <#if postTypeFor == postType> selected </#if> </#if>
                         value="${postTypeFor} ">${postTypeFor.getName()}</option>
            </#list>
        </#if>
        </select>

        <#if postTypeError??>
            <div class="invalid-feedback">${postTypeError}</div>
        </#if>
    </div>
</div>

<div class="form-group row">
    <label class="col-sm-2 col-form-label">Уровень должности</label>
    <div class="col-sm-8">
        <select class="custom-select" name="postLevel"  required>
            <option value="">Уровень должности</option>
            <#if postLevelList??>
                <#list postLevelList as postLevelFor>
                    <option <#if postModel??> <#if postLevelFor == postModel.postLevel> selected </#if> </#if>
                            <#if postLevel??> <#if postLevel == postLevelFor> selected </#if> </#if>
                            value="${postLevelFor} ">${postLevelFor.getName()}</option>
                </#list>
            </#if>
</select>

<#if postLevelError??>
<div class="invalid-feedback">${postLevelError}</div>
</#if>
</div>
</div>

<div class="form-group row">
<button class="btn btn-primary" type="submit">Сохранить</button>
</div>
</form>
<#if postModel??>
<form method="post" enctype='multipart/form-data' action="/postDelete">
    <input class="form-control" type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="postId" value="${postModel.id}"/>
    <div class="form-group row">
        <button class="btn btn-secondary " type="submit">Удалить    </button>
    </div>
</form>
</#if>

</@c.page>