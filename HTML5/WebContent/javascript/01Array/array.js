const fruits = ['사과', '바나나'];


console.log(fruits);
console.log(fruits.length);
console.clear();

// 자료구조 출력
for (let index = 0; index < fruits.length; index++) {
  console.log(fruits[index]);
}
// b. for of
for(let fruit of fruits) {
  console.log(fruit);
}

// c. forEach
fruits.forEach((fruit) => {console.log(fruit)});

// 4. Addtion, delettion, copy

// push : add an item to the end
 fruits.push("사과", "딸기", "포도"); 
 console.log(fruits);
 
// pop : remove an item from the end
fruits.pop();
fruits.pop();
fruits.pop();
console.log(fruits);


// shift : remove an item from the benigging
// 빈공간을 뒤로 밀고 옮겨야 하기때문에 속도가 느림 따라서 pop과 push를 사용해야함.
// remove an item by index position

fruits.shift();

console.log(fruits);

// note !! shift, unshift are slower than pop, push
// splice : remove an item by index positiion

fruits.push('사과', '복숭아', '바나나');
console.log(fruits);


// 해당인덱스부터 갯수를 지정하지않으면 그뒤에를 다지움

console.log(fruits); // (4) ["바나나", "사과", "복숭아", "바나나"]

fruits.splice(1,1, '복숭아', '수박'); // 딸기 다음에 인덱스에 하나를 지우고 복숭아 수박을 넣어줘라는 뜻
console.log(fruits); // (4) ["바나나", "사과", "복숭아", "바나나"]


// combine two arrays

const fruits2 = ['배', '아이스'];

const newFruits =fruits.concat(fruits2);
console.log(newFruits);

// 5. Searching
// find the index
console.clear();
console.log(fruits.indexOf('사과'));

// includes

console.log(newFruits.includes('사과'));
console.log(fruits);
console.log(fruits.includes('바나나'));

// lastIndexOf
console.clear()
console.log(fruits);
console.log(fruits.lastIndexOf('바나나'));

