<%@page import="it.polimi.swim.web.pagesupport.MenuDescriptor"%>
<%@page import="it.polimi.swim.web.pagesupport.UnloggedMenu"%>
<%@page import="it.polimi.swim.web.pagesupport.AdminMenu"%>
<%@page import="it.polimi.swim.web.pagesupport.CustomerMenu"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	MenuDescriptor[] menuElements = null;
	Object logged = session.getAttribute("loggedIn");
	Boolean userLoggedIn = (logged != null) && (Boolean) logged;

	if (userLoggedIn) {
		String type = (String) session.getAttribute("usertype");
		if (type.equalsIgnoreCase("admin")) {
			menuElements = AdminMenu.values();
		} else {
			menuElements = CustomerMenu.values();
		}
	} else {
		menuElements = UnloggedMenu.values();
	}
%>
<div id="swimHeaderContainer">
	<div id="swimHeader" class="headerContent topWidthElement">
		<div id="swimLogoContainer">
			<a href="/" id="swimLogo"><img src="resources/icon-blank.png"
				alt="Swim Network" /></a>
		</div>
		<%
			if (userLoggedIn) {
				//Display user photo, name and surname
		%>
		<div id="swimUserAwareness">
			<div id="userImageFrame">
				<img src="resources/user-img.png" alt="user image" />
			</div>
			<span id="userControl"> <span id="userName">Dario
					Archetti</span><br /> <a id="userLogout" href="./.">Esci</a>
			</span>
		</div>
		<%
			} else {
				//Display form to login
		%>
		<form name="login" id="loginForm"
			action="<%=request.getContextPath() + "/landing/login"%>">
			<div class="loginInputContainer">
				<label for="username" class="label">Username</label><br /> <input
					type="text" id="username" class="textinput" name="username"
					tabindex="1" />
			</div>
			<div class="loginInputContainer">
				<label for="password" class="label">Password</label><br /> <input
					type="password" id="password" class="textinput" name="password"
					tabindex="2" />
			</div>
			<div class="loginInputContainer">
				<input type="submit" id="submit" class="buttoninput" value="Login"
					tabindex="3" />
			</div>
		</form>


		<%
			}
		%>
	</div>
	<div id="swimMenuContainer" class="headerContent topWidthElement">
		<ul id="swimMenu">
			<%
				if (menuElements != null) {
					for (MenuDescriptor m : menuElements) {
			%>
			<li class="menuEntry" id="<%=m.getElementId()%>"><a
				class="tabLink"
				href="<%=request.getContextPath() + m.getTabLink()%>"> <img
					class="tabIcon" src="resources/icon-blank.png" alt="icon" /> <span
					class="tabTitle"><%=m.getTabName()%></span>
			</a></li>
			<%
				}
				}
			%>
		</ul>
	</div>
</div>


