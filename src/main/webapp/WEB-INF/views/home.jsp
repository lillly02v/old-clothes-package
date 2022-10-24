<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
   <title>Home</title>
<link href="${pageContext.servletContext.contextPath }/resources/static/css/common.css" rel="stylesheet" type="text/css">
   
<style>
* {box-sizing: border-box;}
body {font-family: Verdana, sans-serif;}
.mySlides {display: none;}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
 
  background-size: cover;  
  position: absoulute;
  margin: auto;
  object-fit: cover;
}

/* The dots/bullets/indicators */
.dot {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color:transparent;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s transparent;
}

.active {
  background-color: lightpink;
}

/* Fading animation */
.fade { /*화면 이동을 위한 css*/
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .text {font-size: 11px}
}

input.img-button{
   background: url("../../resources/image/button.jpg") no-repeat;
   border: none;
   width:150;
   height:40;
   top:50%;
   left:45%;
   position: absolute;
}

h2.hh{
   top:40%;
   left:40%;
   position: absolute;
}
</style>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.0.0/kakao.min.js"
  integrity="sha384-PFHeU/4gvSH8kpvhrigAPfZGBDPs372JceJq3jAXce11bVA6rMvGWzvP4fMQuBGL" crossorigin="anonymous"></script>
<script>
  Kakao.init('c089c8172def97eb00c07217cae17495'); // 사용하려는 앱의 JavaScript 키 입력
</script>


</head>
<body>
   <form action= "/" method="post">
   
   <div class="slideshow-container">
   <div class="mySlides fade">
     <img src="../../resources/image/second.jpg" style="width:100.5%;height:93%;position:relative; display: block;">
     <input type="button" class="img-button" onclick="location='test'">
     <h2 class="hh">헌 옷으로 행복해질 수 있어요!</h2>
   </div>
   
   <div class="mySlides fade">
     <img src="../../resources/image/first.jpg" style="width:100.5%;height:93%">
     <input type="button" class="img-button" onclick="location.href='test.jsp'">
     <h2 class="hh">헌 옷으로 행복해질 수 있어요!</h2>
   </div>
   
   <div class="mySlides fade">
     <img src="../../resources/image/threee.png" style="width:100.5%;height:93%">
     <input type="button" class="img-button" onclick="location.href='test.jsp'">
     <h2 class="hh">헌 옷 수거함은 어디에 있나요~</h2>
   </div>
   
   
   <br>
   
   <div style="text-align:center">
     <span class="dot"></span> 
     <span class="dot"></span> 
     <span class="dot"></span> 
   </div>
   </div>
</form>
<a id="chat-channel-button" href="javascript:chatChannel()">
  <img src="/tool/resource/static/img/button/channel/consult/consult_small_yellow_pc.png"
    alt="카카오톡 채널 채팅하기 버튼" />
</a>

<script>
  function chatChannel() {
    Kakao.Channel.chat({
      channelPublicId: '_wNXab',
    });
  }
</script>
<script>
   var slideIndex = 0;
   showSlides();
   
   function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
          slides[i].style.display = "none";  
     }
     slideIndex++;
     if (slideIndex > slides.length) {slideIndex = 1}    
     for (i = 0; i < dots.length; i++) {
       dots[i].className = dots[i].className.replace(" active", "");
     }
     slides[slideIndex-1].style.display = "block";  
     dots[slideIndex-1].className += " active";
     setTimeout(showSlides, 3000); // Change image every 2 seconds
   }
</script>
<div>
	<c:import url='/WEB-INF/views/includes/footer.jsp'/>
</div>
</body>
</html>