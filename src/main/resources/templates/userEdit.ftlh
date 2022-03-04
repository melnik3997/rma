<#import "parts/common.ftlh" as c >
<@c.page>
    <h5 class=" mb-3 ">Редактирование пользователя</h5>

    <form action="/user" method="post" enctype='multipart/form-data'>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Имя пользователя</label>
            <div class="col-sm-8">
                <input class="form-control ${(userNameError??)?string('is-invalid','')}" type="text" name="username"
                       placeholder="Имя пользователя" <#if user??> value="${user.username}"<#else> <#if username??>
                       value="${username}" </#if> </#if>">
                <#if userNameError??>
                    <div class="invalid-feedback">${userNameError}</div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-sm-2">Роли пользователя</div>
            <div class="col-sm-10">
                <#list roles as role>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="${role}"
                               id="${role}" ${user.role?seq_contains(role)?string("checked", "")}>
                        <label class="form-check-label" for="${role}">
                            ${role}
                        </label>
                    </div>
                </#list>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <input type="hidden" name="userId" value="${user.id?c}"/>
        <button class="btn btn-primary"  type="submit">Сохранить</button>
    </form>
</@c.page>