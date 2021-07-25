var nodeAPI = Vue.resource( '/subdivisionNode/{pNode}/enterprise/{enterprise}');

function param(patch){
var url_string = window.location.href
var ii = url_string.indexOf(patch)+patch.length +1
var r2 = url_string.length - ii
return url_string.substr( ii, r2);
}

const User = {
  template: `
    <div class="user">
      <h2>Пользователь {{ $route.params.id }}</h2>
      <router-view></router-view>
    </div>
  `
}
const router = new VueRouter({
   mode: 'history',
  routes: [
    { path: '/subdivisionTree/:entId', component: User }
  ]
})



Vue.component('node-list',{
props: ['nodes', 'pNode', 'enterprise'],
template:
    '<tbody>'+
      '<tr v-for="node in nodes" :data-tt-id ="node.nodeId" :data-tt-parent-id= "node.pid">'+
      '<td>{{node.brief}}</td>'+
      '<td>{{node.name}} </td>'+
        '<td>'+
            '<div class="dropdown show">'+
                '<a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'+
                    'Опции'+
                '</a>'+
                '<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">'+
                    '<a class="dropdown-item"  :href="`/subdivisionEnterprise/${node.enterpriseId}/edit/${node.nodeId}`" >Редактировать</a>'+
               ' </div>'+
            '</div>'+
        '</td>'+
      ' </tr> ' +
    '</tbody>',
    created: function(){
    nodeAPI.get({pNode: this.pNode, enterprise: this.enterprise }).then(result=>
       result.json().then(data =>
            data.forEach(node => this.nodes.push(node))
        )
       )
      /*  $("#treeTable").treetable({
                               expandable: true,
                               initialState: "collapsed",
                               clickableNodeNames: true,
                               indent: 30
                           });*/
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
