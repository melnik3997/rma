<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Структура <#if enterprise??> ${enterprise.name}  <#else> организации </#if> </h5>

<div class="container">

    <div class="row">
        <div class="col mt-5">

            <table id="treeTable" class="table">
                <thead>
                <tr>
                    <th>Сокращение</th>
                    <th>Наименование</th>
                    <th></th>
                </tr>
                </thead>

                <tbody id="app">
                </tbody>
            </table>

        </div>
    </div>

</div>

<script src="/js/node.js"></script>
</@c.page>