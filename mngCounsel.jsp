<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
  <style>
  #counselTb_previous{
  				padding-right:4.6em;
				margin-right:0.5em;
  }
  </style>

  </head>
  <body>
 	<%@include file="/WEB-INF/views/decorator/header.jsp" %>
 	<div class="container-contact100" style="z-index:2; background:#f7d2bd; display:none">
			<div class="wrap-contact100">
				<button class="btn-hide-contact100">
					<i class="zmdi zmdi-close"></i>
				</button>

				<div class="contact100-form-title" style="background-image: url(${pageContext.request.contextPath}/images/bg-02.jpg);">
					<span>상담등록</span>
				</div>

				<form class="contact100-form validate-form" id="form" method="post" onsubmit="return check();">
					<input type="hidden" id="cons_seq" name ='cons_seq'>
					<div class="wrap-input100 validate-input">
				 		<input id="mem_id" class="input100" type="text" name="mem_id" style="height:2.5em" disabled>
						<span class="focus-input100"></span>
						<label class="label-input100 " for="mem_id">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>

					<div class="wrap-input100 validate-input">
				 		<input id="mem_name" class="input100" type="text" name="mem_name" style="height:2.5em"  disabled>
						<span class="focus-input100"></span>
						<label class="label-input100 " for="mem_name">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>

				<!-- 	<div class="wrap-input100 validate-input">
				 		<input id="co_type" class="input100" type="text" name="co_type" style="height:2.5em" placeholder="자가진단여부"  disabled>
						<span class="focus-input100"></span>
						<label class="label-input100 " for="co_type">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>-->
					<div class="wrap-input100 validate-input">
				 		<input id="cons_course" class="input100" type="text" name="cons_course" style="height:2.5em"  placeholder="상담코스">
						<span class="focus-input100"></span>
						<label class="label-input100 " for="cons_course">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>

					<div class="wrap-input100 validate-input">
				 		<input id="cons_num" class="input100" type="text" name="cons_num" style="height:2.5em"  placeholder="상담차수">
						<span class="focus-input100"></span>
						<label class="label-input100 " for="cons_num">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>

					<div class="wrap-input100 validate-input">
						<select id="cons_comp_yn" name="cons_comp_yn" class="input100" style="height:2.5em" type="select">
						<option value="" selected disabled hidden >상담완료여부[필수]</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>

						<span class="focus-input100" id="cons_comp_yn_span"></span>
						<label class="label-input100 " for="cons_comp_yn">
							<span class="lnr lnr-pointer-right"></span>
						</label>
					</div>

					<div class="container-contact100-form-btn">

						<button class="contact100-form-btn">
							등록
						</button>
					</div>
				</form>
			</div>
		</div>
	<div class="bodyPart">


    <div class="container">
	  <div class="counselList">
      <div class="blog-header">
      <h1 class="title-part">상담관리</h1>
      </div>
      <hr style= width:100%"/>
      <div class="row">
        <div class="col-md-12 blog-main">
          <div class="blog-post">
			<br>
          	<div class="table-responsive">
            	<table class=table-base style="text-align:center;" id="counselTb">
					<colgroup>
						<c:if test="${login.auth=='A'}">
							<col style="width:11%">
							<col style="width:11%">
							<col style="width:10%">
							<col style="width:11%">
							<col style="width:15%">
							<col style="width:9%">
							<col style="width:12%">
							<col style="width:10%">
							<col style="width:10">
						</c:if>
						<c:if test="${login.auth=='G'}">
							<col style="width:12%">
							<col style="width:12%">
							<col style="width:12%">
							<col style="width:30%">
							<col style="width:10%">
							<col style="width:12%">
							<col style="width:10">
						</c:if>
					</colgroup>
					<thead>
						<tr>
						<c:if test="${login.auth=='A'}">
							<th scope="row">상담등록상태</th>
							<th scope="row">회원ID</th>
							<th scope="row">이름</th>
							<th scope="row">닉네임</th>
							<th scope="row">상담코스</th>
							<th scope="row">상담차수</th>
							<th scope="row">상담일시</th>
							<th scope="row">상담하기</th>
							<th scope="row">결제여부</th>
						</c:if>
						<c:if test="${login.auth=='G'}">
							<th scope="row">상담등록상태</th>
							<th scope="row">상담내역보기</th>
							<!-- <th scope="row">자가진단여부</th> -->
							<th scope="row">상담코스</th>
							<th scope="row">상담차수</th>
							<th scope="row">상담일시</th>
							<th scope="row">결제하기</th>
						</c:if>
						</tr>
						</thead>
						<tbody id = "counselListTbody">
						</tbody>
					</table>
					<!-- <div style="margin-top:-1.7em"></div> -->
					<!-- <button class="btn-show-contact100" id="regBtn" style="position:relative; top:-2em">상담 등록하기</button> -->
				</div>
          </div>
          <!-- /.blog-post -->
        </div><!-- /.blog-main -->
      </div><!-- /.row -->
      </div>
    </div><!-- /.container -->


	</div><!-- /.bodyPart -->
