<%@ page import="com.exodiashop.shop.Service.UserService" %>
<%@ page import="com.exodiashop.shop.Model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- Bootstrap styles -->
      <link href="/libs/bootstrap.css" rel="stylesheet"/>
      <link href="/libs/style.css" rel="stylesheet"/>

    
    </head>
<body>
    <%User loggedUser = new User(); loggedUser.setUsername(request.getParameter("username"));%>

    <div class="container">
        <jsp:include page="/components/header.jsp" />
        <jsp:include page="/components/navbar.jsp" />


    <div class="row">
        <jsp:include page="/components/sidebar.jsp" />
	<div class="span9" style="background-color:rgba(0, 0, 0, 0.0);">
	<div class="well well-small">
	<div class="row-fluid">
			<div class="span5">
			<div id="myCarousel" class="carousel slide cntr">
                <div class="carousel-inner">
                  <div class="item active">
                   <a href="#"> <img src="${product.img_path}" alt="" style="width:100%"></a>
                  </div>

                </div>

            </div>
			</div>
			<div class="span7" style="background-color:rgba(0, 0, 0, 0.0);">
				<h3>${product.name} [$${product.price}]</h3>
				<hr class="soft"/>

 <br><br>
				  <br><br>
                <h4>Seller: ${product.seller} </h4>
                <h4>Gender: ${product.gender} </h4>
                <h4>Color: ${product.color} </h4>
                <h4>Size: ${product.size} </h4>
				  <h4>${product.stock_number} items in stock</h4>
				  <p>
				  <br><br>

				  </p>
				  <button type="submit" class="shopBtn"><span class=" icon-shopping-cart"></span> Add to cart</button>
				</form>
			</div>
			</div>
				<hr class="softn clr"/>


           
            
</div>
</div>
</div> <!-- Body wrapper -->

    </div>
</div><!-- /container -->


  </body>
</html>
