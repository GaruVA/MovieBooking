package com.mycompany.moviebooking.controller;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


public class TicketEmailCTL {
     public static void sendEmailWithHtml(String toEmail, String subject, String htmlContent) {
        String fromEmail = "yasinducsilva@gmail.com"; // Replace with your email
        String password = "vroy wkvg xlwt yhao";          // Replace with your email password
// set up and sen the email
        Properties props = new Properties();
        props.put("mail.debug", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("yasinducsilva@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("sniperdragon2003@outlook.com"));
            message.setSubject("This is your E-ticket");

            // Set the email content to HTML
            message.setContent(htmlContent, "text/html");

            Transport.send(message);
            System.out.println("HTML email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}   
