

const name = 'ellie';
const age = 4;

function print(Person) {
  console.log(Person.name);
  console.log(Person.age);
} 




const obj1 = {}; // 'object literal' syntax
const obj2 = new Object(); // 'object constructor' syntax


const ellie = {name : 'ellie', age: 4};

print(ellie);
ellie.hasJob = true;

console.log(ellie.hasJob);

// Objects
// one of the JavaScript's data types
// a collection of related data and/or functionality

// 1. Literals and properties


//2. Computed properties
// key should be always string
console.clear();
console.log(ellie.name);
console.log(ellie['name']);


function printValue(obj, key) {
  console.log(obj[key]);
}

printValue(ellie, 'name');
printValue(ellie, 'age');

// 3. Property value shorthand
const person1 = {name : 'bob', age:2};
const person2 = {name: 'steve', age:3};
const person3 = {name: 'dave', age:4};
const person4 = makePerson('elile', 30);
console.log(person4);


// 4. constructor
function makePerson(name, age) {
  // this = {};
  this.name = name;
  this.age = age;
  // return this;
}

// 5. in operatior : property existence check (key in obj)

console.clear();
console.log('name' in ellie);
console.log('age' in ellie);
console.log('first' in ellie);

// 6. for .. in vs for..of
// for( key in obj)
console.clear();
for(key in ellie) {
  console.log(key);
}


// for (value of iterable)
const array = [1, 2, 3, 4, 5];
for (value of array) {
  console.log(value);
};

array.forEach(function() {
  console.log(array)
});

// 7. Fun cloning
// Object.assign(dest,)
const user = {name: 'ellie', age: '20'};
const user2 = user;
user2.name='coder';
console.log(user);


// old way
const user3 = {};
for (key in user) {
  user3[key] = user[key];
}

console.log(user3);

Object.assign(user4, user);
console.log(user4);




