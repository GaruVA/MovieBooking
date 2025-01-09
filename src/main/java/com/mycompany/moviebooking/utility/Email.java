package com.mycompany.moviebooking.utility;

public class Email {
    private String recipient;
    private String subject;
    private String content;

    public Email(String recipient, String subject, String content) {
        this.recipient = recipient;
        this.subject = subject;
        this.content = content;
    }

    public void send() {
        EmailSenderUtility.sendEmailWithHtml(recipient, subject, content);
    }
}