<input type="hidden" id="tutorUserId"/>
<input type="hidden" id="chatSeq"/>
</body>
  <script>
   $(document).ready(function(){
		loadData();
		initTable();
		$("#regBtn").click(function(){
		//	document.location.href = "${pageContext.request.contextPath}/counsel/regCounsel";
		});
	});
   function check(){
	   if($("#cons_comp_yn").val() ==null){
           return false;
    }
   }
	$("#form").submit(function(event){
		$("#mem_id").removeAttr("disabled");
		$("#mem_name").removeAttr("disabled");
	})
    // 테이블 초기 설정
    function initTable()
    {
    	$("#counselTb").dataTable({
    		// 표시 건수기능 숨기기
    	    lengthChange: false,
    	    // 검색 기능 숨기기
    	    searching: false,
    	    // 정렬 기능 숨기기
    	    ordering: false,
    	    // 정보 표시 숨기기
    	    info: false,
    	    // 페이징 기능 숨기기
    	    paging: true,
	    	//scrollY: 1000,
	        scrollCollapse: true,
    	     // 표시 건수를 10건 단위로 설정
   			//lengthMenu: [ 10, 20, 30, 40, 50 ],
 			// 페이지 당 건수 설정
 			pageLength:10
		    // 기본 표시 건수를 10건으로 설정
		    //displayLength: 10
		    // 현재 상태를 보존
	        //stateSave: true
	        //scrollX: true
    	})
    }
	// 이슈게시판 입장 및 새로고침 시 게시글 목록 호출
	function loadData() {
		var htmls = "";
		var data={"auth":"${login.auth}", "mem_id":"${login.mem_id}"};
		$.ajax({
			type: "post",
			data: data,
			url:"${pageContext.request.contextPath}/counsel/getCounselList",
			success: function(result){
				if( result.length < 1)
				{

				}
				else
				{
					$.each(result, function( index, result ){
						if("${login.auth}"=='A')
						{
							if(result.cons_course!=0)
							{
								htmls += '<tr><td>';
								htmls += '<a onclick=javascript:updateCounsel("';
								htmls += result.cons_seq+'","'+result.mem_id+'","'+result.mem_name+'","'
								htmls += result.cons_course+'","'+result.cons_num
								htmls += '"); >상담등록완료</a>';
								htmls += '</td><td>';
								htmls += result.mem_id;
								htmls += '</td><td>';
								htmls += result.mem_name;
								htmls += '</td><td>';
								htmls += result.mem_nick;
								htmls += '</td><td>';
								htmls += result.cons_course;
								htmls += '</td><td>';
								htmls += result.cons_num;
								htmls += '</td><td>';
								if(result.cons_timestamp!=null)
									htmls += result.cons_timestamp.substr(0,10);
								else
									htmls += '상담대기중';
								htmls += '</td><td>';
								htmls += '<a onclick=javascript:startChat("';
								htmls += result.mem_id+'","'+result.mem_name+'","'+result.cons_seq+'","'+result.chat_seq;
								htmls += '");>상담시작</a>';
								htmls += '</td><td>';
								htmls += result.pay_yn;
								htmls += '</td></tr>';
							}else
							{
								htmls += '<tr><td>';
								htmls += '<a onclick=javascript:regCounsel("';
								htmls += result.cons_seq+'","'+result.mem_id+'","'+result.mem_name
								htmls += '"); >대기중</a>';
								htmls += '</td><td>';
								htmls += result.mem_id;
								htmls += '</td><td>';
								htmls += result.mem_name;
								htmls += '</td><td>';
								htmls += result.mem_nick;
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += result.pay_yn;
								htmls += '</td></tr>';
							}
						}else
						{
							if(result.cons_course!=0)
							{
								htmls += '<tr><td>';
								htmls += '완료';
								htmls += '</td><td>';
								htmls += '<a onclick=javascript:regCounsel();>보기</a>'
								/* htmls += '</td><td>';
								htmls += '<a onclick=javascript:doSelfCheck();>자가진단하기</a>' */
								htmls += '</td><td>';
								htmls += result.cons_course;
								htmls += '</td><td>';
								htmls += result.cons_num;
								htmls += '</td><td>';
								if(result.cons_timestamp !=null)
									htmls += result.cons_timestamp.substr(0,10);
								else
									htmls += "상담대기중"
								htmls += '</td><td>';
								htmls += '<a onclick=javascript:regCounsel();>결제하기</a>'
								htmls += '</td></tr>';
							}else
							{
								htmls += '<tr><td>';
								htmls += '대기중';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td><td>';
								htmls += '</td></tr>';
							}
						}
					})
					$('#counselListTbody').html(htmls);
				}
			}
		})
	}

	/* function doSelfCheck()
	{
		document.location.href = '${pageContext.request.contextPath}/counsel/selfCheck';
	} */
	function regCounsel(cons_seq, mem_id, mem_name){
		$("#cons_seq").val(cons_seq);
        $("#mem_id").val(mem_id);
        $("#mem_name").val(mem_name);
		$('.container-contact100').fadeIn(300);
        $('.counselList').fadeOut(100);
	}
	function updateCounsel(cons_seq, mem_id, mem_name, cons_course, cons_num){
		$("#cons_seq").val(cons_seq);
		$("#mem_id").val(mem_id);
        $("#mem_name").val(mem_name);
        $("#cons_course").val(cons_course);
        $("#cons_num").val(cons_num);
        $('.container-contact100').fadeIn(300);
        $('.counselList').fadeOut(100);
	}
	function startChat(memId, memName, consSeq, chatSeq){
		/*ChatRoom insert*/
		var user_id='${login.mem_id}';
    	var data = {"created_id":user_id, "chat_topic":memId, "chat_seq":chatSeq, "cons_seq":consSeq };
		$.ajax({
			type: "post",
			data:data,
			dataType : "json",
			url: "${pageContext.request.contextPath}/counsel/regChatRoom",
			success: function(result){
				$("#chatSeq").val(result);
			}
    	});
		$("#tutorUserId").val(memId);
		//	openPopup( '${pageContext.request.contextPath}/counsel/chat', 'popuppopup1','no','20','10');
		var option = 'width=391,height=530,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=300';
		window.open("${pageContext.request.contextPath}/counsel/chat", "a", option);
	//	document.location.href = "${pageContext.request.contextPath}/counsel/chat";
	}
   </script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
</html>