var dateAPI = Vue.resource( '/getDate');
var dateDayAPI = Vue.resource( '/getDate/Day');
var workScheduleAPI = Vue.resource( '/getWorkSchedule/{id}');
var getInstitutionIsWorkNowAPI = Vue.resource( '/getInstitutionIsWorkNow');
var calendarAPI = Vue.resource( '/calendarEnterprise/now');
var presenceWorkAPI = Vue.resource( '/getPresenceWork');
var presenceWorkAPI = Vue.resource( '/getPresenceWork');
var presenceWorkTimeSumAPI = Vue.resource( '/getPresenceWorkTimeSum');
var institutionAPI = Vue.resource( '/getInstitution');
console.log(tocken);
Vue.http.headers.common['X-CSRF-TOKEN'] = tocken;



function getIndex(list, id) {
    for (var i = 0; i < list.length; i++ ) {
        if (list[i].id === id) {
            return i;
        }
    }

    return -1;
}

Vue.component('day',{
props: ['day', 'selectMethod', 'dayNow'],
template:
    '<td class = "my-auto p-1"><div @click="select" :class="` py-1 btn-circle  day-${day.dayType} ${(dayNow == day.day  ? `day-SELECT`: ``)}  `"><p  class="m-0" >{{day.day}}</p> </div></td>',
methods: {
    select: function() {
        this.selectMethod(this.day);
    }
}
}
)

Vue.component('day-list',{
props: ['dayList', 'numberWeek', 'selectMethod', 'dayNow'],
template:
  '<tr>' +
    '<th class="text-center">{{numberWeek}}</th>'+
    '<day v-for="day in dayList" :key  = "day.id"  :day = "day" :selectMethod = "selectMethod" :dayNow = "dayNow"/>' +
    '</tr>'
}
)

Vue.component('week-list',{
props: ['weekList', 'selectMethod', 'dayNow'],
template:
'<tbody class="">'+
    '<day-list v-for="week in weekList" :dayList = "week.dayList" :key  = "week.numberWeek"  :numberWeek = "week.numberWeek" :selectMethod = "selectMethod" :dayNow = "dayNow" />'+
'</tbody>',
}
)

Vue.component('ActuallyWork',{
props: ['methodSave'],
template:
'<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">'+
  '<div class="modal-dialog" role="document">'+
    '<div class="modal-content">'+
      '<div class="modal-header">'+
        '<h5 class="modal-title" id="exampleModalLabel">Списание трудозатрат</h5>'+
        '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
          '<span aria-hidden="true">&times;</span>'+
        '</button>'+
      '</div>'+
      '<div class="modal-body">'+
        '<form>'+
          '<div class="form-group">'+
            '<label for="recipient-name" class="col-form-label">Тема:</label>'+
            '<input type="text" class="form-control" id="recipient-name" v-model="theme">'+
          '</div>'+
          '<div class="form-group">'+
            '<label for="message-text" class="col-form-label">Коментарий:</label>'+
            '<textarea class="form-control" id="message-text" v-model="comment"></textarea>'+
          '</div>'+
         '<div class="form-group">'+
            '<label for="recipient-time" class="col-form-label">Затраченное время:</label>'+
            '<input type="number" min="0.01" max="12" step = "0.01" class="form-control" id="recipient-time" v-model="time">'+
          '</div>'+
        '</form>'+
      '</div>'+
      '<div class="modal-footer">'+
        '<button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>'+
        '<button type="button" @click="save" class="btn btn-primary">Сохранить</button>'+
      '</div>'+
    '</div>'+
  '</div>'+
'</div>',
methods: {
    save: function(){
        $('#exampleModal').modal('hide');
        this.methodSave(this.time,this.comment,this.theme);
        this.time = 0;
        this.comment = "";
        this.theme = "";

    }
},
data: function(){
        return {
            time : 0.0,
            comment : "",
            theme : ""
        }
}
}
)

