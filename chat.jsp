<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery CDN-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/chat.css?20190816">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/template-style2.css?20190816">

</head>
<body >
 <div class="chat-container">
    <div class="chat-header">
      <div class="fixed_title" style="border:0px"><span class="user_info" style="width:40px; height:40px"><img src="${pageContext.request.contextPath}/images/default_user.png" alt="">
      </span> <span id="username" style="position:relative; left:2px; top:5px; font-size:1em">Client</span></div>
    </div>

    <div class="chatbox">
      <div class="friend-bubble bubble">
     	안녕하세요?
      </div>
    </div>

    <div class="text-box">
      <textarea id="message" placeholder="대화내용이 들어갑니다." autofocus></textarea>
      <button id="sendBtn">전송</button>
      <div class="clearfix"></div>
    </div>
  </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sockjs.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sendBtn").click(function() {
			event.preventDefault();
		    sendMessage();
		    $('#message').val('');
		    event.stopPropagation();

		});
		$("#message").on('keydown', function(event) {
		    if (event.keyCode == 13)
		    if (!event.shiftKey){
		        event.preventDefault();
		    	sendMessage();
		    	$('#message').val('');
		        }
			   event.stopPropagation();
		 });
		});

	// 웹소켓을 지정한 url로 연결한다.
	let sock = new SockJS("<c:url value="/chat"/>");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	// 메시지 전송
	function sendMessage() {
		 var msg = $('#message').val();
		 msg = msg.replace(/(?:\r\n|\r|\n)/g, '<br />');
		 $("#message").val(msg);

		 console.log(msg);
		 if(msg){
		 $('.chatbox').append('<div class="my-bubble bubble">'+ msg+'</div>');
		 $('.chatbox').animate({
		   scrollTop: $('.chatbox').get(0).scrollHeight
		 }, 100);
		 }

		 if(msg != ""){
		    message = {};
		    message.msg_text = $("#message").val()
		    message.chat_seq = window.opener.document.getElementById("chatSeq").value;
		    message.mem_id = '${login.mem_id}';
		    message.mem_nick = '${login.mem_name}';
		  }
		  sock.send(JSON.stringify(message));
	}

	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		var obj = JSON.parse(data)
 	    appendMessage(obj.msg_text);
	}

	function appendMessage(msg){
		
		 if(msg == ''){
			 return false;
		 }else{
		var t = getTimeStamp();
		var strBuffer="";
		strBuffer+="<div class='col-12 row' style = 'height : auto; margin-top : 5px;'>";
		strBuffer+="<div class='col-2' style = 'float:left; padding-right:0px; padding-left : 0px;'>";
		strBuffer+="<img id='' class='' src='' style = 'width:50px; height:50px; '>";
		strBuffer+="<div style='font-size:9px; clear:both;'>${login.mem_nick}</div></div>";
		strBuffer+="<div class = 'col-10' style = 'overflow : y ; margin-top : 7px; float:right;'>";
		strBuffer+="<div class = 'my-bubble bubble'>"+msg+"</div>";
		strBuffer+="<div col-12 style = 'font-size:9px; text-align:right; float:right;'>";
		strBuffer+="<div col-12 style = 'font-size:9px; text-align:right; float:right;'>";
		strBuffer+="<span style ='float:right; font-size:9px; text-align:right;' >"+t+"</span></div></div></div>";
		 $("#chatbox").append(strBuffer)	

		  var chatAreaHeight = $("#message").height();
		  var maxScroll = $("#message").height() - chatAreaHeight;
		  $("#message").scrollTop(maxScroll);

		 }
	}
	function getTimeStamp() {
		   var d = new Date();
		   var s =
		     leadingZeros(d.getFullYear(), 4) + '-' +
		     leadingZeros(d.getMonth() + 1, 2) + '-' +
		     leadingZeros(d.getDate(), 2) + ' ' +

		     leadingZeros(d.getHours(), 2) + ':' +
		     leadingZeros(d.getMinutes(), 2) + ':' +
		     leadingZeros(d.getSeconds(), 2);

		   return s;
	}
	function leadingZeros(n, digits) {
		   var zero = '';
		   n = n.toString();

		   if (n.length < digits) {
		     for (i = 0; i < digits - n.length; i++)
		       zero += '0';
		   }
		   return zero + n;
		 }
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#message").append("연결 끊김");
	}
</script>
</html>
