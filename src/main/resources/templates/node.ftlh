<#import "parts/common.ftlh" as c >
<@c.page>
<div class="row">
    <div class="col-8">
        <h5 class=" mb-3 ">Структура <#if enterprise??> ${enterprise.name}  <#else> организации </#if> </h5>
    </div>
    <div class="col-4">
        <a  type="button" class="btn btn-primary mb-3" href="/subdivisionEnterprise/add/${enterprise.id?c}">Добавить подразделение</a >
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

<script src="/js/node.js"></script>
<script>

</script>
</@c.page>