var nodeAPI = Vue.resource( '/subdivisionNode/{pNode}/enterprise/{enterprise}');


var enterpriseID = false;

if (typeof enterpriseParam !== 'undefined') {
    enterpriseID = enterpriseParam;
}else {
    enterpriseID = param('subdivisionTree');
}
console.log(enterpriseID);
function param(patch){
var url_string = window.location.href
var ii = url_string.indexOf(patch)+patch.length +1
var r2 = url_string.length - ii
return url_string.substr( ii, r2);
}

var time = 500;

Vue.component('node-list',{
props: ['nodes', 'pNode', 'enterprise'],
template:
'<table id="treeTable" class="table">'+
                '<thead>'+
                '<tr>'+
                    '<th>Сокращение</th>'+
                    '<th>Наименование</th>'+
                    '<th>Руководитель</th>'+
                    '<th>Количество <br> сотрудников</th>'+
                    '<th></th>'+
                '</tr>'+
                '</thead>'+
    '<tbody>'+
      '<tr  v-for="node in nodes" :data-tt-id ="node.nodeId" :data-tt-parent-id= "node.pid">'+
      '<td >{{node.brief}}</td>'+
      '<td >{{node.name}} </td>'+
      '<td >{{node.institutionFIO}} </td>'+
      '<td class="text-center">{{node.countWork}} </td>'+
        '<td>'+
            '<div class="dropdown show">'+
                '<a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'+
                    'Опции'+
                '</a>'+
                '<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">'+
                    '<a class="dropdown-item"  :href="`/subdivisionEnterprise/${node.enterpriseId}/edit/${node.nodeId}`" >Редактировать</a>'+
                    '<a class="dropdown-item"  :href="`/subdivisionEnterprise/add/${node.enterpriseId}/sub/${node.nodeId}`" >Добавить</a>'+
                    '<a class="dropdown-item"  :href="`/subdivisionEnterprise/${node.enterpriseId}/employee/${node.nodeId}`" >Сотрудники</a>'+
               '</div>'+
            '</div>'+
        '</td>'+
      ' </tr> ' +
    '</tbody>'+
    '</table>',
    created: function(){
    nodeAPI.get({pNode: this.pNode, enterprise: enterpriseID }).then(result=>
       result.json().then(data =>{
                data.forEach(node => this.nodes.push(node))
                time = 1;
            }
        )
       )
    },
    methods: {
    },
    data:function() {
        return {

        }
    },
    mounted : function(){

    }
}
)

var app = new Vue({
  el: '#app',
  template: '<node-list :nodes = "nodes"  :pNode = "pNode" :enterprise = "enterprise" />',
  data:{
    nodes:[],
    pNode: 0,
    enterprise: param('subdivisionTree')
  }
})


jQuery.noConflict();
      jQuery(document).ready(function () {
             setTimeout(function() {$("#treeTable").treetable({
                    expandable: true,
                    initialState: "collapsed",
                    clickableNodeNames: true//,
                   // indent: 30
                })}, time);
    });
