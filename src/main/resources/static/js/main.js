var dateAPI = Vue.resource( '/getDate');
var workScheduleAPI = Vue.resource( '/getWorkSchedule');
var getInstitutionIsWorkNowAPI = Vue.resource( '/getInstitutionIsWorkNow');
console.log(tocken);
Vue.http.headers.common['X-CSRF-TOKEN'] = tocken;


Vue.component('main-tab',{
template:
'<div>'+
    '<div class="container">'+
         '<div class="row">'+
             '<div  class="col-lg-6 col-xl-4 ">'+
                 '<h5> {{date}} </h5>' +
             '</div>'+
             '<div  v-if = "workSchedule != null" class=" col-lg-6 col-xl-4 ">'+
                '<div class="card">'+
                    '<div class="card-header">'+
                        '<h4 >График работы</h4>'+
                    '</div>'+
                    '<ul class="list-group list-group-flush">'+
                        '<li class="list-group-item"><h6 >Обязательные часы: {{workSchedule.timeBegin}} - {{workSchedule.timeFinish}}</h6></li>' +
                        '<li class="list-group-item">'+
                            '<h6>Время работы:</h6> '+
                            '<span>план: <strong>{{workSchedule.workTime}} </strong> </span>'+
                            '<span> <strong> | </strong> </span>'+
                            '<span> обязательные: <strong>{{workSchedule.obligatoryWorkTime}}</strong></span>'+
                        '</li>' +
                    '</ul>'+
                '</div>'+
             '</div>'+
             '<div  v-if = "workSchedule != null" class=" col-lg-6 col-xl-4 ">'+
                '<button v-if = "isWorkNow == false" @click="startWork" type="button" class="btn btn-success">Начать</button>'+
                '<button v-if = "isWorkNow == true" @click="startWork" type="button" class="btn btn-danger">Завершить</button>'+
                '<div class="card">'+
                    '<div class="card-header">'+
                        '<h4 >График работы</h4>'+
                    '</div>'+
                    '<ul class="list-group list-group-flush">'+
                        '<li class="list-group-item"><h6 >Обязательные часы: {{workSchedule.timeBegin}} - {{workSchedule.timeFinish}}</h6></li>' +
                        '<li class="list-group-item">'+
                            '<h6>Время работы:</h6> '+
                            '<span>план: <strong>{{workSchedule.workTime}} </strong> </span>'+
                            '<span> <strong> | </strong> </span>'+
                            '<span> обязательные: <strong>{{workSchedule.obligatoryWorkTime}}</strong></span>'+
                        '</li>' +
                    '</ul>'+
                '</div>'+
             '</div>'+
         '</div>'+
    '</div>'+
'</div>',
    created: function(){
                  dateAPI.get().then(result=>
                  result.text().then(data => this.date = data)
                  )
                  workScheduleAPI.get().then(result=>{
                        result.json().then(data => this.workSchedule = data)
                        getInstitutionIsWorkNowAPI.get().then(result=>
                                              result.json().then(data => this.isWorkNow = data)
                                          )
                      }
                  )

                  console.log(this.isWorkNow);
              },
    methods: {
       forceRerender() {
            this.componentKey += 1
          },
       startWork: function(){
             this.$http.post('/startWork',  {} ).then(result=>
                    result.json().then(data => {
                          data => this.workSchedule = data
                          this.forceRerender();
                           getInstitutionIsWorkNowAPI.get().then(result=>
                                          result.json().then(data => this.isWorkNow = data)
                                       )
                          }
                                )
                    )

             console.log(this.isWorkNow);

       }/*,
       endWork: function(){
             this.$http.post('/endWork',  {} ).then(result=>
                    result.json().then(data => {
                          data => this.workSchedule = data
                          this.forceRerender();
                          }
                                )
                    )
       }*/
    },
      data: function() {
          return {
            date : "",
            workSchedule : null,
            componentKey: 0,
            isWorkNow : false
          }
        }
}
)

var MainTab = new Vue({
  el: '#MainTab',
  template: '<main-tab/>'
})
