<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
     <!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<c:url value="/resources/css/common.css"/>" rel='stylesheet' />
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	$('#businessform').hide();
	$('#personalform').show();
	$('input[type="radio"][id="person"]').on('click', function(){
		var chkValue = $('input[type=radio][id="person"]:checked').val();
		if(chkValue){
			$('#businessform').hide();
			$('#personalform').show();
		}
	});
	$('input[type="radio"][id="business"]').on('click', function(){
		var chkValue = $('input[type=radio][id="business"]:checked').val();
		if(chkValue){
			$('#businessform').show();
			$('#personalform').hide();
		}
	});
});

//닉네임 중복확인(개인)
$(function(){
   $('#nicknamecheck').click(function(){
      var nickname =$('#nickname').val(); //사용자가 입력한 id값 
      console.log(nickname);
      $.ajax({
         type : "post",
         url : "http://localhost:8090/nickname",
         data : {nickname:nickname},
         success:function(data,textStatus){
            if(data=="true"){
               alert("이미 사용중인 닉네임입니다.");
            }else if(nickname==''){
               alert("닉네임을 입력해주세요");
            }else{
               alert("사용이 가능한 닉네임입니다.");
            }
         }
      })
   });
});

//닉네임 중복확인(업체)
$(function(){
   $('#brandnamecheck').click(function(){
      var nickname =$('#brandname').val(); //사용자가 입력한 id값 
      console.log(nickname);
      $.ajax({
         type : "post",
         url : "http://localhost:8090/nickname",
         data : {nickname:nickname},
         success:function(data,textStatus){
            if(data=="true"){
               alert("이미 있는 상호명입니다.");
            }else if(nickname==''){
               alert("상호명을 입력해주세요");
            }else{
               alert("사용이 가능한 상호명입니다.");
            }
         }
      })
   });
});

//이메일 중복확인(개인)
$(function(){
   $('#p_emailcheck').click(function(){
      var checkemail =$('#p_email').val();
      var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
      console.log(checkemail.value);
      $.ajax({
         type : "post",
         url : "http://localhost:8090/checkemail",
         data : {checkemail:checkemail},
         success:function(data,textStatus){
            if(data=="true"){
               alert("이미 사용중인 이메일입니다");
            }else if (checkemail==''){
               alert("이메일을 입력해주세요");
            }else if(exptext.test(checkemail)==false){
               alert("이메일 형식이 올바르지 않습니다.");   
            }else{
               alert("사용 가능한 이메일 입니다.");
            }
         }
      })
   });
});

//이메일 중복확인(업체)
$(function(){
   $('#b_emailcheck').click(function(){
      var checkemail =$('#b_email').val();
      var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
      console.log(checkemail.value);
      $.ajax({
         type : "post",
         url : "http://localhost:8090/checkemail",
         data : {checkemail:checkemail},
         success:function(data,textStatus){
            if(data=="true"){
               alert("이미 사용중인 이메일입니다");
            }else if (checkemail==''){
               alert("이메일을 입력해주세요");
            }else if(exptext.test(checkemail)==false){
               alert("이메일 형식이 올바르지 않습니다.");   
            }else{
               alert("사용 가능한 이메일 입니다.");
            }
         }
      })
   });
});

