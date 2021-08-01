var subdivisionAPI = Vue.resource( '/subdivisionForLookup/{id}');

var param = new Map;

if (typeof paramSubdivision !== 'undefined') {
    param = paramSubdivision;
}
var enterpriseId = param.get("enterpriseId");
var subdivisionsSelectId = param.get("subdivisionSelectId");
var lookupName = param.get("lookupName");
var lookupLabel = param.get("lookupLabel");
var subdivisionError = param.get("subdivisionError");

var subdivisionDisable = param.get("subdivisionDisable");



if (subdivisionDisable == undefined ){
  subdivisionDisable = false;
  }

var subdivisionRequired = param.get("subdivisionRequired");
if (subdivisionRequired == undefined ){
  subdivisionRequired = false;
  }

function getDisable(){
  return subdivisionDisable ? 'disabled' : 'data-target="#exampleModalSubdivision" v-on:click="findSubdivision"';
}

console.log(subdivisionDisable);

function getRequired(){
  return subdivisionRequired ? 'required' : '';
}

console.log(getDisable());

console.log(getRequired());

Vue.component('subdivision-tbody',{
props: ['subdivision', 'selectMethod'],
template:'<tr @dblclick="selectSubdivision">'+
                '<td>{{subdivision.name}}</td>'+
                '<td>{{subdivision.brief}} </td>'+
              '</tr> ',
methods: {
    selectSubdivision: function() {
        this.selectMethod(this.subdivision);
    }
}
}
);

Vue.component('subdivision-list',{
template:
'<div>'+
'<div class="form-group row">'+
 ' <label class="col-sm-2 col-form-label">'+lookupLabel+'</label>'+
  '<div class="col-sm-8">'+
    '<select :class="`custom-select ${(subdivisionError != null ? `is-invalid`: ``)}`"  name="'+lookupName+'" data-toggle="modal"  '+getDisable()+' '+ getRequired() +'>'+
        '<option class="invisible" v-if="subdivisionsSelect != null" selected :value="subdivisionsSelect.id"> {{subdivisionsSelect.name}} </option>'+
     '</select>'+
     '<div  class="invalid-feedback">{{subdivisionError}}</div>'+
  '</div>'+
'</div>'+



'<div class="modal fade" id="exampleModalSubdivision" tabindex="-1" role="dialog" aria-labelledby="exampleModalSubdivisionLabel" aria-hidden="true">'+
  '<div class="modal-dialog" role="document">'+
    '<div class="modal-content">'+
        '<div class="modal-header">'+
          '<h5 class="modal-title" id="exampleModalLabel">Подразделения</h5>'+
          '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
           ' <span aria-hidden="true">&times;</span>'+
          '</button>'+
        '</div>'+
        '<div class="input-group  m-3">'+
          '<input type="text" class="form-control col-sm-8" placeholder="Наименование" aria-label="Наименование" aria-describedby="basic-addon2"  v-model="findText">'+
          '<div class="input-group-append">'+
            '<button class="btn btn-outline-secondary" type="button" @click="findSubdivision">Поиск</button>'+
          '</div>'+
        '</div>'+
        '<table class="table table-hover m-3">'+
            '<thead>'+
                '<tr>'+
                    '<th scope="col">Наименование</th>'+
                    '<th scope="col">Соращение</th>'+
                '</tr>'+
            '</thead>'+
            '<subdivision-tbody  v-for="subdivision in subdivisions" :key="subdivision.id" :subdivision = "subdivision" :selectMethod = "select" />'+
        '</table>'+
        '<div class="modal-footer">'+
          '<button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>'+
        '</div>'+
    '</div>'+
  '</div>'+
'</div>'+
'</div>',
    created: function(){
    console.log(subdivisionsSelectId);
     if (subdivisionError != ''){
             this.subdivisionError = subdivisionError;
         }
    if (subdivisionsSelectId != undefined && subdivisionsSelectId != 0){
            subdivisionAPI.get({id: subdivisionsSelectId}).then(result=>
            result.json().then(subdivision => this.subdivisionsSelect = subdivision
                )
            )
        }
    },
    methods: {
     findSubdivision: function(){
        this.subdivisions = [];
            this.$http.get('/subdivisionForLookup', {params: {enterpriseId: enterpriseId, findText: this.findText}}).then(result=>
               result.json().then(data =>
                    data.forEach(subdivision => this.subdivisions.push(subdivision))
                )
               )

         },
     select: function(subdivision){
        this.subdivisionsSelect = subdivision;
        console.log(this.subdivisionsSelect);
        close();
        }
    },
      data: function() {
          return {
              subdivisions:[],
              subdivisionsSelect: null,
              findText: '',
              subdivisionError: ''
          }
        },
}
)
function close(){
$('#exampleModalSubdivision').modal('hide')
}

var subdivisionLookup = new Vue({
  el: '#subdivisionLookup',
  template: '<subdivision-list />'/*,
  data:{
    subdivisions:[]
  }*/
})
