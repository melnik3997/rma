var dateAPI = Vue.resource( '/getDate');
var dateDayAPI = Vue.resource( '/getDate/Day');
var workScheduleAPI = Vue.resource( '/getWorkSchedule/{id}');
var getInstitutionIsWorkNowAPI = Vue.resource( '/getInstitutionIsWorkNow');
var calendarAPI = Vue.resource( '/calendarEnterprise/now');
var presenceWorkAPI = Vue.resource( '/getPresenceWork');
var presenceWorkTimeSumAPI = Vue.resource( '/getPresenceWorkTimeSum');
var institutionAPI = Vue.resource( '/getInstitution');
var getRemainderActuallyWorkAPI = Vue.resource( '/getRemainderActuallyWork');
var getActuallyWorkListAPI = Vue.resource( '/getActuallyWorkList');

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
'<div class="modal fade" id="actuallyWorkSaveModal" tabindex="-1" role="dialog" aria-labelledby="actuallyWorkSaveModalLabel" aria-hidden="true">'+
  '<div class="modal-dialog" role="document">'+
    '<div class="modal-content">'+
      '<div class="modal-header">'+
        '<h5 class="modal-title" id="actuallyWorkSaveModalLabel">Списание трудозатрат</h5>'+
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
        $('#actuallyWorkSaveModal').modal('hide');
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

Vue.component('ActuallyWorkListItem',{
        props: ['actuallyWork', 'setErrorMess', 'openActuallyWork', 'getRemainderActuallyWork'],
        template:
            '<tr>'+
                '<td>{{actuallyWork.theme}}</td>'+
                '<td>{{actuallyWork.time}}</td>'+
                '<td>{{actuallyWork.comment}}</td>'+
                '<td>'+
                    '<button @click="deleteActuallyWork" type="button" class="btn btn-danger"  ><strong>⌫</strong></button>'+
                '</td>'+
            '</tr>'
    ,
    methods: {
        deleteActuallyWork: function (){
            this.$http.post('/deleteActuallyWork',   this.actuallyWork ).then(result=>
                result.json().then(data => {
                    this.openActuallyWork();
                    this.getRemainderActuallyWork();
                })
            ).catch(error => {
                this.setErrorMess(error.bodyText)
            })
        }

    }
    }
)

Vue.component('ActuallyWorkList',{
        props: ['actuallyWorkList', 'openActuallyWork', 'getRemainderActuallyWork'],
        template:
            '<div class="modal fade bd-example-modal-lg" id="actuallyWorkListModal" tabindex="-1" role="dialog" aria-labelledby="actuallyWorkListModalLabel" aria-hidden="true">'+
            '<div class="modal-dialog modal-lg" role="document">'+
            '<div class="modal-content">'+
            '<div class="modal-header">'+
            '<h5 class="modal-title" id="actuallyWorkListModalLabel">Списание за день</h5>'+
            '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
            '<span aria-hidden="true">&times;</span>'+
            '</button>'+
            '</div>'+
            '<div class="modal-body">'+
            '<div v-if="errorMess != null " class="alert alert-warning alert-dismissible fade show" role="alert">'+
            '<strong>{{errorMess}} </strong>'+
            '<button type="button" @click = "closeError" class="close" data-dismiss="alert" aria-label="Close">'+
            '<span aria-hidden="true">&times;</span>'+
            '</button>'+
            '</div>'+
            '<table class="table table-hover mb-3">'+
                '<thead>'+
                '<tr>'+
                    '<th scope="col">Тема</th>'+
                    '<th scope="col">Время</th>'+
                    '<th scope="col">Комментарий</th>'+
                    '<th scope="col"></th>'+
                '</tr>'+
                '</thead>'+
                '<tbody v-if ="actuallyWorkList != null">'+
                    '<ActuallyWorkListItem v-for="actuallyWork in actuallyWorkList" :key = "actuallyWork.id" :actuallyWork = "actuallyWork" :setErrorMess = "setErrorMess" :openActuallyWork ="openActuallyWork" :getRemainderActuallyWork = "getRemainderActuallyWork">'+
                    '</ActuallyWorkListItem>'+
                '</tbody>'+
            '</table>'+

            '</div>'+
            '<div class="modal-footer">'+
            '<button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>',
        methods: {
            closeError: function (){
                this.errorMess = null;
            },
            setErrorMess:function (errorMess){
                this.errorMess = errorMess;
            }
        },
        data: function(){
            return {
                errorMess: null
            }
        }
    }
)

