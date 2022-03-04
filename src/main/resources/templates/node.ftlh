<#import "parts/common.ftlh" as c >
<@c.page>
    <nav aria-label="breadcrumb alert-light">
        <ol class="breadcrumb alert-light  pl-0">
            <li class="breadcrumb-item"><a href="/enterprise">Предприятия</a></li>
            <li class="breadcrumb-item active" aria-current="page">Подразделения</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-8">
            <h5 class=" mb-3 ">Структура <#if enterprise??> ${enterprise.name}  <#else> организации </#if> </h5>
        </div>
        <div class="col-4">
            <a type="button" class="btn btn-primary mb-3" href="/subdivisionEnterprise/add/${enterprise.id?c}">Добавить
                подразделение</a>
        </div>
    </div>
    <div class="container">

        <div class="row">
            <div class="col mt-5">
                <table id="app">
                </table>
            </div>
        </div>

    </div>
    <script>
        var enterpriseParam = <#if enterprise??> ${enterprise.id?c}
        <#else>
        0
        </#if>
    </script>
    <script src="/js/node.js"></script>

</@c.page>