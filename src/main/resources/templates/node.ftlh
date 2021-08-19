<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Структура <#if enterprise??> ${enterprise.name}  <#else> организации </#if> </h5>
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