//인증번호 5자리 번호 = 전송(개인)
$(function(){
	
	let userPhoneNum;
	let authCode= $('#authCode');
	$(document).on('click','#goSMS', function () {		// 버튼을 클릭 했을 경우
		let userPhoneNum = $('#userPhoneNum').val();	// 사용자가 입력한 전화번호
		let authCode= $("#authCode");	//휴대폰 인증번호 담을 변수
	
		// 사용자가 입력한 전화번호가 공백이 아니고, 8자리 이상일 경우
		if (userPhoneNum != '' && userPhoneNum.length > 8) {
			$.ajax({
				url: '/main/execute',	// 요청보낼 url
				method: 'get',
				data: {'userPhoneNum': userPhoneNum},	// 사용자가 입력한 휴대폰번호 전송
				success: function (response) {
					authCode.attr('value', response);	// authCode의 속성 value값을 인증번호로 설정
					console.log("input태그에 담긴 인증번호: " + authCode.val());	// 확인용
	
					alert('인증 번호가 발송 되었습니다.');
				
				},
				error: function(response) {
					alert('인증번호 발송에 실패하였습니다.\n잠시 후 다시 시도해주시기 바랍니다.')
				}
			});
		}else{
			alert("휴대폰 번호를 입력 해 주세요");
		}
	});

	
	//인증번호 확인 (개인)
	let authNumbers = document.getElementById("authNumber");
	$(document).on('click', '#confirmBnt', function () {
			// 인증번호가 공백이 아니고 0 이상일 경우
			console.log("text에 사용자가 입력한 인증 번호 : " + authNumbers.value);
			console.log("coolsms에서 받아온 인증 번호 : " + authCode.val());
			if (authNumbers.value !='' && parseInt(authNumbers.value)>0) {	// val()로 받으면 문자열이기 때문에 형변환
				if(authNumbers.value == authCode.val()){
					cnfCheck = true;
					alert('휴대폰 번호 인증이 완료되었습니다. 감사합니다.');
				} else {
					alert('인증번호가 일치하지 않습니다.');
				}
				// 인증번호를 입력하지 않았을 경우
			}else{alert("인증번호를 입력 해 주세요"); cnfCheck = false;}
		});

})

//인증번호 5자리 번호 = 전송(업체)
$(function(){
	
	let userPhoneNum;
	let authCode= $('#bauthCode');
	$(document).on('click','#bgoSMS', function () {		// 버튼을 클릭 했을 경우
		let userPhoneNum = $('#buserPhoneNum').val();	// 사용자가 입력한 전화번호
		let authCode= $("#bauthCode");	//휴대폰 인증번호 담을 변수
	
		// 사용자가 입력한 전화번호가 공백이 아니고, 8자리 이상일 경우
		if (userPhoneNum != '' && userPhoneNum.length > 8) {
			$.ajax({
				url: '/main/execute',	// 요청보낼 url
				method: 'get',
				data: {'userPhoneNum': userPhoneNum},	// 사용자가 입력한 휴대폰번호 전송
				success: function (response) {
					authCode.attr('value', response);	// authCode의 속성 value값을 인증번호로 설정
					console.log("input태그에 담긴 인증번호: " + authCode.val());	// 확인용
	
					alert('인증 번호가 발송 되었습니다.');
				
				},
				error: function(response) {
					alert('인증번호 발송에 실패하였습니다.\n잠시 후 다시 시도해주시기 바랍니다.')
				}
			});
		}else{
			alert("휴대폰 번호를 입력 해 주세요");
		}
	});

	
	//인증번호 확인 (업체)
	let authNumbers = document.getElementById("bauthNumber");
	$(document).on('click', '#bconfirmBnt', function () {
			// 인증번호가 공백이 아니고 0 이상일 경우
			console.log("text에 사용자가 입력한 인증 번호 : " + authNumbers.value);
			console.log("coolsms에서 받아온 인증 번호 : " + authCode.val());
			if (authNumbers.value !='' && parseInt(authNumbers.value)>0) {	// val()로 받으면 문자열이기 때문에 형변환
				if(authNumbers.value == authCode.val()){
					cnfCheck = true;
					alert('휴대폰 번호 인증이 완료되었습니다. 감사합니다.');
				} else {
					alert('인증번호가 일치하지 않습니다.');
				}
				// 인증번호를 입력하지 않았을 경우
			}else{alert("인증번호를 입력 해 주세요"); cnfCheck = false;}
		});

})

//비밀번호 일치여부(개인)
function isSame(){
	var password = document.getElementById('p_password');
	var checkpass = document.getElementById('p_checkpassword');
	console.log(password);
	console.log(checkpass);
	
	if(document.getElementById('p_password').value != '' && document.getElementById('p_checkpassword').value != ''){
		if(document.getElementById('p_password').value == document.getElementById('p_checkpassword').value){
			document.getElementById('same').innerHTML='비밀번호가 일치합니다.';
			document.getElementById('same').style.color='blue';
		}else{
			document.getElementById('same').innerHTML='비밀번호가 불일치합니다.';
			document.getElementById('same').style.color='red';
		}
	}
}

