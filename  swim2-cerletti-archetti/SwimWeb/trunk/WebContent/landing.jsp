<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String retry = (String) session.getAttribute("retry");
	Boolean showLanding = false, retryLogin = false, retryRegistration = false;

	if (retry != null) {
		session.removeAttribute("retry");
		retryLogin = retry.equals("login");
		retryRegistration = retry.equals("registration");
		request.removeAttribute("retry");
	} else {
		showLanding = true;
	}

	String bodyClass = (showLanding ? "welcome" : "retry");
	request.setAttribute("selectedTab", UnloggedMenu.HOME);
%>


<%@ include file="shared/head.jsp"%>
<body class="swim <%=bodyClass%>">
	<%@include file="shared/header.jsp"%>
	<div id="swimContentContainer">
		<div id="swimContent" class="topWidthElement">
			<%
				if (showLanding) {
			%>
			<div class="pageHeading">
				<h1 class="pageTitle">Benvenuto su Swim</h1>
			</div>
			<%
				}
			%>
			<div class="monoPageContent">
				<%
					if (showLanding) {
				%>
				<div id="welcomeImage" class="welcomeColumn"></div>
				<%
					}
				%>
				<div class="formContainer welcomeColumn">
					<%
						if (showLanding || retryRegistration) {
					%>
					<h2>Registrati! &Egrave; gratis, e lo sar� sempre.</h2>
					<form id="regForm"
						action="<%=request.getContextPath()%>/register" method="post"
						class="welcomeForm">
						<div class="inputLine">
							<label class="inputLabel" for="username">Username</label> <input
								type="text" id="username" name="username" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="email">Email</label> <input
								type="text" id="email" name="email" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="name">Nome</label> <input
								type="text" id="name" name="name" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="surname">Cognome</label> <input
								type="text" id="surname" name="surname" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="password">Password</label> <input
								type="password" id="password" name="password" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="passwordrepeat">Ripeti
								password</label> <input type="password" id="passwordrepeat"
								name="passwordrepeat" class="inputtext" />
						</div>
						<div class="submitLine">
							<input type="submit" value="Registrati" class="inputsubmit" />
						</div>
					</form>
					<%
						} else if (retryLogin) {
					%>
					<p class="error">I dati inseriti non sono corretti, per favore
						riprova.</p>
					<form id="secLoginForm"
						action="<%=request.getContextPath() + "/login"%>" method="post"
						class="welcomeForm">
						<div class="inputLine">
							<label class="inputLabel" for="secUsername">Username</label> <input
								type="text" id="secUsername" name="username" class="inputtext" />
						</div>
						<div class="inputLine">
							<label class="inputLabel" for="secPassword">Password</label> <input
								type="password" id="secPassword" name="password"
								class="inputtext" />
						</div>
						<div class="submitLine">
							<input type="submit" value="Login" class="inputsubmit" />
						</div>
					</form>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<%@include file="shared/footer.jsp"%>
	</div>
</body>
</html>