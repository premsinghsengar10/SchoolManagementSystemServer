package com.manhattan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.manhattan.bean.User;
import com.manhattan.repo.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JavaMailSender mailSender;

    // Register a new user and send credentials
    public String registerUser(User user) {
        if (userRepository.findByUsername(user.getUsername()) != null) {
            return "exists"; // username already taken
        }

        userRepository.save(user);

        // send mail after registration
        sendRegistrationEmail(user);

        return "success";
    }

    private void sendRegistrationEmail(User user) {
        try {
            String toEmail = user.getUsername(); // username is the email
            String subject = "Manhattan Associates - Registration Successful";
            String body = "Dear User,\n\n" +
                    "Your registration is successful.\n\n" +
                    "Here are your login credentials:\n" +
                    "----------------------------------\n" +
                    "Username: " + user.getUsername() + "\n" +
                    "Password: " + user.getPassword() + "\n" +
                    "Role: " + user.getRole() + "\n" +
                    "----------------------------------\n\n" +
                    "You can now log in using your credentials.\n\n" +
                    "Regards,\n" +
                    "Manhattan Associates Team";

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("premsinghsengar21@gmail.com");
            message.setTo(toEmail);
            message.setSubject(subject);
            message.setText(body);

            mailSender.send(message);
            System.out.println("✅ Email sent successfully to " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error sending email: " + e.getMessage());
        }
    }

    // Authenticate user by username, password, and role
    public User authenticate(String username, String password, String role) {
        User user = userRepository.findByUsername(username);
        if (user != null && user.getPassword().equals(password)
                && user.getRole().equalsIgnoreCase(role)) {
            return user;
        }
        return null;
    }

    // Find user by username
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
