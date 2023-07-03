
let links = document.querySelectorAll(".close")

links.forEach(function(link){
  link.addEventListener("click",function(ev){
    ev.preventDefault();
    let content = document.querySelector('.content');
    content.classList.remove("animate__fadeInDown");
    content.classList.add("animate__fadeOutUp");
    setTimeOut(function(){
      location.href="/";
    },1000)
    return false;
  });
});
