var institutionAPI2 = Vue.resource( '/institutionForLookup/{id}');

var param2 = new Map;

if (typeof paramInstitution2 !== 'undefined') {
    param2 = paramInstitution2;
}
var enterpriseId = param2.get("enterpriseId");
var institutionsSelectId = param2.get("institutionSelectId");
var lookupName = param2.get("lookupName");
var lookupLabel = param2.get("lookupLabel");
var institutionError = param2.get("institutionError");

var institutionDisable = param2.get("institutionDisable");

var institutionValueName = param2.get("institutionValueName");

if (institutionValueName == undefined ){
  institutionValueName = "userId";
  }

if (institutionDisable == undefined ){
  institutionDisable = false;
  }

var institutionRequired = param2.get("institutionRequired");
if (institutionRequired == undefined ){
  institutionRequired = false;
  }

function getDisable(){
  return institutionDisable ? 'disabled' : 'data-target="#exampleModal2" v-on:click="findInst"';
}

console.log(institutionDisable);

function getRequired(){
  return institutionRequired ? 'required' : '';
}

console.log(getDisable());

console.log(getRequired());

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



'<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">'+
  '<div class="modal-dialog" role="document">'+
    '<div class="modal-content">'+
        '<div class="modal-header">'+
          '<h5 class="modal-title" id="exampleModalLabel2">Работники</h5>'+
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
    console.log(institutionsSelectId);
     if (institutionError != ''){
             this.institutionError = institutionError;
         }
    if (institutionsSelectId != undefined && institutionsSelectId != 0){
            institutionAPI2.get({id: institutionsSelectId}).then(result=>
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
        close2();
        },
     clear: function(){
        this.institutionsSelect = null;
        close2();
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
function close2(){
$('#exampleModal2').modal('hide')
}

var InstitutionLookup2 = new Vue({
  el: '#InstitutionLookup2',
  template: '<institution-list />'
})
