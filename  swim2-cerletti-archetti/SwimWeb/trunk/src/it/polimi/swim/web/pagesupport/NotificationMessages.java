package it.polimi.swim.web.pagesupport;

/**
 * NotificationMessages is an enumeration that contains all the possible
 * notification a user can visualize.
 */
public enum NotificationMessages {

	EMAIL_CHANGED("L'indirizzo email � stato modificato."),
	PASSWORD_CHANGED("La password � stata modificata."),
	DETAILS_CHANGED("I tuoi dati sono stati aggiornati."),
	ABILITY_ADDED("La nuova professionalit&agrave; � stata aggiunta."),
	REQUEST_SENT("La richiesta � stata inviata."),
	ABILITY_REMOVED("L'abilit&agrave; &egrave; stata rimossa."),
	EMAIL_VALIDATED("L'indirizzo email � stato convalidato."),
	ABILITY_REQ_REFUSED("La richiesta � stata rifiutata."),
	PHOTO_CHANGED("La tua foto del profilo � stata modificata.");

	private String description;

	NotificationMessages(String description) {
		this.description = description;
	}

	/**
	 * Getter method.
	 * 
	 * @return a String that contains this notification.
	 */
	public String getDescription() {
		return description;
	}
}