Vue.component('main-tab',{
template:
'<div>'+
    '<div class="container">'+
        '<div v-if="errorMess != null " class="alert alert-warning alert-dismissible fade show" role="alert">'+
          '<strong>{{errorMess}} </strong>'+
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
                   '<week-list :key="mouth.number + componentKey"  :weekList = "mouth.weekList" :selectMethod = "select" :dayNow = "dayNow" />'+
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
                    '<div class="card-footer  text-center" @click="openWorkPanelM"  data-toggle="collapse" href="#collapseWorkPanel" role="button" aria-expanded="false" aria-controls="collapseWorkPanel" >'+
                        '{{(openWorkPanel == false  ? `▼`: `▲`)}}'+
                    '</div>'+
                '</div>'+
                '<div class="collapse" id="collapseWorkPanel">'+
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
                                  '<div class="progress-bar" role="progressbar" v-bind:style = "{width: remainderActuallyWorkProcent + `%` }" :aria-valuenow="remainderActuallyWorkProcent" aria-valuemin="0" aria-valuemax="100"></div>'+
                                '</div>'+
                            '</div>'+
                            '<div class="col-2">'+
                                '<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#actuallyWorkSaveModal" ><strong>✚</strong></button>'+
                            '</div>'+
                        '</div>'+
                        '<span>Требуется списать: <strong>{{remainderActuallyWork}} </strong> </span>'+
                    '</div>'+
                    '<div @click="openActuallyWork" data-toggle="modal"  data-target="#actuallyWorkListModal" aria-expanded="false"  class="card-footer  text-center" >'+
                        'Открыть'+
                    '</div>'+
                '</div>'+
             '</div>'+
         '</div>'+
    '</div>'+
    '<ActuallyWork :methodSave = "ActuallyWorkSave"> </ActuallyWork>'+
    '<ActuallyWorkList :actuallyWorkList = "actuallyWorkList"  :openActuallyWork = "openActuallyWork" :getRemainderActuallyWork = "getRemainderActuallyWork"> </ActuallyWorkList>'+
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
                      getInstitutionIsWorkNowAPI.get().then(result=> {
                              result.json().then(data => this.isWorkNow = data)
                              this.getRemainderActuallyWork();
                          }
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
       openWorkPanelM: function(){
        this.openWorkPanel = ! this.openWorkPanel  ;
        this.presenceWorkList = []
        this.openWorkPanelMM();
       },
       openWorkPanelMM: function(){
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
        openActuallyWork: function (){
           this.actuallyWorkList = []
            getActuallyWorkListAPI.get().then(result=>{
                    result.json().then(data =>
                        data.forEach(actuallyWork => this.actuallyWorkList.push(actuallyWork))
                    )
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
                           this.openWorkPanelMM();
                           this.getPresenceWorkTimeSum();
                          })
                    )
       },
       ActuallyWorkSave: function(time, comment, theme){
             this.$http.post('/createActuallyWork', {time: time, comment: comment,theme :theme, institution: this.institution } )
                .then(data => {
                    this.getRemainderActuallyWork();
                }
                )
                .catch(error => {
                        this.errorMess = error.bodyText
                })
       },
       closeError: function(){
        this.errorMess = null;
       },
        getRemainderActuallyWork: function(){
            getRemainderActuallyWorkAPI.get().then(result =>
                result.json().then(data => {
                    this.remainderActuallyWork = (this.workSchedule.workTime - data.toFixed(2)).toFixed(2);
                    this.remainderActuallyWorkProcent = (data / this.workSchedule.workTime *100);

                }
                )
            )
        }

    },
    data: function () {
        return {
            mouth: null,
            date: "",
            workSchedule: null,
            componentKey: 999999999,
            isWorkNow: false,
            selectDay: null,
            dayNow: null,
            workScheduleDay: null,
            openWorkPanel: false,
            presenceWorkList: [],
            presenceWorkTimeSum: 0.0,
            time: 0.0,
            comment: "",
            theme: "",
            actuallyWorkList: [],
            institution: null,
            errorMess: null,
            remainderActuallyWork: 0.0,
            remainderActuallyWorkProcent: 0.0
        }
    }
})

var MainTab = new Vue({
  el: '#MainTab',
  template: '<main-tab/>'
})