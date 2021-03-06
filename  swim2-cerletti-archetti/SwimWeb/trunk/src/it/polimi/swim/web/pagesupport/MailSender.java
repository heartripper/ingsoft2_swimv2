package it.polimi.swim.web.pagesupport;

import java.io.IOException;

/**
 * MailSender is a class that manages the sending of an email message.
 */
public class MailSender {

	private static final String pwdResetStartMessage = "Hai"
			+ " richiesto di resettare la tua password. Per confermare,"
			+ " clicca sul link sottostante. Se non hai effettuato tu la"
			+ " richiesta, ignora questa mail.\n\n";

	private static final String pwdResetStartSubject = "Richiesta di reset password.";

	private static final String pwdResetConfMessage = "La password � stata reimpostata."
			+ "\n\nLa tua nuova password � %s. Ora puoi accedere a Swim con la nuova "
			+ "password e, una volta autenticato, potrai cambiare la password";

	private static final String pwdResetConfSubject = "Password reimpostata.";

	private static final String emailConfirmationMessage = "Per convalidare il tuo "
			+ "indirizzo email, copia e incolla nel tuo browser il link sottostante.\n\n";

	private static final String emailConfirmationSubject = "Conferma email swim";

	/**
	 * This method sends an email to a user which contains the link to put in
	 * the address bar of the browser in order to confirm the received password
	 * request.
	 * 
	 * @param customerMail
	 *            a String that contains the user email address.
	 * @param resetLink
	 *            a String that contains the path that the user has to put in
	 *            the address bar of the browser.
	 */
	public static void sendPasswordResetStartEmail(String customerMail,
			String resetLink) {
		MailMessage email = new MailMessage(customerMail, pwdResetStartSubject,
				pwdResetStartMessage + resetLink);

		try {
			email.sendMail();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * This method sends an email to a user which contains a new password
	 * generated by the system that the user can use to authenticate after a
	 * password reset request.
	 * 
	 * @param customerMail
	 *            a String that contains the user email address.
	 * @param newPassword
	 *            a String that contains the new password generated by the
	 *            system.
	 */
	public static void sendPasswordResetConfirmEmail(String customerMail,
			String newPassword) {
		MailMessage email = new MailMessage(customerMail, pwdResetConfSubject,
				String.format(pwdResetConfMessage, newPassword));

		try {
			email.sendMail();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * This method sends an email to a user in order to validate the given email
	 * address.
	 * 
	 * @param email
	 *            a String that contains the user email address.
	 * @param link
	 *            a String that contains a path that the user has to put in the
	 *            address bar in order to validate the given email address.
	 */
	public static void sendValidationEmail(String email, String link) {
		String message = emailConfirmationMessage + link;

		MailMessage mess = new MailMessage(email, emailConfirmationSubject,
				message);

		try {
			mess.sendMail();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
