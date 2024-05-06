var canvas;
var context;
var W;
var H;
$(document).ready(function () {
    SetGlobals();
    render();

    let tempX, tempY, tempSpeed, tempLength;
for (let i = 0; i < 200; i++) {
  tempX = Math.random() * canvas.width;
  tempY = Math.random() * canvas.height;
  tempSpeed = Math.random() * 15 + 5;
  tempLength = Math.random() * 5 + 2;

  drops.push(new Drop(i, tempX, tempY, tempSpeed, tempLength));
}


    $(window).resize(function () {
        W = window.innerWidth;
        H = window.innerHeight;
        canvas.width = W;
        canvas.height = H;
    });

});

function SetGlobals() {
    canvas = document.getElementById("canvas");
    context = canvas.getContext("2d");
    context.font = 'bold 30px sans-serif';
    W = window.innerWidth;
    H = window.innerHeight;
    canvas.width = W;
    canvas.height = H;
}


const drops = [];
const mousePos = { x: 0, y: 0 };
let selectedBox; // 클릭된 box를 넣어놓은 변수

class Drop {
  constructor(index, x, y, speed, length) {
    this.index = index;
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.length = length;
    this.draw();
  }

  draw() {
    context.beginPath();
    context.strokeStyle = '#dfdfdf';
    context.moveTo(this.x, this.y);
    context.lineTo(this.x, this.y + this.length);
    context.stroke();
    context.closePath();
  }
}

function render() {
  context.clearRect(0, 0, canvas.width, canvas.height);

  drops.forEach((drop) => {
    drop.y += drop.speed;
    if (drop.y > canvas.height) {
      drop.y = 0;
      drop.x = Math.random() * canvas.width;
      drop.speed = Math.random() * 15 + 5;
      drop.length = Math.random() * 5 + 2;
    }

    drop.draw();
  });

  requestAnimationFrame(render); //반복
  //console.log(drops);
}

