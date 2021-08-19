<#import "parts/common.ftlh" as c >
<@c.page>
<h5 class=" mb-3 ">Календарь предприятия</h5>

<div id="CalendarYear">
</div>

<script> var tocken = '${_csrf.token}' </script>
<script src="/js/calendarYear.js"> </script>

</@c.page>