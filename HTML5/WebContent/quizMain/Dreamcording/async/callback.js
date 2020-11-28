'use strict';

// JavaScript is cynchronous
// Execute the cod block by orger after hoisting
// 코드의 작성순서대로 동기적으로 실행된다.

// 함수레벨 스코프로 올려주는것을 말함.
// hoisting: var, funtion declaration



setTimeout( () => {
 console.log(2);} , 1000)

 // Synchronous callback
function printImmdiately(pirnt) {
  print();
}

printImmdiately( ()=> console.log('hello'))

 // asynchronous callback
function printWithDely(print, timeout) {
  setTimeout(print, timeout);
}
printWithDely(()=> console.log('async callback'), 2000);

// Callback Hell example

class UserStorage {
  loginUser(id, password, onSuccess, onError) {
    setTimeout( () => {
      if (
        (id === 'ellie' && password === 'dream') ||
        (id === 'coder' && password === 'academy')
      ) {
        onSuccess(id);

      } else {
        onError(new Error('not found'));
      }
    }, 2000);
  }

  getRoles(user, onSuccess, onError) {
    setTimeout(() => {
      if(user ==='ellid') {
        onSuccess({ name: 'ellie', role : 'admin'});
      } else {
        onError(new Error('no access'));
      }
    }, 1000);
  }
}


const userStorage = new UserStorage();

const id = prompt('enter your id');
const password = prompt('enter your password');
userStorage.loginUser(
  id,
  password,
  (user) => {
    userStorage.getRoles(user, (userWithRole) => {
      alert('Hello ${user.name}, you have a ${user.role} role');
    }, error => {
      console.log(error);
    })
  },
  (error) => {console.log(error)})