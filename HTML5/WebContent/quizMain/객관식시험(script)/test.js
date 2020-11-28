// "use strict";
let arrSubject = [{bunho:"1", head: "다음중 사람의 혈액형이 아닌것은?", select1:"A", select2:"B", select3:"C", select4:"D", corretAnswer:"1"}         
                 ,{bunho:"2", head: "다음중 사람의 혈액형이 아닌것은?", select1:"A", select2:"B", select3:"C", select4:"D", corretAnswer:"1"}
                 ,{bunho:"3", head: "다음중 사람의 혈액형이 아닌것은?", select1:"A", select2:"B", select3:"C", select4:"D", corretAnswer:"1"}];

let html="";
arrSubject.forEach(function(item){
  html += "<h4>[문제 " + item.bunho+ "] " + item.head + "</h4>" 
       + "<ol>" +
          "<li>"+item.select1+ "<input type=radio name=" +item.bunho +" value=1></input>"+"</li>" +
          "<li>"+item.select2+ "<input type=radio name=" +item.bunho +" value=2></input>"+"</li>" +
          "<li>"+item.select3+ "<input type=radio name=" +item.bunho +" value=3></input>"+"</li>" +
          "<li>"+item.select4+ "<input type=radio name=" +item.bunho +" value=4></input>"+"</li>" +
        "</ol>";  
});

let cnt=0;
let start=0;
let clock;
let number =0;


window.onload = function() {

  
  document.getElementById("cho").innerHTML= html;
  func_timerctrl();


  // 1. 사용자가 고른 답을 모으기.
  document.getElementById("submit2").addEventListener("click", function(){

    alert("제출 완료 하였습니다.")
    let uservalue2=[];
    arrSubject.forEach(function(item) {

      
      let be=document.getElementsByName(item.bunho); 
      
       for (let e=0; e<4; e++) { // 4지선다형이므로 그냥 4넣음 변수보다는 숫자가 훨씬 컴퓨터가 읽기에 편하기에
        if(be[e].checked==true) {
           uservalue2.push(be[e].value);
           
        }
        
       } // end of for
       //console.log(uservalue2.toString());  // 확인용 문장 값 uservalue2를 배열로 선언하고 checked된 value를 배열에 담는 형태

     
    }) // end of forEach(); 
    

    // 3. 타이머 초기화

    
    clearTimeout(clock);
    func_timer(99999);

    // 타이머 멈추는것만 가능함.

    // 질문하기
    // 1. radio에 label적용하기 
    // 2. 타이머 숫자 0으로 만들기
    // 3. 함수화 시켜서 표현하는게 좋은지?



    // 채점화면을 다시 출력하기.   

    html="";
    arrSubject.forEach(function(item){
      html += "<h4>[문제 " + item.bunho+ "] "+item.head+"<span id=corretAnswer>&nbsp&nbsp"+item.corretAnswer+"</span></h4>" 
           + "<ol>" +
              "<li>"+item.select1+ "<input type=radio name=" +item.bunho +" value=1></input>"+"</li>" +
              "<li>"+item.select2+ "<input type=radio name=" +item.bunho +" value=2></input>"+"</li>" +
              "<li>"+item.select3+ "<input type=radio name=" +item.bunho +" value=3></input>"+"</li>" +
              "<li>"+item.select4+ "<input type=radio name=" +item.bunho +" value=4></input>"+"</li>" +
            "</ol>";
            let i=0;
              if(arrSubject[i].corretAnswer == uservalue2[i]) {
                html += "<span>"+"&nbsp&nbsp&nbsp&nbsp" + "😊😊😊"+"</span>";
                } else {
                html += "<span>"+"&nbsp&nbsp&nbsp&nbsp&nbsp" + "🤢🤢🤢"+"</span>";
                }         
                i++;
    });


    let jesu=0;
    for (let i = 0; i< arrSubject.length; i++) {
      if(arrSubject[i].corretAnswer == uservalue2[i]) {
        jesu+=1;
        
      }else{
        
      }
    }

    // 화면에 표시하기.
    jesu=jesu*10; // 점수
    // console.log(jesu);
    document.getElementById("sum").innerText=jesu+"점";
    document.getElementById("cho").innerHTML= html;

  }); // end of eventlistener function()


} // end of window.onload = function();
  


// 타이머 함수
function func_timer(cnt) {
  
  // 작업은 했으나 다른방법은 있는지??
  if(cnt==99999) {
    document.getElementById("timer").innerHTML ="00:00";
    return;
  }
  
  start = 60*60 - cnt;

  if(start >=0) {
    let minute ="";

    if(start < 600) {
      minute = "0";
    }

    minute += parseInt(start/60);

    let second = start%60;

    second = (second < 10)?"0"+second:second;
    document.getElementById("timer").innerHTML = minute + ":" + second;
  }


  else {
    alert("시간이 종료되었습니다.")
    return;
  }
}


// 비동기화 호출함수
function func_timerctrl() {

  func_timer(cnt++);

  if(start >= 0) {
    clock=setTimeout('func_timerctrl()', 1000);
  }  
}

// // 초기버전 1
// function value_check1(number) {
  
//   for (let i=0; i<4; i++) {
//     if (document.getElementsByName("problem1")[i].checked == true) {
//       let uservalue= document.getElementsByName("problem1")[i].value;
//         // console.log(uservalue); 라디오 체크 했을때 value을 얻어오는지 확인하기위한 문장
//         console.log(uservalue);
//         if(uservalue == dabs[number].Answer) {
//            alert("정답입니다.")
//         } else {
//            alert("틀렸습니다.")
//         }
//         document.getElementById("rightAnswer1").innerText= dabs[number].Answer;
//     }
//   }   
// }
