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


</@c.page>