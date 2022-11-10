<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판 글작성</title>
    <link href="<c:url value="/resources/css/common.css"/>" rel='stylesheet' />
	<link href="<c:url value="/resources/css/free.css"/>" rel='stylesheet' />
	<script	src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function() {
	ClassicEditor.create(document.querySelector("#editor"), {
		ckfinder : {
			uploadUrl:"/upload"
		}
	}).then(editor=> {
		window.editor=editor;
	}).catch((error)=>{
		console.error(error);
	});
});
</script>

</head>
<body>
	<div>
		<c:import url='/WEB-INF/views/includes/header.jsp' />
	</div>
    <div class="board_wrap">
        <div class="board_title">
            <strong>글 등록</strong>
        </div>
        <form action="freeInsert" method="post">
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd><input type="text" name="ftitle" placeholder="제목 입력"></dd>
                    </dl>
                </div>                
                    <textarea id="editor" name="content"></textarea>
            </div>
            <div class="bt_wrap">
               <input type="submit" value="등록">
                <a id="input2" href="freeList">취소</a>
                </div>
        </div>
        </form>
    </div>
</body>
</html>