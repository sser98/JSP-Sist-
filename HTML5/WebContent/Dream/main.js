'use strict'
console.log('hello world');

let a;
a = 6;

console.log(a);


// 1. Use strict
// added in ES 5
// use  this for Valina Javascript

// let name ='jihun';
// console.log(name);
// name ='hello';
// console.log(name);

// 2. Variable

let globalName= 'global name';
// 어플리케이션 실행부터 끝날때까지 메모리에 담겨있음.
// 필요한 부분에만 사용하는것이 좋음
{   
 let name ='jihun';
 console.log(name);
 name ='hello';
 console.log(name);
}
 console.log(name);

// 변수를 선언하는 예약어

// var (dont ever use this!)
// var no block scope


Number
String

 {
    age = 4;
    var age;
   }   
   console.log(age); 