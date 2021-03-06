<%@page
	import="it.polimi.swim.web.servlets.GenericProfileServlet.FriendshipStatus"%>
<%@page import="it.polimi.swim.business.entity.WorkRequest"%>
<%@page import="it.polimi.swim.business.entity.Feedback"%>
<%@page import="it.polimi.swim.business.entity.Friendship"%>
<%@page import="it.polimi.swim.web.servlets.GenericProfileServlet"%>
<%@page
	import="it.polimi.swim.web.servlets.GenericProfileServlet.GenericProfileSection"%>
<%@page import="it.polimi.swim.web.servlets.CustomerFeedbackServlet"%>
<%@page
	import="it.polimi.swim.web.servlets.CustomerFeedbackServlet.CustomerFeedbackSection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	Object ref = request.getAttribute(Misc.SELECTED_SECTION_ATTR);
	GenericProfileSection selectedSection = (ref != null ? (GenericProfileSection) ref
			: GenericProfileSection.PROFILE);

	request.setAttribute(Misc.PAGE_TITLE_ATTR,
			selectedSection.getSectionName());

	Customer target = (Customer) request
			.getAttribute(Misc.USER_TO_SHOW);

	FriendshipStatus status = (FriendshipStatus) request
			.getAttribute(Misc.FRIENDSHIP_STATUS);

	List<?> friendList = (List<?>) request
			.getAttribute(Misc.FRIENDLIST_ATTR);

	List<?> feedbackList = (List<?>) request
			.getAttribute(Misc.FEEDBACK_LIST);

	List<?> abilityList = (List<?>) request
			.getAttribute(Misc.ABILITY_LIST);

	int friendCount = friendList.size();

	String ctx = request.getContextPath();
	String targetIdentity = String.format("%s %s", target.getName(),
			target.getSurname());

	Boolean canBeSentFriendshipReq = status
			.equals(FriendshipStatus.NOT_FRIENDS);
	Boolean canReceiveWorkRequests = (abilityList.size() != 0);
%>
<%@ include file="shared/head.jsp"%>
<body class="swim">
	<%@include file="shared/header.jsp"%>
	<div id="swimContentContainer">
		<div id="swimContent" class="topWidthElement">
			<div id="profileHeader">
				<div class="username headerElem">
					Profilo di <span class="bold"><%=targetIdentity%></span>
				</div>
				<div class="userControls headerElem">
					<%
						if (canBeSentFriendshipReq) {
					%>
					<form action="<%=ctx%>/user/sendfriendship" method="post">
						<input type="hidden" name="u" value="<%=target.getUsername()%>" />
						<input type="submit" value="<%=status.getButtonText()%>"
							class="inputsubmit" />
					</form>
					<%
						} else {
					%>
					<span class="disabledButton"><%=status.getButtonText()%></span>
					<%
						}
					%>
				</div>
				<div class="userControls headerElem">
					<%
						if (canReceiveWorkRequests) {
							String link = context + "/user/sendworkrequest?u="
									+ target.getUsername();
					%>
					<a href="<%=link%>" class="button">Invia richiesta di lavoro</a>
					<%
						} else {
					%>
					<span class="disabledButton">Non pu&ograve; ricevere
						richieste di lavoro</span>
					<%
						}
					%>
				</div>
			</div>
			<div id="leftColumn" class="column">
				<ul id="swimSecondaryMenu">
					<%
						for (GenericProfileSection s : GenericProfileSection.values()) {
							String link = ctx + "/" + GenericProfileServlet.CONTEXT_NAME
									+ "/" + s.getSectionIdentifier() + "?u="
									+ target.getUsername(), name = s.getSectionName();
							String selClass = selectedSection.equals(s) ? " selected" : "";
					%>
					<li class="entry<%=selClass%>"><a class="label"
						href="<%=link%>"><%=name%></a></li>
					<%
						}
					%>
				</ul>
			</div>
			<div id="rightColumn" class="column">
				<div class="pageHeading">
					<h1 class="pageTitle"><%=selectedSection.getSectionName()%></h1>
				</div>
				<div class="monoPageContent">
					<%
						switch (selectedSection) {
						case PROFILE:
					%>
					<%@include file="shared/userProfileDetails.jsp"%>

					<%
						break;
						case FEEDBACKS:
					%>

					<%
						if (feedbackList.size() == 0) {
					%>
					<p class="paragraph">L'utente non ha ricevuto feedback.</p>
					<%
						} else {
					%>
					<p class="paragraph">L'utente ha ricevuto i seguenti feedback:</p>
					<div class="feedbackList">
						<%
							for (Object o : feedbackList) {
										Feedback f = (Feedback) o;
										WorkRequest relatedWork = f.getLinkedRequest();
										Customer author = relatedWork.getSender();
										String identity = author.getName() + " "
												+ author.getSurname();
										String ability = relatedWork.getRequiredAbility()
												.getName();
										int feedbackMark = f.getMark();
										request.setAttribute(Misc.MARK_VALUE, feedbackMark);
										String reply = f.getReply();
						%>
						<div class="feedback">
							<p class=heading>
								<span class="bold">Autore:&nbsp;</span><%=identity%>
								&emsp;<span class="bold">Professionalit&agrave;:&nbsp;</span><%=ability%>
								&emsp;<span class="bold">Voto:&nbsp;</span>
								<%@include file="shared/feedbackMarker.jsp"%>
							</p>
							<p class="review">
								<span class="bold">Recensione:</span>&nbsp;<%=f.getReview()%>
							</p>
							<%
								if (reply != null) {
							%>
							<p class="reply">
								<span class="bold">Risposta:</span>&nbsp;<%=reply%>
							</p>
							<%
								}
							%>
						</div>
						<%
							}
						%>
					</div>
					<%
						}

							break;
						case FRIENDS:

							if (friendList.size() == 0) {
					%>
					<p class="text"><%=targetIdentity%>
						non ha nessun amico. Non vuoi essere tu il primo?
					</p>
					<%
						} else {
					%>
					<p class="paragraph"><%=targetIdentity%>
						ha
						<%=friendCount%>
						amic<%=friendCount == 1 ? "o" : "i"%>:
					</p>
					<div class="propertyList reducedWidth withImage">
						<%
							for (Object o : friendList) {
										Friendship f = (Friendship) o;
										Customer sender = f.getSender(), receiver = f
												.getReceiver(), friend = (sender.getUsername()
												.equals(target.getUsername()) ? receiver
												: sender);

										String friendIdentity = String.format("%s %s",
												friend.getName(), friend.getSurname());
										String usrLink = context + "/user/?u="
												+ friend.getUsername();
										String thumb = context
												+ Misc.getThumbnailPhotoUrl(friend);
						%>
						<div class="property">
							<div class="propertyName">
								<div class="smallImageFrame">
									<img src="<%=thumb%>" alt="User image" />
								</div>
								<span class="afterImage"><a href="<%=usrLink%>"><%=friendIdentity%></a></span>
							</div>
						</div>
						<%
							}
						%>
					</div>
					<%
						}
					%>

					<%
						break;
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@include file="shared/footer.jsp"%>
</body>
</html>