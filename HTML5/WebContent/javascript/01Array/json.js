// Json
// JavaScript Object Notation

// 1. Object to json

// stringfy(obj)
let json = JSON.stringify(true);
console.log(json);

json = JSON.stringify(['apple', 'banana']);
console.log(json);

const rabbit = {
  name : 'tori',
  color : 'white',
  size : null,
  birtDate : new Date(),
  symbol : Symbol('id'),
  jump: () => {
    console.log('${name} can jump!');
  }
};

json = JSON.stringify(rabbit);
console.log(json);

json = JSON.stringify(rabbit, ["name", "color", "size"]);
console.log(json);

json = JSON.stringify(rabbit, (key, value) => {
  console.log('key : ${key}, value : ${value}')
  return key === 'name'? 'ellie' : value;
});
console.log(json);

// 2. JSON to OBject
// parse(json)

json = JSON.stringify(rabbit);
const obj = JSON.parse(json, (key, value) => {
  console.log('key : ${key}, value : ${value}')
  return value;
});

console.log(obj);
rabbit.jump();
// obj.jump();

console.log(rabbit.birtDate.getDate());
console.log(obj.birtDate);

