window.onload = function() {

  let arrProduct_old=document.getElementsByName("product_old");

  arrProduct_old.forEach(item1 => {
    
    item1.addEventListener("click", () => {

      arrProduct_old.forEach(item2 => {
        if(item1 != item2) { // this 는 itme1 중의 한개이다. 현재 처리중인 체크박스를 말한다.
         item2.checked =false;
        }
         
      }); // item2 end of foreach
    });

  }); // // item1 end of foreach



  
  
  
  
  
  document.getElementById("allCheck").addEventListener('click', () => {
    // console.log(document.getElementById("allCheck").checked); 확인용
    let bool=document.getElementById("allCheck").checked;
    let arrProduct_china = document.getElementsByName("product_china");
    

    arrProduct_china.forEach(item => {
      if(bool) {
        item.checked=true;
      } else{
        item.checked=false;
      }

      bFlag=false;

      item.addEventListener('click', () => {

        if(!item.checked) {
          bFlag=true;
        } 
        
        if(bFlag) {
          document.getElementById("allCheck").checked = false;
        }

        aFlag=false;
        arrProduct_china.forEach(item => {
        if(item.checked) {
          // 체크가 되어진 경우
            aFlag=true;
        } else {
          // 체크박스가 체크가 안되어진 경우
          aFlag=false;
          break;
        }
        
        if(aFlag) {
          document.getElementById("allCheck").checked = true;
        }
      });
    });    
  });

     // 나머지 모든 하위체크박스가 체크가 되어진 경우인지 알아보도록 한다.

    //  let bFlag = false;
    //   arrProduct_china.forEach(item => {
    //     if(item.checked) {
    //       // 체크가 되어진 경우
    //         bFlag=true;
    //     } else {
    //       // 체크박스가 체크가 안되어진 경우
    //       bFlag=false;
    //       break;
    //     }
    //   });

    //   if(bFlag) {
    //     document.getElementById("allCheck").checked = true;
    //   }



  });



  // let arrProduct_china =document.getElementById(product_china);


  // let arrProduct_china=document.getElementsByName("product_china");
  // let bFlag = false;
  // arrProduct_china.forEach(item => {

  //   item.addEventListener('click', () => {
      
  //     if(!item.checked) {
  //       bFlag=true;
  //       break;
  //     }

  //     if(bFlg) {
  //       document.getElementById("allCheck").checked = false;  
  //     }
  //     else {
  //       document.getElementById("allCheck").checked = true; 
  //     }
  //   });
  // });



    
  

    

 


}