Vue.component('main-tab',{
template:
'<div>'+
    '<div class="container">'+
        '<div v-if="errorMess != null " class="alert alert-warning alert-dismissible fade show" role="alert">'+
          '<strong>{{errorMess}}'+
          '<button type="button" @click = "closeError" class="close" data-dismiss="alert" aria-label="Close">'+
            '<span aria-hidden="true">&times;</span>'+
          '</button>'+
        '</div>'+
         '<div class="row">'+
             '<div  v-if = "mouth != null"  class="col-lg-6 col-xl-4 ">'+
                '<table class="table  table-light table-borderless border-table-radius">'+
                    '<thead class="">'+
                       '<tr class="">'+
                           '<th class="  text-center border-table-radius-top" colspan="8">{{mouth.name}}</th>'+
                       '</tr>'+
                       '<tr class = "">'+
                           '<th style="width: 12%" class="text-center"></th>'+
                           '<th style="width: 12%" class="text-center">Пн</th>'+
                           '<th style="width: 12%" class="text-center">Вт</th>'+
                           '<th style="width: 12%" class="text-center">Ср</th>'+
                           '<th style="width: 12%" class="text-center">Чт</th>'+
                           '<th style="width: 12%" class="text-center">Пт</th>'+
                           '<th style="width: 12%" class="text-center">Сб</th>'+
                           '<th style="width: 12%" class="text-center">Вс</th>'+
                       '</tr>'+
                   '</thead>'+
                   '<week-list :key="mouth.number" :key = "componentKey" :weekList = "mouth.weekList" :selectMethod = "select" :dayNow = "dayNow" />'+
                '</table>'+
                '<div  v-if = "workScheduleDay != null" class="card">'+
                    '<ul class="list-group list-group-flush">'+
                        '<li class="list-group-item"><h6 >Обязательные часы: {{workScheduleDay.timeBegin}} - {{workScheduleDay.timeFinish}}</h6></li>' +
                        '<li class="list-group-item">'+
                            '<h6>Время работы:</h6> '+
                            '<span>план: <strong>{{workScheduleDay.workTime}} </strong> </span>'+
                            '<span> <strong> | </strong> </span>'+
                            '<span> обязательные: <strong>{{workScheduleDay.obligatoryWorkTime}}</strong></span>'+
                        '</li>' +
                    '</ul>'+
                '</div>'+
             '</div>'+
             '<div  v-if = "workSchedule != null" class=" col-lg-6 col-xl-4 ">'+
                '<div class="card">'+
                    '<div class="card-header">'+
                        '<h5 >График работы {{date}}</h5>'+
                    '</div>'+
                    '<ul class="list-group list-group-flush">'+
                        '<li class="list-group-item"><h6 >Обязательные часы: {{workSchedule.timeBegin}} - {{workSchedule.timeFinish}}</h6></li>' +
                        '<li class="list-group-item">'+
                            '<h6>Время работы:</h6> '+
                            '<span>план: <strong>{{workSchedule.workTime}} </strong> </span>'+
                            '<span> <strong> | </strong> </span>'+
                            '<span> обяз.: <strong>{{workSchedule.obligatoryWorkTime}}</strong></span>'+
                            '<span> <strong> | </strong> </span>'+
                            '<span>отработано: <strong> {{presenceWorkTimeSum}} </strong> </span>'+
                        '</li>' +
                    '</ul>'+
                    '<div @click="startWork" :class="` card-footer text-center ${(isWorkNow == false  ? `bg-success`: `bg-danger`)}  `">'+
                        '{{(isWorkNow == false  ? `Начать`: `Завершить`)}}'+
                    '</div>'+
                    '<div class="card-footer  text-center" @click="openDitailM"  data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" >'+
                        '{{(openDitail == false  ? `▼`: `▲`)}}'+
                    '</div>'+
                '</div>'+
                '<div class="collapse" id="collapseExample">'+
                  '<div class="card card-body">'+
                    '<ul  v-if = "presenceWorkList != null " class="list-group list-group-flush">'+
                        '<li v-for="presenceWork in presenceWorkList" :key  = "presenceWork.id"  class="list-group-item"><h6 >Время работы: {{presenceWork.timeBegin}} - {{presenceWork.timeFinish}}</h6></li>' +
                    '</ul>'+
                  '</div>'+
                '</div>'+
             '</div>'+
             '<div  v-if = "workSchedule != null" class=" col-lg-6 col-xl-4 ">'+
                '<div class="card">'+
                    '<div class="card-header">'+
                        '<h5 >Списание трудозатрат</h5>'+
                    '</div>'+
                    '<div class="card-body p-1">'+
                        '<div class="row mx-2">'+
                            '<div class="col-10">'+
                                '<div class="progress mt-2">'+
                                  '<div class="progress-bar" role="progressbar" style="width: 12%" aria-valuenow="12" aria-valuemin="0" aria-valuemax="100"></div>'+
                                '</div>'+
                            '</div>'+
                            '<div class="col-2">'+
                                '<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" ><strong>✚</strong></button>'+
                            '</div>'+
                        '</div>'+
                        '<span>Требуется списать: <strong>{{workSchedule.workTime}} </strong> </span>'+
                    '</div>'+
                '</div>'+
             '</div>'+
         '</div>'+
    '</div>'+
    '<ActuallyWork :methodSave = "ActuallyWorkSave"> </ActuallyWork>'+
'</div>',
    created: function(){
                calendarAPI.get().then(result=>
                result.json().then(data => this.mouth = data)
                )
                dateAPI.get().then(result=>
                result.text().then(data => this.date = data)
                )
                dateDayAPI.get().then(result=>
                    result.json().then(data => this.dayNow = data)
                    )
                workScheduleAPI.get().then(result=>{
                      result.json().then(data => this.workSchedule = data)
                      getInstitutionIsWorkNowAPI.get().then(result=>
                                            result.json().then(data => this.isWorkNow = data)
                                        )
                    }
                )
                institutionAPI.get().then(result=>
                    result.json().then(data => this.institution = data)
                    )
                this.getPresenceWorkTimeSum();
              },
    methods: {
       select: function(day){

        if(this.selectDay != null && this.selectDay.id == day.id){
            this.workScheduleDay = null;
            this.selectDay = null;
            return;
        }
        this.selectDay = null;
        this.selectDay = day;
        if(this.selectDay.day == this.dayNow ){
            this.workScheduleDay = null;
        }else {
            workScheduleAPI.get({id:this.selectDay.id}).then(result=>{
                  result.json().then(data => this.workScheduleDay = data)

                        }
                        )
              }

       },
       openDitailM: function(){
        this.openDitail = ! this.openDitail  ;
        this.presenceWorkList = []
        this.openDitailMM();
       },
       openDitailMM: function(){
        this.presenceWorkList = []
        presenceWorkAPI.get().then(result=>{
           result.json().then(data =>
                   data.forEach(presenceWork => this.presenceWorkList.push(presenceWork))
                         )
            }
        )

       },
       getPresenceWorkTimeSum: function(){
        presenceWorkTimeSumAPI.get().then(result=>{
           result.json().then(data => this.presenceWorkTimeSum = data.toFixed(2) )
            }
        )
       },
       startWork: function(){
             this.$http.post('/startWork',  {} ).then(result=>
                    result.json().then(data => {
                          data => this.workSchedule = data
                           getInstitutionIsWorkNowAPI.get().then(result=>
                                          result.json().then(data => this.isWorkNow = data)
                                       )
                           this.openDitailMM();
                           this.getPresenceWorkTimeSum();
                          })
                    )
       },
       ActuallyWorkSave: function(time, comment, theme){
             this.$http.post('/createActuallyWork', {time: time, comment: comment,theme :theme, institution: this.institution } )
                .then(/*result=>
                    result.json()
                        .then(data =>data.forEach(actuallyWork => this.actuallyWorkList.push(actuallyWork)))*/
                     )
                .catch(error => {
                    // error.response can be null
                   // if (error.response && error.response.status === 400) {
                        this.errorMess = error.bodyText
                  //  }
                })
       },
       closeError: function(){
        errorMess = null;
       }
    },
    data: function() {
        return {
          mouth: null,
          date : "",
          workSchedule : null,
          componentKey: 999999999,
          isWorkNow : false,
          selectDay : null,
          dayNow : null,
          workScheduleDay : null,
          openDitail: false,
          presenceWorkList: [],
          presenceWorkTimeSum : 0.0,
          time : 0.0,
          comment : "",
          theme : "",
          actuallyWorkList: [],
          institution: null,
          errorMess:null
        }
    }
})

var MainTab = new Vue({
  el: '#MainTab',
  template: '<main-tab/>'
})