function onlyOneCheck(obj) {
  let arrProduct_old=document.getElementsByName("product_old");

  // 아래것 foreach문으로 바꾼것  
  arrProduct_old.forEach(item => {
    if(item !=obj) {
      item.checked = false;
    }  
  });



  // for(let i=0; i<arrProduct_old.length; i++) {
  //   if(arrProduct_old[i]) {
  //     if(arrProduct_old[i] !=obj) {
  //       arrProduct_old[i].checked = false;
  //       // true는 체크 false는 체크해제
  //     }
        
  //   }
  // } // end of for------------------
}

function fun_allCheck(bool) {

  let arrProduct_china=document.getElementsByName("product_china");
  
  arrProduct_china.forEach(item => {
    if(bool == true) {
      item.checked= true;
    }
    else {
      item.checked=false;
    }
  });

} // end of fun_allCheck;


/* == 체크박스 전체선택 / 전체해제 에서 
      하위 체크박스에 체크가 1개라도 체크가 해제되면 
      체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
      하위 체크박스에 체크가 모두 체크가 되어지지면 
      체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 ==  
*/
 function fun_chinaCheck() {
   let arrProduct_china=document.getElementsByName("product_china");
   let bFlag = false;

   arrProduct_china.forEach(item => {
     if(!item.checked) {
       bFlag = true;
       return;
     }
   }); // end of foreach
   
   if(bFlag) {
    // 중국산 체크박스에 1개이상 체크가 되어있지 않다면
    document.getElementById("allCheck").checked = false;  
  }
  else {
    // 중국산 체크박스 6개 모두가 체크가 된 경우이라면
    document.getElementById("allCheck").checked = true;  

  }


}