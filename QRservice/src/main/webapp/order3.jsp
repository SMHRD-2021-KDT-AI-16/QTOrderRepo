<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.io.*"%>
<%@ page import="kr.qtorder.model.MenuVO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <style>
         html {
             height: 100%;
         }
         
         body {
             font-family: sans-serif;
             height: 100%;
             margin: 0;
         }
         
         .container {
             display: flex;
             height: 100%;
             flex-direction: column;
         }
         
         .image-upload {
             flex: 1;
             display: flex;
             flex-direction: column;
             justify-content: center;
         }
         
         .button {
             display: flex;
             justify-content: center;
         }
         
         label {
             cursor: pointer;
             font-size: 1em;
         }
         
         #chooseFile {
             visibility: hidden;
         }
         
         .fileContainer {
             display: flex;
             justify-content: center;
             align-items: center;
         }
         
         .fileInput {
             display: flex;
             align-items: center;
             border-bottom: solid 2px black;
             width: 60%;
             height: 30px;
         }
         
         #fileName {
             margin-left: 5px;
         }
         
         .buttonContainer {
             width: 15%;
             display: flex;
             justify-content: center;
             align-items: center;
             margin-left: 10px;
             background-color: black;
             color: white;
             border-radius: 30px;
             padding: 10px;
             font-size: 0.8em;
         
             cursor: pointer;
         }
         
         .image-show {
             z-index: -1;
             display: flex;
             justify-content: center;
             align-items: center;
             position: absolute;
             width: 100%;
             height: 100%;
         }
         
         
         .image-thumnail {
            width: 50%;
            height: 50%;
            object-fit: cover;
         }
         
         .btn-menu-drag {
           width: 70px;
           height: 70px;
           border: none;
           border-radius: 8px;
           margin: 12px;
           cursor: move;
           font-size: 30px;
           background: #eaeaea4f;
         }         
         
         .draggable.dragging {
           opacity: 0.5;
         }
         
         .drag-container {
           margin: 10px;
           padding: 10px;
           background-color: #b5c1dc57;
           border-radius: 8px;
         }
         
         .drag-menu {
            background-color: #ffffff;
         }
         /*  Vue CSS   */
         body {
           margin: 40px 0;
           font-family: "Raleway";
           font-size: 14px;
           font-weight: 500;
           background-color: #BCAAA4;
           -webkit-font-smoothing: antialiased;
         }
         
         .title {
           font-family: "Raleway";
           font-size: 24px;
           font-weight: 700;
           color: #5D4037;
           text-align: center;
         }
         
         p {
           line-height: 1.5em;
         }
         
         h1 + p, p + p {
           margin-top: 10px;
         }
         
         .vue-container {
           padding: 40px 80px;
           display: flex;
           /* flex-wrap: wrap;
           justify-content: center; */
           overflow-x: auto;
           transition: transform 0.5s ease-out;
         }
         
         .vue-card-wrap {
           margin: 30px;
           transform: perspective(800px);
           transform-style: preserve-3d;
           flex: 0 0 auto;
           cursor: pointer;
         }
         
         .vue-card-wrap:hover .vue-card-info {
           transform: translateY(0);
           transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1);
         }
         
         .vue-card-wrap:hover .vue-card-info p {
           opacity: 1;
           transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1);
         }
         
         .vue-card-wrap:hover .vue-card-info:after {
           transition: 5s cubic-bezier(0.23, 1, 0.32, 1);
           opacity: 1;
           transform: translateY(0);           
         }
         
         .vue-card-wrap:hover .vue-card-bg {
           transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1), opacity 5s cubic-bezier(0.23, 1, 0.32, 1);
           opacity: 0.8;
         }
         
         .vue-card-wrap:hover .vue-card {
           transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1), box-shadow 2s cubic-bezier(0.23, 1, 0.32, 1);
           box-shadow: rgba(255, 255, 255, 0.2) 0 0 40px 5px, rgba(255, 255, 255, 1) 0 0 0 1px, rgba(0, 0, 0, 0.66) 0 30px 60px 0, inset #333 0 0 0 5px, inset white 0 0 0 6px;
         }
         
         .vue-card {
           position: relative;
           flex: 0 0 240px;
           width: 360px;
           height: 480px;
           background-color: #333;
           overflow: hidden;
           border-radius: 10px;
           box-shadow: rgba(0, 0, 0, 0.66) 0 30px 60px 0, inset #333 0 0 0 5px, inset rgba(255, 255, 255, 0.5) 0 0 0 6px;
           transition: 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);           
         }
         
         .vue-card-bg {
           opacity: 0.5;
           position: absolute;
           top: -20px;
           left: -20px;
           width: 100%;
           height: 100%;
           padding: 20px;
           background-repeat: no-repeat;
           background-position: center;
           background-size: cover;
           transition: 1s cubic-bezier(0.445, 0.05, 0.55, 0.95), opacity 5s 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);
           pointer-events: none;      
           box-sizing: content-box;
         }         
         
         .vue-card-info {
           padding: 20px;
           position: absolute;
           bottom: 0;
           color: #fff;
           transform: translateY(40%);
           transition: 0.6s 1.6s cubic-bezier(0.215, 0.61, 0.355, 1);
         }
         
         .vue-card-info p {
           opacity: 1;
           text-shadow: rgba(0, 0, 0, 1) 0 2px 3px;
           transition: 0.6s 1.6s cubic-bezier(0.215, 0.61, 0.355, 1);
           font-size: 40px;
         }
         
         .vue-card-info * {
           position: relative;
           z-index: 1;
         }
         
         .vue-card-info:after {
           content: '';
           position: absolute;
           top: 0;
           left: 0;
           z-index: 0;
           width: 100%;
           height: 100%;
           background-image: linear-gradient(to bottom, transparent 0%, rgba(0, 0, 0, 0.6) 100%);
           background-blend-mode: overlay;
           opacity: 0;
           transform: translateY(100%);
           transition: 5s 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);
         }
         
         .vue-card-info h1 {
           font-family: "Playfair Display";
           font-size: 40px;
           font-weight: 700;
           text-shadow: rgba(0, 0, 0, 0.5) 0 10px 10px;
           color: #fff;           
         }
         .corner-tag {
           position: absolute;
           top: 0px; /* 위쪽으로부터의 거리 */
           left: 0px; /* 왼쪽으로부터의 거리 */
           background-color: #ff6b6b;
           color: white;
           border-radius: 10%;
           font-weight: bold;
           font-size: 80px;
           text-align: center;
           height: 25%;
           width: 33%;
           transform: translate(0%, 0%); /* 위치 조정 및 회전 */
           z-index: 100;
           box-shadow: rgba(0, 0, 0, 0.66) 0 30px 60px 0, inset #555555 0 0 0 2px, inset rgba(255, 255, 255, 0.5) 0 0 0 6px;
         }
         .corner-tag2 {
           position: absolute;
           top: 25px; /* 위쪽으로부터의 거리 */
           right: -25px; /* 왼쪽으로부터의 거리 */
           background-color: #00cfd5;
           color: white;
           padding: 5px 10px;
           border-radius: 10%;
           font-weight: bold;
           font-size: 20px;
           transform: translate(-50%, -50%); /* 위치 조정 및 회전 */
           z-index: 1000;
         }
         
         #order-detail-num {
           position: absolute;
           background-color: #ff6b6b;
           font-size: 80px;
           font-weight: bold;
           color: white;
           top: 50px; 
           right: 0;
           transform: translate(50%, -50%); 
           border-radius: 10%;
           width: 100px; 
           height: 100px; 
           text-align: center; 
         }
      </style>
      <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Affiliate Dashboard - SB Admin Pro</title>
        <link href="https://cdn.jsdelivr.net/npm/litepicker/dist/css/litepicker.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="nav-fixed sidenav-toggled" style="background-color:#bcaaa4">
        <nav class="topnav navbar navbar-expand shadow justify-content-between justify-content-sm-start navbar-light bg-white" id="sidenavAccordion">
            <!-- Sidenav Toggle Button-->
            <button class="btn btn-icon btn-transparent-dark order-1 order-lg-0 me-2 ms-lg-2 me-lg-0" id="sidebarToggle"><i data-feather="menu"></i></button>
            <!-- Navbar Brand-->
            <!-- * * Tip * * You can use text or an image for your navbar brand.-->
            <!-- * * * * * * When using an image, we recommend the SVG format.-->
            <!-- * * * * * * Dimensions: Maximum height: 32px, maximum width: 240px-->
            <a class="navbar-brand pe-3 ps-4 ps-lg-2" href="index.html">SB Admin Pro</a>
            <!-- Navbar Search Input-->
            <!-- * * Note: * * Visible only on and above the lg breakpoint-->
            <form class="form-inline me-auto d-none d-lg-block me-3">
                <div class="input-group input-group-joined input-group-solid">
                    <input class="form-control pe-0" type="search" placeholder="Search" aria-label="Search" />
                    <div class="input-group-text"><i data-feather="search"></i></div>
                </div>
            </form>
            <!-- Navbar Items-->
            <ul class="navbar-nav align-items-center ms-auto">
                <!-- Documentation Dropdown-->
                <li class="nav-item dropdown no-caret d-none d-md-block me-3">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownDocs" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="fw-500">Documentation</div>
                        <i class="fas fa-chevron-right dropdown-arrow"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end py-0 me-sm-n15 me-lg-0 o-hidden animated--fade-in-up" aria-labelledby="navbarDropdownDocs">
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-admin-pro" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="book"></i></div>
                            <div>
                                <div class="small text-gray-500">Documentation</div>
                                Usage instructions and reference
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-admin-pro/components" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="code"></i></div>
                            <div>
                                <div class="small text-gray-500">Components</div>
                                Code snippets and reference
                            </div>
                        </a>
                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item py-3" href="https://docs.startbootstrap.com/sb-admin-pro/changelog" target="_blank">
                            <div class="icon-stack bg-primary-soft text-primary me-4"><i data-feather="file-text"></i></div>
                            <div>
                                <div class="small text-gray-500">Changelog</div>
                                Updates and changes
                            </div>
                        </a>
                    </div>
                </li>
                <!-- Navbar Search Dropdown-->
                <!-- * * Note: * * Visible only below the lg breakpoint-->
                <li class="nav-item dropdown no-caret me-3 d-lg-none">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="searchDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="search"></i></a>
                    <!-- Dropdown - Search-->
                    <div class="dropdown-menu dropdown-menu-end p-3 shadow animated--fade-in-up" aria-labelledby="searchDropdown">
                        <form class="form-inline me-auto w-100">
                            <div class="input-group input-group-joined input-group-solid">
                                <input class="form-control pe-0" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
                                <div class="input-group-text"><i data-feather="search"></i></div>
                            </div>
                        </form>
                    </div>
                </li>
                <!-- Alerts Dropdown-->
                <li class="nav-item dropdown no-caret d-none d-sm-block me-3 dropdown-notifications">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownAlerts" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="bell"></i></a>
                    <div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownAlerts">
                        <h6 class="dropdown-header dropdown-notifications-header">
                            <i class="me-2" data-feather="bell"></i>
                            Alerts Center
                        </h6>
                        <!-- Example Alert 1-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <div class="dropdown-notifications-item-icon bg-warning"><i data-feather="activity"></i></div>
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-details">December 29, 2021</div>
                                <div class="dropdown-notifications-item-content-text">This is an alert message. It's nothing serious, but it requires your attention.</div>
                            </div>
                        </a>
                        <!-- Example Alert 2-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <div class="dropdown-notifications-item-icon bg-info"><i data-feather="bar-chart"></i></div>
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-details">December 22, 2021</div>
                                <div class="dropdown-notifications-item-content-text">A new monthly report is ready. Click here to view!</div>
                            </div>
                        </a>
                        <!-- Example Alert 3-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <div class="dropdown-notifications-item-icon bg-danger"><i class="fas fa-exclamation-triangle"></i></div>
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-details">December 8, 2021</div>
                                <div class="dropdown-notifications-item-content-text">Critical system failure, systems shutting down.</div>
                            </div>
                        </a>
                        <!-- Example Alert 4-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <div class="dropdown-notifications-item-icon bg-success"><i data-feather="user-plus"></i></div>
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-details">December 2, 2021</div>
                                <div class="dropdown-notifications-item-content-text">New user request. Woody has requested access to the organization.</div>
                            </div>
                        </a>
                        <a class="dropdown-item dropdown-notifications-footer" href="#!">View All Alerts</a>
                    </div>
                </li>
                <!-- Messages Dropdown-->
                <li class="nav-item dropdown no-caret d-none d-sm-block me-3 dropdown-notifications">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownMessages" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="mail"></i></a>
                    <div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownMessages">
                        <h6 class="dropdown-header dropdown-notifications-header">
                            <i class="me-2" data-feather="mail"></i>
                            Message Center
                        </h6>
                        <!-- Example Message 1  -->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <img class="dropdown-notifications-item-img" src="assets/img/illustrations/profiles/profile-2.png" />
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
                                <div class="dropdown-notifications-item-content-details">Thomas Wilcox · 58m</div>
                            </div>
                        </a>
                        <!-- Example Message 2-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <img class="dropdown-notifications-item-img" src="assets/img/illustrations/profiles/profile-3.png" />
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
                                <div class="dropdown-notifications-item-content-details">Emily Fowler · 2d</div>
                            </div>
                        </a>
                        <!-- Example Message 3-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <img class="dropdown-notifications-item-img" src="assets/img/illustrations/profiles/profile-4.png" />
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
                                <div class="dropdown-notifications-item-content-details">Marshall Rosencrantz · 3d</div>
                            </div>
                        </a>
                        <!-- Example Message 4-->
                        <a class="dropdown-item dropdown-notifications-item" href="#!">
                            <img class="dropdown-notifications-item-img" src="assets/img/illustrations/profiles/profile-5.png" />
                            <div class="dropdown-notifications-item-content">
                                <div class="dropdown-notifications-item-content-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
                                <div class="dropdown-notifications-item-content-details">Colby Newton · 3d</div>
                            </div>
                        </a>
                        <!-- Footer Link-->
                        <a class="dropdown-item dropdown-notifications-footer" href="#!">Read All Messages</a>
                    </div>
                </li>
                <!-- User Dropdown-->
                <li class="nav-item dropdown no-caret dropdown-user me-3 me-lg-4">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownUserImage" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="img-fluid" src="assets/img/illustrations/profiles/profile-1.png" /></a>
                    <div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownUserImage">
                        <h6 class="dropdown-header d-flex align-items-center">
                            <img class="dropdown-user-img" src="assets/img/illustrations/profiles/profile-1.png" />
                            <div class="dropdown-user-details">
                                <div class="dropdown-user-details-name">Valerie Luna</div>
                                <div class="dropdown-user-details-email">vluna@aol.com</div>
                            </div>
                        </h6>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#!">
                            <div class="dropdown-item-icon"><i data-feather="settings"></i></div>
                            Account
                        </a>
                        <a class="dropdown-item" href="#!">
                            <div class="dropdown-item-icon"><i data-feather="log-out"></i></div>
                            Logout
                        </a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sidenav shadow-right sidenav-light">
                    <div class="sidenav-menu">
                        <div class="nav accordion" id="accordionSidenav">
                            <!-- Sidenav Menu Heading (Account)-->
                            <!-- * * Note: * * Visible only on and above the sm breakpoint-->
                            <div class="sidenav-menu-heading d-sm-none">Account</div>
                            <!-- Sidenav Link (Alerts)-->
                            <!-- * * Note: * * Visible only on and above the sm breakpoint-->
                            <a class="nav-link d-sm-none" href="#!">
                                <div class="nav-link-icon"><i data-feather="bell"></i></div>
                                Alerts
                                <span class="badge bg-warning-soft text-warning ms-auto">4 New!</span>
                            </a>
                            <!-- Sidenav Link (Messages)-->
                            <!-- * * Note: * * Visible only on and above the sm breakpoint-->
                            <a class="nav-link d-sm-none" href="#!">
                                <div class="nav-link-icon"><i data-feather="mail"></i></div>
                                Messages
                                <span class="badge bg-success-soft text-success ms-auto">2 New!</span>
                            </a>
                            <!-- Sidenav Menu Heading (Core)-->
                            <div class="sidenav-menu-heading">Core</div>
                            <!-- Sidenav Accordion (Dashboard)-->
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseDashboards" aria-expanded="false" aria-controls="collapseDashboards">
                                <div class="nav-link-icon"><i data-feather="activity"></i></div>
                                Dashboards
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseDashboards" data-bs-parent="#accordionSidenav">
                                <nav class="sidenav-menu-nested nav accordion" id="accordionSidenavPages">
                                    <a class="nav-link" href="dashboard-1.html">
                                        Default
                                        <span class="badge bg-primary-soft text-primary ms-auto">Updated</span>
                                    </a>
                                    <a class="nav-link" href="dashboard-2.html">Multipurpose</a>
                                    <a class="nav-link" href="dashboard-3.html">Affiliate</a>
                                </nav>
                            </div>
                            <div class="sidenav-menu-heading">Foodtruck</div>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="nav-link-icon"><i data-feather="grid"></i></div>
                                Menu
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" data-bs-parent="#accordionSidenav">
                                <nav class="sidenav-menu-nested nav accordion" id="accordionSidenavPagesMenu">
                                    <a class="nav-link" href="myTest.jsp">메인 사진</a>
                                    <a class="nav-link" href="myTest2.jsp">메뉴 등록</a>
                                    <a class="nav-link" href="myTest3.jsp">설정</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseApps" aria-expanded="false" aria-controls="collapseApps">
                                <div class="nav-link-icon"><i data-feather="globe"></i></div>
                                Order
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseApps" data-bs-parent="#accordionSidenav">
                                <nav class="sidenav-menu-nested nav accordion" id="accordionSidenavAppsMenu">
                                    <a class="nav-link" href="order.jsp">주문 현황</a>
                                    <a class="nav-link" href="#!">주문 표</a>
                                </nav>
                            </div>                            
                        </div>
                    </div>
                    <!-- Sidenav Footer-->
                    <div class="sidenav-footer">
                        <div class="sidenav-footer-content">
                            <div class="sidenav-footer-subtitle">Logged in as:</div>
                            <div class="sidenav-footer-title">Valerie Luna</div>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <div style="background-color:#bcaaa4; display: flex;">                     		            
                    <div id="order-menu-list" style="min-width: 250px; color: #ffffff; background-color:#355e3b; flex: 1; position: relative; z-index: 1000; min-height: 100vh">
                                             
                    </div>
                    <div style="flex: 3;">
                       	<div class="px-4 mt-5">
                           	<h1 class="title">Hover over the cards</h1>                              
	                       	<div id="app" class="vue-container" :style="{ 'transform': `translateX(\${translateX}px)` }">                     
								<card v-for="(order, index) in orders" :key="order.order_idx" :translate-x="translateX" @click.native="moveCardToFirst(index, order.order_idx)"
		                               data-image="https://media.istockphoto.com/id/157479378/ko/%EC%82%AC%EC%A7%84/%ED%95%AB%EB%8F%84%EA%B7%B8-%EB%A8%B8%EC%8A%A4%ED%84%B0%EB%93%9C%EC%99%80-%EC%BC%80%EC%B2%A9.jpg?s=612x612&w=0&k=20&c=108PFIu9ndXIOMoI7seKRti7ge3-s0Us2iay6duRRAM=">
		         
									<div slot="number" class="corner-tag"> {{order.order_idx}}</div>    
		                       	    <div slot="state" class="corner-tag2"> {{order.order_state}}</div>                    
		                        	   <h1 slot="header" style="display: flex">{{order.menu_name}}</h1>
		                        	   <p slot="content">외 {{order.order_cnt - 1}}건</p>
		                        </card>
							</div>
							<div>		                		
		                       	<button id="moveCardLeftButton">카드 이동</button>
		                       	<button id="moveCardRightButton">카드 이동</button>
		                       	<button id="startButton">영업 시작</button>
		                       	<button id="stopButton">영업 종료</button>
								<form id="orderForm" action="">
									<div>
										<input type="text" v-model= "inputNumber">
									</div>
									<button type="submit">제출</button>
									<div>
										<div>								
											<input type="radio" id="cooking" name="orderStatus"
												value="조리 중" required> <label for="cooking">조리 중</label>
										</div>
										<div>
											<input type="radio" id="cooked" name="orderStatus"
												value="조리 완료"> <label for="cooked">조리 완료</label>
										</div>
										<div>
											<input type="radio" id="delivered" name="orderStatus"
												value="주문 완료"> <label for="delivered">전달 완료</label>
										</div>
									</div>							
								</form>
							</div>   
						</div>
					</div>
				</div>
			</div>
		</div>
        <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>   
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="js/dragmove.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="assets/demo/chart-pie-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js" crossorigin="anonymous"></script>
        <script src="js/litepicker.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
    </body>
       
	<script type="text/javascript">
    	let order_menu_list = document.getElementById("order-menu-list")
           
		Vue.config.devtools = true;
    	
    	Vue.component('card', {
	        template: `
	        	<div class="vue-card-wrap"
		            @mousemove="handleMouseMove" @mouseenter="handleMouseEnter" @mouseleave="handleMouseLeave" ref="card">
    				<div class="vue-card" :style="cardStyle">
    					<slot name="number"></slot>
    					<slot name="state"></slot>
    					<div class="vue-card-bg" :style="[cardBgTransform, cardBgImage]"></div>
    					<div class="vue-card-info">
    						<slot name="header"></slot>
	                		<slot name="content"></slot>
	                	</div>
	            	</div>
	            </div>`,
			mounted() {
	            this.width = this.$refs.card.offsetWidth;
	            this.height = this.$refs.card.offsetHeight;
        	},
        	props: ['dataImage', 'translateX'],
        	data: () => ({
	          width: 0,
	          height: 0,
	          mouseX: 0,
	          mouseY: 0,
	          mouseLeaveDelay: null          
	        }),
        	computed: {
        		mousePX() {
        			return this.mouseX / this.width;
        		},
        		mousePY() {
        			return this.mouseY / this.height;
	        	},
	        	cardStyle() {
	            	const rX = this.mousePX * 30;
	            	const rY = this.mousePY * -30;
	            	return {
	            		transform: `rotateY(\${rX}deg) rotateX(\${rY}deg)`
	            	};
	            },
	            cardBgTransform() {
	            	const tX = this.mousePX * -40;
	            	const tY = this.mousePY * -40;
	            	return {
	            		transform: `translateX(\${tX}px) translateY(\${tY}px)`
	            	}
	            },
	            cardBgImage() {
	            	return {
	            		backgroundImage: `url(\${this.dataImage})`
	            	}
	            }
	        },
	        methods: {
	        	handleMouseMove(e) {             
		            this.mouseX = e.pageX - this.$refs.card.offsetLeft - this.width/2 - 270 - this.translateX;
		            this.mouseY = e.pageY - this.$refs.card.offsetTop - this.height/2 - 60 - 80;
		            if(this.mouseX <= -180) this.mouseX = -180;
		            if(this.mouseX >= 180) this.mouseX = 180;
	           
	            //console.log("this.$refs.card.offsetLeft")
	            //console.log(this.$refs.card.offsetLeft)
	          	},
	          	handleMouseEnter() {
	            	clearTimeout(this.mouseLeaveDelay);
	          	},
	          	handleMouseLeave() {
		            this.mouseLeaveDelay = setTimeout(()=>{
		            this.mouseX = 0;
		            this.mouseY = 0;
		            }, 500);
				}
			}
		});
      
    	const app = new Vue({
    		el: '#app',
	        data : {
	        	orders: [],
	        	order_num: [],
	        	translateX: 0,
	        	targetOrderIdx: 0,
	        	inputNumber: '',
	        },
	        mounted() {
	           this.fetchSessionValue()
	        },
	        methods: {
	        	fetchSessionValue() {
	        		$.ajax({
	        			type: "get",
	        			url: "CreateOrderList", // selectOrderList
	        			dataType: "json",
	        			success: (data) => {
	        				// 응답 받은 데이터를 orders 배열에 할당
	        				this.orders = data;
	        				const orderIds = [...new Set(data.map(order => order.order_idx))];
	        				this.order_num = orderIds;
	        				console.log(data)  
	        			},
	        			error: () => {
	        				console.log("error");
	        			}
	        		});
	        	},
	        	moveCardLeft() {
	        		const cardWidth = 415; // 카드 하나의 너비, 실제 너비에 맞게 조정 필요
	        		this.translateX -= cardWidth; // 왼쪽으로 이동할 거리 조정
	        	},
	        	moveCardRight() {
	        		const cardWidth = 415; // 카드 하나의 너비, 실제 너비에 맞게 조정 필요
	        		this.translateX += cardWidth; // 왼쪽으로 이동할 거리 조정
	        	},
	        	moveToCard() {
	        		console.log('moveToCard called', this.targetOrderIdx); 
	        		const targetIndex = this.orders.findIndex(order => order.order_idx == this.targetOrderIdx);
	        		if (targetIndex !== -1) {
	        			// 찾은 카드를 첫 번째 위치로 이동
	        			this.moveCardToFirst(targetIndex, this.targetOrderIdx);
	        		} else {
	        				alert("해당하는 카드가 없습니다.");
	        		}
	        	},
	        	moveCardToFirst(clickedCardIndex, order_idx) {
	        		const cardWidth = 415; // 카드 하나의 너비
	        		if (clickedCardIndex === -1) {
	        			return;
	        		}
	        		this.translateX = -cardWidth * clickedCardIndex;
	        		
	        		$.ajax({
	        			type: "get",
	        			url: "SelectOrderMenuDetail",
	        			data: {"order_idx" : order_idx},
	        			dataType: "json",
	        			success: function(data) {
	        				
	        				console.log(data)
	        				let element = "";
	        				order_menu_list.innerHTML = ""
	        				for(let i = 0; i < data.length; i++) {
	        					element += `
		        					<div> \${ data[i].menu_name } \${ data[i].menu_cnt}개 </div>
		        					<div> \${ data[i].mo_name } : \${ data[i].mo_notice }</div>
	        					`
	        				}
	        				element += `<div id="order-detail-num">\${ data[0].order_idx }</div>`;
							order_menu_list.insertAdjacentHTML("afterbegin", element)
						},
						error: function() {
							console.log("error");
						}
					})
				},
				handleFormSubmit(event) {
			        event.preventDefault(); // 폼의 기본 제출 동작을 방지
			        const orderIndexInput = document.querySelector("#orderForm input[type='text']");
			        const selectedOrderStatus = document.querySelector("input[name='orderStatus']:checked").value;
			      
			        if (orderIndexInput) {
			            this.targetOrderIdx = orderIndexInput.value; // 입력 필드에서 값을 읽어옴
			            this.moveToCard(); // moveToCard 메소드 호출
			            
			            $.ajax({
		        			type: "get",
		        			url: "ChangeOrderStatus",
		        			data: {
		        				"targetOrderIdx" : this.targetOrderIdx,
		        				"selectedOrderStatus" : selectedOrderStatus
		        			},
		        			//dataType: "json",
		        			success: function() {
		        				/* const divs = document.querySelectorAll('.corner-tag');
		        				const divs2 = document.querySelectorAll('.corner-tag2');
		        				const targetDiv = Array.from(divs).find(div => div.textContent.trim() === orderIndexInput.value);
		        				const targetDiv = Array.from(divs).find(div => div.textContent.trim() === orderIndexInput.value);
		        				console.log(targetDiv, "상태변경")
		        				if (targetDiv) {
		        				  // 찾은 요소의 텍스트 내용을 '80'으로 변경
		        				  targetDiv.textContent = selectedOrderStatus;
		        				  
		        				} */
		        				
		        				const cards = document.querySelectorAll('.vue-card');

		        				// .vue-card 요소를 순회하며 조건에 맞는 요소 찾기
		        				cards.forEach(card => {
		        				  // 현재 .vue-card 안의 .corner-tag 요소를 찾음
		        				  const cornerTag = card.querySelector('.corner-tag');
		        				  
		        				  // .corner-tag의 텍스트가 '8'인지 확인
		        				  if(cornerTag.textContent.trim() === orderIndexInput.value) {
		        				    // 조건에 맞는 .vue-card 안의 .corner-tag2 요소를 찾음
		        				    const cornerTag2 = card.querySelector('.corner-tag2');
		        				    // .corner-tag2의 텍스트를 '조리완료'로 변경
		        				    cornerTag2.textContent = selectedOrderStatus;
		        				  }
		        				});
							},
							error: function() {
								console.log("주문 상태 변경 error");
							}
						})	
			        }			        		         
			    }
			}
	    });
    	
    	document.addEventListener('DOMContentLoaded', function() {
			const moveCardLeftButton = document.getElementById('moveCardLeftButton');
			const moveCardRightButton = document.getElementById('moveCardRightButton');
			const orderForm = document.getElementById('orderForm');
			
			moveCardLeftButton.addEventListener('click', function() {
				app.moveCardLeft(); // Vue 인스턴스의 moveCard 메소드 호출
	        });
			moveCardRightButton.addEventListener('click', function() {
				app.moveCardRight(); // Vue 인스턴스의 moveCard 메소드 호출
			});			
			orderForm.addEventListener('submit', function(event) {
		        app.handleFormSubmit(event); // 폼 제출 이벤트 처리
		    });
		});
   </script>
   <script>
   // 음성인식
    const startButton = document.getElementById('startButton');
    const stopButton = document.getElementById('stopButton');
    let chunks = [];
    let isListening = false;

    // 오디오 녹음 시작 버튼 클릭
    startButton.onclick = function() {
        startButton.style.display = 'none';
        stopButton.style.display = 'block';
        
        navigator.mediaDevices.getUserMedia({ audio: true })
        .then(function(stream) {
            // 오디오 녹음 시작
            const mediaRecorder = new MediaRecorder(stream);
            mediaRecorder.start();
            console.log(mediaRecorder.state);
            
            // 오디오 데이터가 준비되면 실행
            mediaRecorder.ondataavailable = function(event) {
                chunks.push(event.data);
            }

            // 녹음 중지 버튼 클릭 시 처리
            stopButton.onclick = function() {
                mediaRecorder.stop();
            }

            // 녹음이 중지되면 실행
            mediaRecorder.onstop = function() {
                const blob = new Blob(chunks, { type: 'audio/wav' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'recorded_audio.wav';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
                chunks = [];
                startButton.style.display = 'block';
                stopButton.style.display = 'none';
            }

            // 음성 인식 시작
            startSpeechRecognition();
        })
        .catch(function(err) {
            console.error('오디오 녹음에 실패했습니다.', err);
        });
    }

 // 음성 인식 시작 함수
    function startSpeechRecognition() {
        if (!('webkitSpeechRecognition' in window)) {
            alert('웹 브라우저가 음성 인식을 지원하지 않습니다.');
            return;
        }

        const recognition = new webkitSpeechRecognition();
        recognition.lang = 'ko-KR';
        recognition.continuous = true;
        recognition.interimResults = false;

        recognition.onstart = function() {
            console.log('음성 인식이 시작되었습니다.');
        }

        recognition.onresult = function(event) {
            const transcript = event.results[0][0].transcript;
            console.log('인식된 텍스트:', transcript);
            
            if (transcript.includes('조리 중') || transcript.trim().includes('조리 중')) {
               
               console.log("조리중 인식");
               let order_idx;
               
               var match = transcript.match(/\b\d+번?\b/g);
               if (match !== null) {
                   console.log(match[0]); // "31번" 출력
                   if (order_idx === undefined) {
                       order_idx = match[0];
                   }
                   console.log("or ",order_idx); // "31번" 출력
               } else {
                   console.log("숫자를 찾을 수 없습니다.");
               }
                
                console.log("or2 ", order_idx);
               
                $.ajax({
        			type: "get",
                	url : 'ChangeOrderStatus',
                  	data: {
      					"targetOrderIdx" : order_idx,
      					"selectedOrderStatus" : '조리 중'
      				},
                  	success : function() {
                  		
                     	const cards = document.querySelectorAll('.vue-card');

     				// .vue-card 요소를 순회하며 조건에 맞는 요소 찾기
     					cards.forEach(card => {
     				  // 현재 .vue-card 안의 .corner-tag 요소를 찾음
     				  		const cornerTag = card.querySelector('.corner-tag');
     				  
     				  // .corner-tag의 텍스트가 '8'인지 확인
     				  		if(cornerTag.textContent.trim() === order_idx) {
     				    // 조건에 맞는 .vue-card 안의 .corner-tag2 요소를 찾음
     				    		const cornerTag2 = card.querySelector('.corner-tag2');
     				    // .corner-tag2의 텍스트를 '조리완료'로 변경
     				    		cornerTag2.textContent = '조리 중';
     				  		}
     					});
     				
                     // tts 부분
                     	let text = order_idx+"번 주문 조리 중으로 변경합니다.";
                        ttsTest(text);
                        console.log('주문상태를 조리중으로 변경하였습니다.');
                         
                         // sms 전송
                         //checkTimeAndExecuteService();
                        recognition.stop();
                        setTimeout(function() {
                             recognition.start();
                        }, 1000);  
                  },
                  error : function() {

                  }
               });
                recognition.stop();
                setTimeout(function() {
                    recognition.start();
                }, 1000); 
            }
            
            else if(transcript.includes('완료')){
               
               var match = transcript.match(/\b\d+번?\b/g);
               if (match !== null) {
                   console.log(match[0]); // "31번" 출력
                   if (order_idx === undefined) {
                       order_idx = match[0];
                   }
                   console.log("or ",order_idx); // "31번" 출력
               } else {
                   console.log("숫자를 찾을 수 없습니다.");
               }
                
                console.log("or2 ", order_idx);
                
                $.ajax({
                  url : 'http://localhost:8081/QRservice/changeOrderStatus2.do?order_idx='+order_idx,

                  success : function(result) {
                     console.log("re ",result);
                  if(result.row == 1){
                     // tts 부분
                     let text = order_idx+"번 주문 배송완료로 변경합니다.";
                         ttsTest(text);
                         console.log('주문상태를 배송완료로 변경하였습니다.');
                         
                         recognition.stop();
                         setTimeout(function() {
                             recognition.start();
                         }, 1000); 
                  }
                  },
                  error : function() {

                  }
               });
                
                recognition.stop();
                setTimeout(function() {
                    recognition.start();
                }, 1000);
            }
            
            else if(transcript.includes('취소')){
            let text = "주문 취소 처리되었습니다.";
                ttsTest(text);
                console.log('주문 취소 처리되었습니다.');
                
                recognition.stop();
                setTimeout(function() {
                    recognition.start();
                }, 1000);
            }
         
            else if(transcript.includes("큐티")){
            let text = "네. 말씀하세요.";
                ttsTest(text);
                
            recognition.stop();
                setTimeout(function() {
                    recognition.start();
                }, 1000);
         }else{
            recognition.stop();
            setTimeout(function() {
                    recognition.start();
                }, 1000);
         }
        }

        recognition.onerror = function(event) {
            console.error('음성 인식 중 오류가 발생했습니다.', event.error);
        }

        recognition.onend = function() {
            console.log('음성 인식이 종료되었습니다.');
            
            recognition.start();
        }

        recognition.start();
    }

 //tts 함수
 function ttsTest(text){
   var synth = window.speechSynthesis;

   var textToSpeak = text;

   var utterance = new SpeechSynthesisUtterance(textToSpeak);

   synth.speak(utterance);
 }
 
 function checkTimeAndExecuteService() {
   $.ajax({
      type: "POST",
       url: "http://localhost:8081/QRservice/postmsg.do",
       data: { /* 서비스에 필요한 데이터 */},
       success: function(response) {
                       
       },
       error: function(xhr, status, error) {
                       
       }
   });
      
}
   </script>
</body>
</html>