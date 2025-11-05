 package com.manhattan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.manhattan.bean.User;
import com.manhattan.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // Default login page
    @GetMapping("/")
    public String index() {
        return "login";
    }

    // Registration page
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    // Handle registration
    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, Model model) {
        String result = userService.registerUser(user);
        if ("exists".equals(result)) {
            model.addAttribute("error", "Username already exists!");
            return "register";
        }
        model.addAttribute("message", "Registration successful! Please login.");
        return "login";
    }

    // Handle login
    @PostMapping("/login")
    public String loginUser(@RequestParam String username,
                            @RequestParam String password,
                            @RequestParam String role,
                            Model model,
                            HttpSession session) {
        User user = userService.authenticate(username, password, role);

        if (user != null) {
            // ✅ Store session info
            session.setAttribute("loggedInUser", username);
            session.setAttribute("role", role);

            switch (role.toLowerCase()) {
            case "admin":
                return "redirect:/admin/dashboard";
            case "teacher":
                return "redirect:/teacher/dashboard";
            case "parent":
                return "redirect:/parent/dashboard";
            default:
                model.addAttribute("error", "Invalid role selected!");
                return "login";
        }

        }

        model.addAttribute("error", "Invalid username, password, or role!");
        return "login";
    }

    // Optional: Parent dashboard placeholder
//    @GetMapping("/parent/dashboard")
//    public String parentDashboard(HttpSession session, Model model) {
//        String username = (String) session.getAttribute("loggedInUser");
//        if (username == null) {
//            return "redirect:/";
//        }
//        model.addAttribute("username", username);
//        return "parent-dashboard";
//    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