//비밀번호 일치여부(업체)
function isSame1(){
	var password = document.getElementById('b_password');
	var checkpass = document.getElementById('b_checkpassword');
	console.log(password);
	console.log(checkpass);
	
	if(document.getElementById('b_password').value != '' && document.getElementById('b_checkpassword').value != ''){
		if(document.getElementById('b_password').value == document.getElementById('b_checkpassword').value){
			document.getElementById('same1').innerHTML='비밀번호가 일치합니다.';
			document.getElementById('same1').style.color='blue';
		}else{
			document.getElementById('same1').innerHTML='비밀번호가 불일치합니다.';
			document.getElementById('same1').style.color='red';
		}
	}
}

//주소 찾기
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('b_address').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("b_address").value = roadAddr;
            } 
        }
    }).open();
}

</script>
<style>
.req{
	color:red;
}
</style>
</head>
<body>
	<div>
		<c:import url='/WEB-INF/views/includes/header.jsp' />
	</div>
	<br>
    <section class="vh-100 bg-image">
        <div class="mask d-flex align-items-center h-100 gradient-custom-3">
            <div class="container h-100" style="width:1200px;">
            	<div class="row d-flex justify-content-center align-items-center h-100">
                	<div class="col-12 col-md-9 col-lg-7 col-xl-6">
                	<div class="card" style="border-radius: 15px;">
                    	<div class="card-body p-5">
                    	<h2 class="text-uppercase text-center mb-5">회원가입</h2>
                    		<form>
                    			<div class="form-radio" style="text-align:center;">
			                        <input type="radio" name="member_level" value="person" id="person" checked="checked" />
			                        <label for="person">개인</label>
									 &nbsp; &nbsp;
			                        <input type="radio" name="member_level" value="business" id="business" />
			                        <label for="business">사업자</label>
                    			</div>
                    			<br>
                    			<%--업체 --%>
								<div id=personalform>
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="nickname" style="position:absolute; margin:2.5%;" >닉네임<span class="req">*</span></label>
				                 		<input type="text" id="nickname" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
					                    <input type="button" id="nicknamecheck" class="btn btn-light" value="중복확인" style="margin-left:2%;">
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="p_email" style="position:absolute; margin:2.5%;">이메일<span class="req">*</span></label>
				                        <input type="email" id="p_email" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;"/>
				                        <input type="button" id="p_emailcheck" class="btn btn-light" value="중복확인" style="margin-left:2%;">
			                        </div>
	                        
			                
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="userPhoneNum" style="position:absolute; margin:2.5%;" >전화번호<span class="req">*</span></label>
				                 		<input type="tel" id="userPhoneNum" name="userPhoneNum" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
					                    <input type="button" id="goSMS" class="btn btn-light" value="본인인증" style="margin-left:2%;">
			                        </div>
			                        
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="authNumber" style="position:absolute; margin:2.5%;" >인증번호<span class="req">*</span></label>
				                 		<input type="tel" id="authNumber" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 8rem;" />
				                 		<input type="hidden" id="authCode"/>
					                    <input type="button" id="confirmBnt" class="btn btn-light" value="인증확인" style="margin-left:2%;">
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="p_password" style="position:absolute; margin:2.5%;">비밀번호<span class="req">*</span></label>
				                        <input type="password" id="p_password" name="p_password" onchange="isSame()" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;"/>
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="p_checkpassword" style="position:absolute; margin:2.5%;">비밀번호 확인<span class="req">*</span></label>
				                        <input type="password" id="p_checkpassword" name="p_checkpassword" onchange="isSame()" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 8rem;"/>
			                        </div>
			                        <span id="same"></span>
							
									<br>
			                        <div class="form-check d-flex justify-content-center mb-5">
				                        <input class="form-check-input me-2" type="checkbox" value="" id="p_clause" />
				                        <label class="form-check-label" for="p_clause">
				                            <a href="#!" class="text-body"><u>약관</u></a>에 동의합니다
				                        </label>
			                        </div>
	
			                        <div class="d-flex justify-content-center">
				                        <button type="button"
				                            class="btn btn-outline-primary">가입하기</button>
			                        </div>
	
			                        <p class="text-center text-muted mt-5 mb-0">이미 계정이 있나요? <a href="#!"
			                            class="fw-bold text-body"><u>로그인하기</u></a></p>
								</div>
								<%--업체 --%>
								<div id=businessform>
									<div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="brandname" style="position:absolute; margin:2.5%;" >상호명<span class="req">*</span></label>
				                 		<input type="text" id="brandname" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
					                    <input type="button" id="brandnamecheck" class="btn btn-light" value="중복확인">
		                        	</div>
		                        
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="corporate number" style="position:absolute; margin:2.5%;" >사업자 번호<span class="req">*</span></label>
				                 		<input type="text" id="corporate number" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="b_email" style="position:absolute; margin:2.5%;">이메일<span class="req">*</span></label>
				                        <input type="email" id="b_email" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;"/>
				                        <input type="button" id="b_emailcheck" class="btn btn-light" value="중복확인">
			                        </div>
			                        
			                        
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="kakaoId" style="position:absolute; margin:2.5%;" >카카오ID</label>
				                 		<input type="text" id="kakaoId" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
			                        </div>
			                        
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="buserPhoneNum" style="position:absolute; margin:2.5%;" >전화번호<span class="req">*</span></label>
				                 		<input type="text" id="buserPhoneNum" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
					                    <input type="button" id="bgoSMS"class="btn btn-light" value="본인인증" >
			                        </div>
			                        
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="bauthNumber" style="position:absolute; margin:2.5%;" >인증번호<span class="req">*</span></label>
				                 		<input type="tel" id="bauthNumber" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 8rem;" />
				                 		<input type="hidden" id="bauthCode"/>
					                    <input type="button" id="bconfirmBnt" class="btn btn-light" value="인증확인" style="margin-left:2%;">
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="b_password" style="position:absolute; margin:2.5%;">비밀번호<span class="req">*</span></label>
				                        <input type="password" id="b_password" onchange="isSame1()" class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 7rem;" />
			                        </div>
	
			                        <div class="form-outline mb-4" style="display:flex;">
				                        <label class="form-label" for="b_checkpassword" style="position:absolute; margin:2.5%;">비밀번호 확인<span class="req">*</span></label>
				                        <input type="password" id="b_checkpassword" onchange="isSame1()"  class="form-control form-control-lg" style="padding:.5rem 1rem .5rem 8rem;" />
			                        </div>
			                        <span id="same1"></span>

			                        <div class="form-outline mb-4" >
			                        	<div style="display:flex;">
					                        <label class="form-label" for="b_address" style="margin:2.5%; float:left;" >주소<span class="req">*</span></label>
					                        <div style="display:flex;">
					                        	<input type="button" class="btn btn-light btn-sm" value="우편번호 검색" readonly onclick="findAddr()">
					                        </div>
				                       	</div>
				                       	<div>
					                    	<label class="form-label" for="b_address" style="margin:2%;">[도로명/지번]주소</label>
					                 		<input type="text" id="b_address" class="form-control form-control-lg" readonly/>
					                 		<label class="form-label" for="b_detailedaddress"style="margin:2%;">상세주소</label>
					                 		<input type="text" id="b_detailedaddress" class="form-control form-control-lg" />
				                 		</div>
									</div>
									<br>
			                        <div class="form-check d-flex justify-content-center mb-5">
				                        <input class="form-check-input me-2" type="checkbox" value="" id="b_clause" />
				                        <label class="form-check-label" for="b_clause">
				                            <a href="#!" class="text-body"><u>약관</u></a>에 동의합니다
				                        </label>
			                        </div>
	
			                        <div class="d-flex justify-content-center">
				                        <button type="button"
				                            class="btn btn-outline-primary">가입하기</button>
			                        </div>
	
			                        <p class="text-center text-muted mt-5 mb-0">이미 계정이 있나요? <a href="#!"
			                            class="fw-bold text-body"><u>로그인하기</u></a></p>
								</div>
                    		</form>
                    	</div>
                	</div>
                	</div>
            	</div>
            </div>
        </div>
    </section>
   
    <!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h3 class="modal-title" id="modal-title">번호 인증</h3>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="modal-body">
      	<input type="tel" class="certification" id="authNumber" value="" placeholder="번호 입력">
      	<input type="hidden" id="authCode"/>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="submit" class="btn btn-primary" data-bs-dismiss="modal" id="confirmBnt">인증완료</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
</body>

</html>