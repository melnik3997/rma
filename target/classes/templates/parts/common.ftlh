<#macro page>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>RMA</title>
    <link rel="stylesheet" href="/static/style.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="/static/node_modules/bootstrap/dist/css/bootstrap.min.css"/>
    <!-- Bootstrap CSS-->
    <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    -->
    <link rel="stylesheet" href="/static/node_modules/jquery-datetimepicker/build/jquery.datetimepicker.min.css" />

    <link rel="stylesheet" type="text/css" href="/static/node_modules/jquery-treetable/css/jquery.treetable.css">
    <!--  <link rel="stylesheet" type="text/css" href="http://ludo.cubicphuse.nl/jquery-treetable/css/jquery.treetable.theme.default.css">-->
    <link rel="stylesheet" href="/static/assets/jquery-treetable/jquery.treetable.theme.default.css"/>

    <script src="/static/node_modules/jquery/dist/jquery.slim.min.js"></script>
    <script src="/static/node_modules/popper.js/dist/umd/popper.min.js"></script>
    <script src="/static/node_modules/jquery-datetimepicker/build/jquery.datetimepicker.full.min.js"></script>

    <!-- версия для разработки, отображает полезные предупреждения в консоли -->
    <!--<script src="/static/node_modules/vue/dist/vue.runtime.global.js"></script>-->
    <!--<script src="/static/node_modules/vue-router/dist/vue-router.global.prod.js"></script>-->

        <script src="/static/vue/vue.js"></script>

    <script src="/static/node_modules/vue-resource/dist/vue-resource.min.js"></script>

        <!--<script src="https://cdn.jsdelivr.net/npm/vue-resource@1.5.3"></script>-->

  </head>
  <body>
  <#include "navbar.ftlh">
    <div class="container mt-5">
    <#nested>
    </div>





  <script src="/static/jquery/jquery-3.6.0.min.js"></script>
  <script type='text/javascript' src="/static/assets/jquery-treetable/jquery.treetable.js"></script>
  <script src="/static/node_modules/popper.js/dist/umd/popper.min.js"></script>
  <script src="/static/node_modules/bootstrap/dist/js/bootstrap.min.js" ></script>
  </body>
  </html>
  </#macro>