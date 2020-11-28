
window.onload = function () {

  document.getElementById("inputText").focus();
  // 1. 변경 이벤트리스너
  let btnOK =document.getElementById("btnOK");
  btnOK.addEventListener("click", () => {
  
  let inputText =document.getElementById("inputText").value;
  let encodeVal=encodeURI(inputText);
    // encodeURI("문자열"); ==> "문자열"을 UTF-8로 변환시켜준다.

    document.getElementById("encode").innerHTML = encodeVal;
    document.getElementById("decode").innerHTML = decodeURI(encodeVal);

});
  // 2. 다시 이벤트리스너
  document.getElementById("btndeOK").addEventListener("click", () => {

  document.getElementById("encode").innerHTML = "";
  document.getElementById("decode").innerHTML = "";
  document.getElementById("inputText").value="";
  document.getElementById("inputText").focus();
  });


    
}
  
