<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>QTOrder</title>
<link href="css/styles.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="assets/img/logo_small.png" />
<script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js" crossorigin="anonymous"></script>

</head>
<body style="background-color: #FA823C; text-align: center;">
<div id="empty" style="height: 10%"></div>
	<img alt="" src="assets/img/col_logo.png" style="width: 100%" >
	
<%
    String clientId = "LbSKpthI2uLCgKvmUEpp";
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8081/QRservice/storelist.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
         + "&client_id=" + clientId
         + "&redirect_uri=" + redirectURI
         + "&state=" + state;
    session.setAttribute("state", state);
 %>
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container-xl px-4">
					<div class="row justify-content-center">
						<div class="col-lg-5">							
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header justify-content-center">
									<h3 id="fes_name" class="fw-light my-4"><%-- ${fesname.fes_name} --%></h3>
								</div>
								<div class="card-body">
									<form>
										<div class="mb-3" style="text-align: center;">
											<label class="small mb-1" for="inputPhoneNumber" style="";>네이버계정으로 로그인</label>
											<br>
											<a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			<!-- <div id="empty" style="height: 20px"></div>
			<img alt="" src="assets/img/fes_logo.png" > -->
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
	    
	    function getParameterByName(name, url) {
	        if (!url) url = window.location.href;
	        name = name.replace(/[\[\]]/g, '\\$&');
	        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
	            results = regex.exec(url);
	        if (!results) return null;
	        if (!results[2]) return '';
	        return decodeURIComponent(results[2].replace(/\+/g, ' '));
	    }

	    // fes_idx 매개변수의 값을 가져오기
	    var fesIdxValue = getParameterByName('fes_idx');
	    console.log('fes_idx 값:', fesIdxValue);
	    
	    $.ajax({
			url : 'http://localhost:8081/QRservice/getfes_name.do?fes_idx='+fesIdxValue,

			success : function(result) {
				
				console.log("resutl : ",result);
				document.getElementById("fes_name").innerText = result.fes_name;
			},
			error : function() {

			}
		});
	    
	});
	
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
