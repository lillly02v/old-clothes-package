<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자신청목록</title>
<link href="<c:url value="/resources/css/bmypage.css"/>" rel='stylesheet' />
<style>
.item{	
	width:100%;
}
#bcards{
	display: flex;    
    flex-wrap: wrap;
    justify-content: center;
}
</style>
</head>
<body>
	<c:import url='/WEB-INF/views/mypage/bmypage.jsp' />
	<div class="my_Tab">
			<ul class="tabs">
				<li class="on"><a href ="/mypage/bmypage/${business.bno }/apply">신청 목록</a></li>				
				<li><a href ="/mypage/bmypage/${business.bno }/review">거래 후기</a></li>
			</ul>			
	</div>	
	<div id="bcards">
		<c:forEach var="apply" items="${apply }">	  
			<div class="applyList">	        
		            <div class="item" style="width:100%;">		            
		            <strong>[ 헌옷 수거 신청 ]</strong>		
		            	<div class="title"></div>                                 		                
		                <div class="allapply" style="padding: 2%;">		                
		                    <div class="cont">
		                        <div class="aname"><p>${apply.aname }</p></div>
		                        <div class="aphone"><p>${apply.aphone }</p></div>                        
		                        <div class="aadress"><p>${apply.aaddress }</p></div>
		                        <div class="apickup"><p>${apply.apickup }</p></div>                                          
		                        <div class="wei">
		                            <div class="weight"><p>${apply.weight }</p></div>                        
		                        	<p>kg</p>
		                        </div>		                    
		                     </div>		                     
		                    <div class="btn">
		                        <button type="button" id="apply_close_btn">수거거절</button>
		                        <button type="submit" form="form" id="applying">수거승인</button>
		                    </div>                   
		                 </div>		               	            
		        </div>		        
		    </div>	 
		</c:forEach>	 
	</div>
    
    <ul class="pagination">
		<c:choose>
			<c:when test="${pageInfo.page<=1}">
				<li><a id="prev"><<</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="freeList?page=${pageInfo.page-1}" id="prev"><<</a></li>&nbsp;
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
			<c:choose>
				<c:when test="${pageInfo.page==i }"><li><a class="active">${i }</a></li></c:when>
				<c:otherwise>
					<li><a href="freeList?page=${i}">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${pageInfo.page>=pageInfo.maxPage }">
				<li><a id="next">>></a></li>
			</c:when>
			<c:otherwise>
				<li><a href="freeList?page=${pageInfo.page+1}" id="next">>></a></li>
			</c:otherwise>
		</c:choose>
	</ul>
    
	
	<script>
		$('.cancel').click(function(){
			var index = $(this).parent().index();
			var ino = $(".card:eq("+index+")").attr("data-sno");
			$.ajax({
				type : "get",
				url : "/cancelDeal",
				data : {ino:ino},
				success : function(data) {
					console.log(data);
					console.log("성공");
					location.reload();
				},
				error : function(err) {
					console.log(err);
				}
			});

		})
		
		$('.complete').click(function(){
			var index = $(this).parent().index();
			$(this).attr("disabled", true);
			var ino = $(".card:eq("+index+")").attr("data-sno");
			$.ajax({
				type : "get",
				url : "/completeDeal",
				data : {ino:ino},
				success : function(data) {
					console.log(data);
					console.log("성공");
					location.reload();
				},
				error : function(err) {
					console.log(err);
				}
			});

		})
		
		$('.cancel1').click(function(){
			var index = $(this).parent().index();
			var sno = $(".sharingcard:eq("+index+")").attr("data-sno");
			$.ajax({
				type : "get",
				url : "/cancelSharingDeal",
				data : {sno:sno},
				success : function(data) {
					console.log(data);
					console.log("성공");
					location.reload();
				},
				error : function(err) {
					console.log(err);
				}
			});

		})
		
		$('.complete1').click(function(){
			var index = $(this).parent().index();
			$(this).attr("disabled", true);
			var sno = $(".sharingcard:eq("+index+")").attr("data-sno");
			$.ajax({
				type : "get",
				url : "/completeSharingDeal",
				data : {sno:sno},
				success : function(data) {
					console.log(data);
					console.log("성공");
					location.reload();
				},
				error : function(err) {
					console.log(err);
				}
			});

		})
	</script>
</body>
</html>