package com.manhattan.controller;

import com.manhattan.bean.Student;
import com.manhattan.repo.StudentRepository;
import com.manhattan.repo.StudentAttendanceRepository;
import com.manhattan.repo.StudentMarksRepository;
import jakarta.servlet.http.HttpSession;
import com.manhattan.service.StudentReportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;

import java.io.ByteArrayInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/parent")
public class ParentController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private StudentAttendanceRepository attendanceRepository;

    @Autowired
    private StudentMarksRepository marksRepository;
    
    @Autowired
    private StudentReportService reportService;

    @GetMapping("/dashboard")
    public String parentDashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("loggedInUser");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Parent".equalsIgnoreCase(role)) {
            return "redirect:/";
        }

        Student student = studentRepository.findByAdminNo(username);
        if (student == null) {
            model.addAttribute("error", "No student found for this parent account!");
            return "parent";
        }

        model.addAttribute("student", student);
        model.addAttribute("attendanceList", attendanceRepository.findByAdminNoIgnoreCase(username));
        model.addAttribute("marksList", marksRepository.findByAdminNoIgnoreCase(username));

        return "parent";
    }
    
    @GetMapping("/report/{adminNo}")
    public ResponseEntity<InputStreamResource> downloadStudentReport(
            @PathVariable String adminNo, HttpSession session) {

        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("loggedInUser");

        if (username == null || !"Parent".equalsIgnoreCase(role)) {
            return ResponseEntity.status(403).build();
        }

        try {
            ByteArrayInputStream reportStream = reportService.generateStudentReport(adminNo);

            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Disposition", "inline; filename=Student_Report_" + adminNo + ".pdf");

            return ResponseEntity.ok()
                    .headers(headers)
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(new InputStreamResource(reportStream));

        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

}
