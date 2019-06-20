<%@ page import="com.exodiashop.shop.Service.CookieService" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: eramas
  Date: 10.05.2019
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    CookieService cookieService = new CookieService();
    String loggedUsername = cookieService.getCookie(request, response, "loggedUsernameCookie");
    pageContext.setAttribute("loggedUsername", loggedUsername);
%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${loggedUser.username} profile</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap styles -->
    <link href="/libs/bootstrap.css" rel="stylesheet"/>
    <link href="/libs/style.css" rel="stylesheet"/>
    <link href="/libs/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link rel="shortcut icon" href="/img/logos/favicon.ico">
    <link href="/css/user.css" rel="stylesheet">

    <script>
        function openCity(evt, cityName) {
            // Declare all variables
            var i, tabcontent, tablinks;

            // Get all elements with class="tabcontent" and hide them
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }

            // Get all elements with class="tablinks" and remove the class "active"
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }

            // Show the current tab, and add an "active" class to the button that opened the tab
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
        }

    </script>

</head>
<body>

<% String message = (String)request.getAttribute("alertMsg");

%>

<script type="text/javascript">
    var msg = "<%=message%>";
    if (msg != "null")
        alert(msg);
</script>

<div class="container">

    <jsp:include page="/components/header.jsp" />
    <jsp:include page="/components/navbar.jsp" />

    <div class="well well-small">
        <div class="row-fluid">
            <ul class="thumbnails">
                <h1>${loggedUser.name} ${loggedUser.surname}</h1>
            </ul>


            <!-- Tab links -->
            <div class="tab">
                <button class="tablinks" onclick="openCity(event, 'ProfileDetails') " id="defaultOpen0">Profile Details</button>
                <c:if test="${loggedUser.role.equals('customer')}">
                    <button class="tablinks" onclick="openCity(event, 'ShoppingHistory') " id="defaultOpen0">Shopping History</button>
                </c:if>
                <c:if test="${loggedUser.role.equals('seller')}">
                    <button class="tablinks" onclick="openCity(event, 'SellerDetails') " id="defaultOpen1">Seller Profile</button>
                    <button class="tablinks" onclick="openCity(event, 'ProductTab') " id="defaultOpen1">Products</button>
                    <button class="tablinks" onclick="openCity(event, 'AddProduct')">Add Product</button>
                    <button class="tablinks" onclick="openCity(event, 'OrdersSeller') " >Orders</button>
                </c:if>
                <c:if test="${loggedUser.role.equals('admin')}">
                    <button class="tablinks" onclick="openCity(event, 'ProductTab') " id="defaultOpen1">Products</button>
                    <button class="tablinks" onclick="openCity(event, 'UserTab') " >Users</button>
                    <button class="tablinks" onclick="openCity(event, 'OrdersAdmin') " >Orders</button>
                </c:if>
            </div>

            <div id="ProfileDetails" class="tabcontent">
                <div class = "profile-table">
                    <img src="${loggedUser.profilePhoto}">
                    <hr class="softn clr"/>
                    <div id="myTabContent" class="tab-content tabWrapper">
                        <div class="tab-pane fade active in" id="ProfileTab">
                            <c:choose>
                                <c:when test="${isEdit == 1}">
                                    <form id="loginForm" action="/users/${loggedUser.username}/editProfileProcess" method="POST">
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Username:</td><td class="techSpecTD2"><input required="required" type="text" name="newUsername"  value="${loggedUser.username}" placeholder ="Enter new username" id="username" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Name: </td><td class="techSpecTD2"><input required="required" type="text" name="newName" value="${loggedUser.name}" placeholder ="Enter new name" id="name" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Surname:</td><td class="techSpecTD2"><input required="required" type="text" name="newSurname" value="${loggedUser.surname}" placeholder ="Enter new surname" id="surname" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Email: </td><td class="techSpecTD2"><input required="required" type="text" name="newEmail" value="${loggedUser.email}" placeholder ="Enter new email" id="email" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Password:</td><td class="techSpecTD2"><input required="required" type="password" name="newPassword" value="${loggedUser.password}" placeholder ="Enter new password" id="password" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1"></td><td class="techSpecTD2"><button id="login" name="login">Apply</button></td></tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-striped">
                                        <tbody>
                                        <tr class="techSpecRow"><td class="techSpecTD1">Username:</td><td class="techSpecTD2">${loggedUser.username}</td></tr>
                                        <tr class="techSpecRow"><td class="techSpecTD1">Name: </td><td class="techSpecTD2">${loggedUser.name}</td></tr>
                                        <tr class="techSpecRow"><td class="techSpecTD1">Surname:</td><td class="techSpecTD2">${loggedUser.surname}</td></tr>
                                        <tr class="techSpecRow"><td class="techSpecTD1">Email: </td><td class="techSpecTD2">${loggedUser.email}</td></tr>
                                        </tbody>
                                    </table>
                                    <form id="loginForm" action="/users/${loggedUser.username}/editProfile#ProfileTab" method="POST">
                                        <p>  <button type="submit" class="shopBtn">> Edit Profile </button></p>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div id="SellerDetails" class="tabcontent">
                <div class = "profile-table">
                    <img src="${loggedUser.profilePhoto}">
                    <hr class="softn clr"/>
                    <div id="myTContent" class="tab-content tabWrapper">
                        <div class="tab-pane fade active in" id="PrileTab">
                            <c:choose>
                                <c:when test="${isEdit == 1}">
                                    <form id="loginForm" action="/sellers/updateSellerProfile/${loggedUser.username}" method="POST">
                                        <table class="table table-striped">
                                            <tbody>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Name: </td><td class="techSpecTD2"><input required="required" type="text" name="newName" value="${seller.name}" placeholder ="Enter new name" id="nme" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1">Password:</td><td class="techSpecTD2"><input required="required" type="password" name="newPassword" value="${seller.password}" placeholder ="Enter new password" id="paord" /></td></tr>
                                            <tr class="techSpecRow"><td class="techSpecTD1"></td><td class="techSpecTD2"><button id="lin" name="login">Apply</button></td></tr>
                                            </tbody>
                                        </table>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-striped">
                                        <tbody>
                                        <tr class="techSpecRow"><td class="techSpecTD1">Name: </td><td class="techSpecTD2">${seller.name}</td></tr>
                                        </tbody>
                                    </table>
                                    <form id="loginForm" action="/users/${loggedUser.username}/editProfile#SellerProfileTab" method="POST">
                                        <p>  <button type="submit" class="shopBtn">> Edit Profile </button></p>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ShoppingHistory" class="tabcontent">
                <div class = "profile-table">
                    <hr class="softn clr"/>
                    <div class="tab-pane fade active in" id="Prof">
                        <c:choose>
                            <c:when test="${orderList.size() > 0}">
                                <table style="width: 100%">
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Products</th>
                                        <th>${AdminConfirmation}</th>
                                        <th>Finish the order</th>
                                    </tr>
                                    <c:forEach items="${orderList}" var="order">
                                        <tr>
                                            <td style="text-align: center">${order.getId()}</td>
                                            <td>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <th>ProductID</th>
                                                        <th>Product Page</th>
                                                    </tr>
                                                    <c:forEach items="${order.getProductIDs().split(',')}" var="p_id">
                                                        <tr style="text-align: center">
                                                            <td>${p_id}</td>
                                                            <td>
                                                                <form action="/product/${p_id}" method="post">
                                                                    <button style="border: 0px">go to the page</button>
                                                                    <input type="hidden" name="loggedUsername" value="${loggedUser.username}"/>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>

                                            </td>
                                            <td>

                                                <c:choose>
                                                    <c:when test="${order.isConfirmed() == 1}">
                                                        ${YES}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${NO}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.isConfirmed() == 1}">
                                                        <c:choose>
                                                            <c:when test="${order.isFinished() == 1}">
                                                                ${OrderDone}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="/finishOrder/${order.getId()}" method="post">
                                                                    <button>confirm order is reach to you !</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:when>
                                                    <c:otherwise>
                                                        ${WaitConfirmation}
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>

                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <h2 style="text-align: center">There is not order. Let's buy something !</h2>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div id="UserTab" class="tabcontent">
                <table style="width:100%; text-align:left">
                    <tr>
                        <th>Name</th>

                        <th></th>
                        <th></th>
                    </tr>

                    <c:forEach items="${user_list}" var="user">
                        <tr>
                            <td>${user.username}</td>

                            <td>
                                <form action="/DeleteUser" method="post">
                                    <input type="hidden" value="${user.username}" name="deletedUser"/>
                                    <input type="hidden" value="${loggedUsername}" name="loggedUsername"/>
                                    <button>X</button>
                                </form>
                            </td>

                        </tr>
                    </c:forEach>

                </table>

            </div>
            <div id="ProductTab" class="tabcontent">
                <table style="width:100%; text-align:left">
                    <tr style="text-align: center;font-size: 20px;">
                        <th>Image</th>
                        <th>Informations</th>
                        <th>Location</th>
                        <th>Delete</th>
                    </tr>

                    <c:forEach items="${product_list}" var="product">
                        <tr>
                            <form action="/editProduct/${product.id}" method="post">
                                <td><img src="${product.img_path}" height="100px" width="100px"></td>

                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>Name</td>
                                            <td><input type="text" name="newName" placeholder="${product.name}" value="${product.name}" /></td>
                                        </tr>

                                        <tr>
                                            <td>Brand</td>
                                            <td>${product.brand}</td>
                                        </tr>

                                        <tr>
                                            <td>Category</td>
                                            <td>${product.category}</td>
                                        </tr>

                                        <tr>
                                            <td>Number of Stock</td>
                                            <td><input type="text" name="newTotal" placeholder="${product.total}" value="${product.total}"/></td>
                                        </tr>

                                        <tr>
                                            <td>Price</td>
                                            <td><input type="text" name="newPrice" placeholder="${product.price}" value="${product.price}" /></td>
                                        </tr>
                                    </table>
                                    <p>
                                        <button>edit</button>
                                        <input type="hidden"  name="loggedUsername" value="${loggedUser.username}" placeholder="Search" class="search-query span2">
                                    </p>

                                </td>
                            </form>

                            <td>
                                <form action="/addLocation/${product.id}#ProductTab" method="post">
                                    <table>
                                        <tr>
                                            <p style="word-break: break-all; ">${product.location}</p>
                                        </tr>
                                        <tr>
                                            <td><input type="text" style="width: 100%;" name="newLocation" placeholder="" class="search-query span2"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <button>Add</button>
                                                <input type="hidden"  name="loggedUsername" value="${loggedUser.username}" placeholder="Search" class="search-query span2">
                                            </td>
                                        </tr>
                                    </table>
                                </form>

                                <form action="/deleteLocation/${product.id}#ProductTab" method="post">
                                    <table>
                                        <tr>
                                            <td><input type="text" style="width: 100%;" name="deletedLocation" placeholder="" class="search-query span2"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <button>delete</button>
                                                <input type="hidden"  name="loggedUsername" value="${loggedUser.username}" placeholder="Search" class="search-query span2">
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </td>

                            <td>
                                <form action="/deleteProduct/${product.id}" method="post">
                                    <button>X</button>
                                    <input type="hidden"  name="loggedUsername" value="${loggedUser.username}" placeholder="Search" class="search-query span2">
                                </form>
                            </td>

                        </tr>



                    </c:forEach>

                </table>

            </div>
            <div id="OrdersSeller" class="tabcontent">
                <p>List of orders</p>
            </div>
            <div id="OrdersAdmin" class="tabcontent">
                    <c:choose>
                        <c:when test="${orderList.size() > 0}">
                            <table style="width: 100%">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Products</th>
                                    <th>Confirm</th>
                                </tr>
                                <c:forEach items="${orderList}" var="order">
                                    <tr>
                                        <td style="text-align: center">${order.getId()}</td>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <th>ProductID</th>
                                                    <th>Product Page</th>
                                                </tr>
                                                <c:forEach items="${order.getProductIDs().split(',')}" var="p_id">
                                                    <tr style="text-align: center">
                                                        <td>${p_id}</td>
                                                        <td><a href="/product/${p_id}">go to the page</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>

                                        </td>
                                        <td>
                                            <form action="/confirmOrder/${order.getId()}" method="post">
                                                <button>confirm</button>
                                            </form>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <h2 style="text-align: center">There is not unconfirmed item</h2>
                        </c:otherwise>
                    </c:choose>


            </div>
            <div id="AddProduct" class="tabcontent">
                <form id="loorm" action="/addProduct/${loggedUser.username}" method="POST">
                    <table>
                        <tr>
                            <td>Name</td>
                            <td><input required="required" path="name" name="name" id="me" placeholder ="Product Name"/></td>
                            <td><errors path="name" cssClass="error" /></td>
                        </tr>
                        <tr>
                            <td>Gender</td>
                            <td><input required="required" path="gender" name="gender" id="gender" placeholder ="Gender"/></td>
                            <td><errors path="gender" cssClass="error" /></td>
                        </tr>

                        <tr>
                            <td>Brand</td>
                            <td><input required="required" path="brand" name="brand" id="brand" placeholder ="Brand"/></td>
                            <td><errors path="brand" cssClass="error" /></td>
                        </tr>

                        <tr>
                            <td>Color</td>
                            <td><input required="required" path="color" name="color" id="color" placeholder ="Color"/></td>
                            <td><errors path="color" cssClass="error" /></td>
                        </tr>
                        <tr>
                            <td>Type</td>
                            <td><input required="required" path="type" name="type" id="type" placeholder ="Type"/></td>
                            <td><errors path="type" cssClass="error" /></td>
                        </tr>

                        <tr>
                            <td>Category</td>
                            <td><input required="required" path="category" name="category" id="category" placeholder ="Category"/></td>
                            <td><errors path="brand" cssClass="error" /></td>
                        </tr>

                        <tr>
                            <td>Size</td>
                            <td><input required="required" path="size" name="size" id="size" placeholder ="Size"/></td>
                            <td><errors path="size" cssClass="error" /></td>
                        </tr>
                        <tr>
                            <td>Image</td>
                            <td><input required="required" path="img_path" name="img_path" id="img_path" placeholder ="Image"/></td>
                            <td><errors path="img_path" cssClass="error" /></td>
                        </tr>
                        <tr>
                            <td>Price</td>
                            <td><input required="required" path="price" name="price" id="price" placeholder ="Price"/></td>
                            <td><errors path="price" cssClass="error" /></td>
                        </tr>

                        <tr>
                            <td>Number of Stock</td>
                            <td><input required="required" path="total" name="total" id="total" placeholder ="Stock"/></td>
                            <td><errors path="total" cssClass="error" /></td>
                        </tr>
                    </table>

                    <p>  <button type="submit" class="shopBtn"> Add </button></p>
                </form>

            </div>

            <!- Set default view of the page ->
            <script>
            // Get the element with id="defaultOpen" and click on it
            var url = window.location.href;
            var arr = url.split('#');

            if (arr.length == 1) {
                document.getElementById("defaultOpen0").click();
            } else{
                if (arr[1] == "ProductTab"){
                    document.getElementById("defaultOpen1").click();
                }
                else if (arr[1] == "ProfileTab"){
                    document.getElementById("defaultOpen0").click();
                }
                else if (arr[1] == "SellerProfileTab"){
                    document.getElementById("defaultOpen0").click();
                }
            }
        </script>

        </div>
    </div>


</body>
</html>

