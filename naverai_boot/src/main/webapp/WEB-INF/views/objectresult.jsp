<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	var json =JSON.parse('${objectresult}');
	
	$("#count").html("<h3>"+json.predictions[0].num_detections+"개 의 사물 탐지</h3>");
	for(var i =0;i<json.predictions[0].num_detections;i++){		
		$("#names").append(		
		json.predictions[0].detection_names[i]+"-"+
		parseInt(json.predictions[0].detection_scores[i] *100)+"퍼센트 <br>"
		);
	/* 	var x1 =json.predictions[0].detection_boxes[i][0];
		var y1 =json.predictions[0].detection_boxes[i][1];
		var x2 =json.predictions[0].detection_boxes[i][2];
		var y2 =json.predictions[0].detection_boxes[i][3];
		$("#boxes").append("x1,y1="+x1+","+y1+"x2,y2="+x2+","+y2+"<br>"); */
	}//for
	let mycanvas = document.getElementById("objectcanvas");
	let mycontext= mycanvas.getContext("2d");
	
	let faceimage = new Image();
	faceimage.src = "/naverimages/${param.image}";//url 통신 이미지 다운로드 시간 대기
	faceimage.onload = function(){
		mycontext.drawImage(faceimage, 0, 0, faceimage.width, faceimage.height);
	
		var boxes =json.predictions[0].detection_boxes;//배열
		for(var i = 0 ; i < boxes.length;i++){
		/* var x1 =json.predictions[0].detection_boxes[i][0] * faceimage.width;
		var y1 =json.predictions[0].detection_boxes[i][1] * faceimage.height;
		var x2 =json.predictions[0].detection_boxes[i][2] * faceimage.width;
		var y2 =json.predictions[0].detection_boxes[i][3] * faceimage.height; */
		var y1 =json.predictions[0].detection_boxes[i][0] * faceimage.height;
		var x1 =json.predictions[0].detection_boxes[i][1] * faceimage.width;
		var y2 =json.predictions[0].detection_boxes[i][2] * faceimage.height;
		var x2 =json.predictions[0].detection_boxes[i][3] * faceimage.width;
		
		//let colors=["red","yellow","orange"]
		//사각형
		mycontext.strokeStyle="green";//색상
		mycontext.linewidth=3;//굵기
		mycontext.strokeRect(x1,y1,(x2-x1),(y2-y1));
		
		//텍스트
		mycontext.fillStyle="red";
		mycontext.font="bold 12px batang";
		mycontext.fillText(json.predictions[0].detection_names[i],x1,y1);
		
		
		}//for
	}//faceimage on load end;
});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>${objectresult }</h3>

<div id="count"></div>
<div id="names" style="border:2px solid lime"></div>
<div id="boxes" style="border :2px solid orange"></div>
<canvas id="objectcanvas" width="800" height="500" style="border:2px solid pink"></canvas>
테스트중
</body>
</html>