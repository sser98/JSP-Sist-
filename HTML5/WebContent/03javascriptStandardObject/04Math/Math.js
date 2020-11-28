window.onload = function() {
      
  document.getElementById("val1").innerHTML = Math.abs(20-25); // 절대값
  
  document.getElementById("val2").innerHTML = Math.ceil(10/4);
  
  document.getElementById("val3").innerHTML = Math.ceil(10/5);
  
  document.getElementById("val4").innerHTML = Math.floor(10/4);
  
  document.getElementById("val5").innerHTML = Math.floor(10/5);
  
  document.getElementById("val6").innerHTML = Math.max(5,8,10,2,1,4);
  
  document.getElementById("val7").innerHTML = Math.min(5,8,10,2,1,4); 
  
  document.getElementById("val8").innerHTML = Math.round(10/4);
  
  document.getElementById("val9").innerHTML = Math.round(10/3);
  
  document.getElementById("val10").innerHTML = Math.trunc(10/4);
  
  document.getElementById("val11").innerHTML = Math.trunc(10/3);
  
  document.getElementById("val12").innerHTML = Math.sign(10-5);
  document.getElementById("val13").innerHTML = Math.sign(10-10);
  document.getElementById("val14").innerHTML = Math.sign(5-10);
  
  document.getElementById("val15").innerHTML = Math.random();
  
  document.getElementById("val16").innerHTML = "10" + "2.34";
  
  document.getElementById("val17").innerHTML = parseInt("10") + parseFloat("2.34"); 
  
  document.getElementById("val18").innerHTML = Number("10") + Number("2.34"); 
  
} // end of window.onload = function() { }----------------