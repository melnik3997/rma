var institutionAPI = Vue.resource( '/institutionForLookup/{id}');

var param = new Map;

if (typeof paramInstitution !== 'undefined') {
    param = paramInstitution;
}
var enterpriseId = param.get("enterpriseId");
var institutionsSelectId = param.get("institutionSelectId");
var lookupName = param.get("lookupName");
var lookupLabel = param.get("lookupLabel");
var institutionError = param.get("institutionError");

var institutionDisable = param.get("institutionDisable");

var institutionValueName = param.get("institutionValueName");

if (institutionValueName == undefined ){
  institutionValueName = "userId";
  }

if (institutionDisable == undefined ){
  institutionDisable = false;
  }

var institutionRequired = param.get("institutionRequired");
if (institutionRequired == undefined ){
  institutionRequired = false;
  }

function getDisable(){
  return institutionDisable ? 'disabled' : 'data-target="#exampleModal" v-on:click="findInst"';
}

console.log(institutionDisable);

function getRequired(){
  return institutionRequired ? 'required' : '';
}

Vue.component('institution-tbody',{
props: ['institution', 'selectMethod'],
template:'<tr @dblclick="select">'+
                '<td>{{institution.fullName}}</td>'+
                '<td>{{institution.userName}} </td>'+
              '</tr> ',
methods: {
    select: function() {
        this.selectMethod(this.institution);
    }
}
}
);

Vue.component('institution-list',{
template:
'<div>'+
'<div class="form-group row">'+
 ' <label class="col-sm-2 col-form-label">'+lookupLabel+'</label>'+
  '<div class="col-sm-8">'+
    '<select :class="`custom-select ${(institutionError != null ? `is-invalid`: ``)}`"  name="'+lookupName+'" data-toggle="modal"  '+getDisable()+' '+ getRequired() +'>'+
        '<option class="invisible" v-if="institutionsSelect != null" selected :value="institutionsSelect.'+institutionValueName+'"> {{institutionsSelect.fullName}} </option>'+
     '</select>'+
     '<div  class="invalid-feedback">{{institutionError}}</div>'+
  '</div>'+
'</div>'+
'<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">'+
  '<div class="modal-dialog" role="document">'+
    '<div class="modal-content">'+
        '<div class="modal-header">'+
          '<h5 class="modal-title" id="exampleModalLabel">Работники</h5>'+
          '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
           ' <span aria-hidden="true">&times;</span>'+
          '</button>'+
        '</div>'+
        '<div class="input-group  m-3">'+
          '<input type="text" class="form-control col-sm-8" placeholder="ФИО" aria-label="ФИО" aria-describedby="basic-addon2"  v-model="findText">'+
          '<div class="input-group-append">'+
            '<button class="btn btn-outline-secondary" type="button" @click="findInst">Поиск</button>'+
          '</div>'+
        '</div>'+
        '<table class="table table-hover">'+
            '<thead>'+
                '<tr>'+
                    '<th scope="col">ФИО</th>'+
                    '<th scope="col">Имя пользователя</th>'+
                    '<th scope="col"></th>'+
                '</tr>'+
            '</thead>'+
            '<institution-tbody  v-for="institution in institutions" :key="institution.id" :institution = "institution" :selectMethod = "select" />'+
        '</table>'+
        '<div class="modal-footer">'+
          '<button type="button" class="btn btn-primary" @click="clear">Очистить</button>'+
          '<button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>'+
        '</div>'+
    '</div>'+
  '</div>'+
'</div>'+
'</div>',
    created: function(){
     if (institutionError != ''){
             this.institutionError = institutionError;
         }
    if (institutionsSelectId != undefined && institutionsSelectId != 0){
            institutionAPI.get({id: institutionsSelectId}).then(result=>
            result.json().then(institution => this.institutionsSelect = institution
                )
            )
        }
    },
    methods: {
     findInst: function(){
        this.institutions = [];
            this.$http.get('/institutionForLookup', {params: {enterpriseId: enterpriseId, findText: this.findText}}).then(result=>
               result.json().then(data =>
                    data.forEach(institution => this.institutions.push(institution))
                )
               )

         },
     select: function(institution){
        this.institutionsSelect = institution;
        close();
        },
     clear: function(){
        this.institutionsSelect = null;
        close();
        }
    },
      data: function() {
          return {
              institutions:[],
              institutionsSelect: null,
              findText: '',
              institutionError: ''
          }
        },
}
)
function close(){
$('#exampleModal').modal('hide')
}

var InstitutionLookup = new Vue({
  el: '#InstitutionLookup',
  template: '<institution-list />'
})
