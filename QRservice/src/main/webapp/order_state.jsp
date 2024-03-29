<%@page import="kr.qtorder.model.OrderStateNowVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.qtorder.model.ReceiptVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>QTOrder</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/yg.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.png" />
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
    </head>
    <body style="background-color: #FA823C">
    <%
    	List<OrderStateNowVO> state_now = (List<OrderStateNowVO>) request.getAttribute("state_now");
    	
    %>
        <div id="qtlayer-up" class="qtlayer-up" style="display: flex; justify-content: center; align-items: center;">
	    <div style="text-align: center;">
	    <div style="display: inline-block;">
	        <a class="btn" href="storelist.do"><i data-feather="shopping-bag" style="font-size: 24px;"></i>상점</a>
	    </div>
	    <div class="separator"></div>
	    <div style="display: inline-block;">
	        <a class="btn" href="user_viewMap.do"><i data-feather="map-pin" style="font-size: 24px;"></i>지도</a>
	    </div>
	    <div class="separator"></div>
	    <div style="display: inline-block;" class="dropdown">
	    <button id="dropdownMenuButton" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button"><i data-feather="file-text" style="font-size: 24px;"></i>주문</button>
	    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	    	<a class="dropdown-item" href=".do">주문현황</a>
	        <a class="dropdown-item" href="getreceipt.do">영수증</a>
	        </div>
	    </div>
		</div>
	</div>

	<div id="empty"></div>
    	<div id="layoutSidenav_content">
        	<main>
            	<div class="container-xl px-4 mt-4">
                	<% int previousOrderIdx = -1; %>
					<% boolean firstOrder = true; %>
						
					<div class="invoice-container">
						<% int totalPrice = 0; %>
						<% for (OrderStateNowVO order : state_now) { %>
							<% if (order.getOrder_idx() != previousOrderIdx) { %>
						        <!-- 이전 주문의 총 금액을 출력하고 이전 주문 그룹을 닫음 -->
						    	<% if (!firstOrder) { %>
						            <!-- 총 금액 출력 -->
						            <div class="card invoice">
						                <div class="card-body p-4 p-md-5">
						                    <div class="table-responsive">
						                        <table class="table table-borderless mb-0">
						                            <tbody>
						                                <tr>
						                                    <td class="text-end pb-0"><div class="text-uppercase small fw-700 text-muted">총 금액 :</div></td>
						                                    <td class="text-end pb-0" colspan="3"><div class="h5 mb-0 fw-700"><%= totalPrice %> 원</div></td>
						                                </tr>
						                            </tbody>
						                        </table>
						                    </div>
						                </div>
						            </div>
						        <% } %>
						        <!-- 새로운 주문 그룹 시작 -->
						        <% totalPrice = 0; %>
						        <div class="card invoice">
						            <div class="card-body p-4 p-md-5">
						                <div class="table-responsive">
						                    <table class="table table-borderless mb-0">
						                        <tbody>
						                            <!-- 주문 정보 출력 -->
						                            <tr>
						        	                    <td colspan="3">
						                                    <div class="fw-bold"><%= order.getFt_name() %></div>
						                                </td>
						                                <td>
						                                    <div class="fw-bold"><%= order.getOrder_state() %></div>
						                                </td>
						                            </tr>
						                            <tr>
						                                <td colspan="4">
						                                    <div class="fw-bold"><%= order.getOrdered_at() %></div>
						                                </td>
						                            </tr>
        					<% } %>
        
												    <tr>
												        <td colspan="2">
												            <div class="fw-bold"><%= order.getMenu_name() %></div>
												        </td>
												        <td class="text-end fw-bold"><%= order.getMenu_cnt() %></td>
												        <td class="text-end fw-bold"><%= order.getMenu_price() * order.getMenu_cnt() %></td>
												    </tr>
												    <!-- 현재 주문의 총 금액 누적 -->
												    <% totalPrice += order.getMenu_price() * order.getMenu_cnt(); %>
												    <!-- 마지막 주문 그룹에 대한 총 계산 -->
												    <% if (order.getOrder_idx() == state_now.get(state_now.size() - 1).getOrder_idx()) { %>
												        <tr>
												            <td class="text-end pb-0"><div class="text-uppercase small fw-700 text-muted">총 금액 :</div></td>
												            <td class="text-end pb-0" colspan="3"><div class="h5 mb-0 fw-700"><%= totalPrice %> 원</div></td>
												        </tr>
												    <% } %>
												    <% previousOrderIdx = order.getOrder_idx(); %>
												    <% firstOrder = false; %>
												<% } %>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
                		</main>
                 <script type="text/javascript">
                	
                </script>
            </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>