var calendarAPI = Vue.resource( '/calendarEnterprise{/id}');
console.log(tocken);
Vue.http.headers.common['X-CSRF-TOKEN'] = tocken;

var param = new Map;
var checkParam = false;

if (typeof paramCalendar !== 'undefined') {
console.log(paramCalendar);
    param = paramCalendar;
    checkParam = true;
}
console.log(checkParam);
var calendarEnterpriseId = param.get("calendarEnterpriseId");


function getIndex(list, id) {
    for (var i = 0; i < list.length; i++ ) {
        if (list[i].id === id) {
            return i;
        }
    }

    return -1;
}

Vue.component('day',{
props: ['day', 'selectMethod'],
template:
    '<td class = "my-auto p-1"><div @click="select" :class="` py-1 btn-circle  day-${(selectF ? `SELECT`: day.dayType )} `"><p  class="m-0" >{{day.day}}</p> </div></td>',
methods: {
    select: function() {
        this.selectF = !this.selectF;
        this.selectMethod(this.day, this.selectF);
    }
},
data: function() {
    return {
        selectF: false
    }
  }

}
)

Vue.component('day-list',{
props: ['dayList', 'numberWeek', 'selectMethod'],
template:
  '<tr>' +
    '<th class="text-center">{{numberWeek}}</th>'+
    '<day v-for="day in dayList" :key  = "day.id"  :day = "day" :selectMethod = "selectMethod"/>' +
    '</tr>'
}
)

Vue.component('week-list',{
props: ['weekList', 'selectMethod'],
template:
'<tbody class="">'+
    '<day-list v-for="week in weekList" :dayList = "week.dayList" :numberWeek = "week.numberWeek" :selectMethod = "selectMethod" />'+
'</tbody>',
}
)

Vue.component('calendar-list',{
template:
'<div>'+
    '<div class = "row">'+
        '<div class="form-group col-4" >'+
            '<div class="custom-control custom-radio">'+
                '<input type="radio" id="customRadio1" name="customRadio" class="custom-control-input" value="1" v-model="dataII">'+
                '<label class="custom-control-label" for="customRadio1">Рабочий</label>'+
            '</div>'+
            '<div class="custom-control custom-radio">'+
                '<input type="radio" id="customRadio2" name="customRadio" class="custom-control-input" value="2" v-model="dataII">'+
                '<label class="custom-control-label" for="customRadio2">Выходной</label>'+
            '</div>'+
            '<div class="custom-control custom-radio">'+
                '<input type="radio" id="customRadio3" name="customRadio" class="custom-control-input" value="3" v-model="dataII">'+
                '<label class="custom-control-label" for="customRadio3">Праздничный</label>'+
            '</div>'+
            '<div class="custom-control custom-radio">'+
                '<input type="radio" id="customRadio4" name="customRadio" class="custom-control-input" value="4" v-model="dataII">'+
                '<label class="custom-control-label" for="customRadio4">Предпраздничный</label>'+
            '</div>'+
        '</div>'+
        '<div class = "col-4">'+
            '<button type="submit" class="btn btn-primary" @click="editCalendar2">Редактировать календарь</button>'+
        '</div>'+
        '<div class = "col-4">'+
            '<p v-if = "selectDay.length != 0"  class= "float-right">Колличество выделенных: {{selectDay.length}}  </p> '+
        '</div>'+
    '</div>'+
    '<div class="container">'+
         '<div class="row">'+
             '<div v-for="mouth in mouthList" class="col-lg-6 col-xl-4 ">'+
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
                    '<week-list :key="mouth.number" :key = "componentKey" :weekList = "mouth.weekList" :selectMethod = "select" />'+
                 '</table>'+
             '</div>'+
         '</div>'+
    '</div>'+
'</div>',
    created: function(){
            calendarAPI.get({id:calendarEnterpriseId}).then(result=>
            result.json().then(data =>
                  data.forEach(mouth => this.mouthList.push(mouth))
                        )
            )
        },
    methods: {
     select: function(day, selectF){
        if(selectF){
         this.selectDay.push(day)
        }else{
            var index = getIndex(this.selectDay, day.id);
            this.selectDay.splice(index, 1 )

        }
        },
      editCalendar: function(){
           this.editMode = ! this.editMode ;

      },
       forceRerender() {
            this.componentKey += 1
          },
      editCalendar2: function(){
      if(this.dataII != null && this.selectDay.length > 0){
             this.$http.post('/calendarEnterprise',  {dayList: this.selectDay, dayType: this.dataII} ).then(result=>
                    result.json().then(data => {
                          this.mouthList = []
                          data.forEach(mouth => this.mouthList.push(mouth))
                          this.selectDay = []
                          this.forceRerender();
                          }
                                )
                    )
                   }
      }

    },
      data: function() {
          return {
              mouthList:[],
              selectDay:[],
              editMode : false,
              dataII:null,
              componentKey: 0
          }
        }
}
)

var CalendarYear = new Vue({
  el: '#CalendarYear',
  template: '<calendar-list />'
})