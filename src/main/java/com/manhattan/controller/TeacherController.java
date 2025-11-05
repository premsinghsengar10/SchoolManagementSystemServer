package com.manhattan.controller;

import com.manhattan.bean.Student;
import com.manhattan.bean.StudentAttendance;
import com.manhattan.bean.StudentMarks;
import com.manhattan.repo.StudentRepository;
import com.manhattan.service.StudentAttendanceService;
import com.manhattan.service.StudentMarksService;
import com.manhattan.service.StudentReportService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private StudentAttendanceService attendanceService;

    @Autowired
    private StudentMarksService marksService;

    @Autowired
    private StudentReportService studentReportService;

    /* ======================================================
       🧭 DASHBOARD
       ====================================================== */
    @GetMapping("/dashboard")
    public String teacherDashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("loggedInUser");
        String role = (String) session.getAttribute("role");

        if (username == null || !"teacher".equalsIgnoreCase(role)) {
            return "redirect:/";
        }

        // ✅ Get all students for this teacher
        List<Student> students = studentRepository.findByTeacherAdminNo(username);
        model.addAttribute("students", students);
        model.addAttribute("teacherAdminNo", username);

        if (students.isEmpty()) {
            model.addAttribute("errorMessage", "No students found for this teacher.");
            return "teacher";
        }

        // ✅ Extract all admin numbers in uppercase (cleaned)
        List<String> adminNos = students.stream()
                .filter(s -> s.getAdminNo() != null)
                .map(s -> s.getAdminNo().trim().toUpperCase())
                .collect(Collectors.toList());

        // ✅ Fetch attendance and marks directly from DB using repository
        List<StudentAttendance> attendanceList = attendanceService.getAttendanceByAdminNos(adminNos);
        List<StudentMarks> marksList = marksService.getMarksByAdminNos(adminNos);

        // ✅ Debug logs (optional)
        System.out.println("🟢 Teacher: " + username);
        System.out.println("🟢 Students found: " + students.size());
        System.out.println("🟢 Attendance records: " + attendanceList.size());
        System.out.println("🟢 Marks records: " + marksList.size());

        // ✅ Add data to model
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("marksList", marksList);

        return "teacher"; // JSP: teacher.jsp
    }

    /* ======================================================
       📅 ATTENDANCE MANAGEMENT
       ====================================================== */
    @PostMapping("/attendance/add")
    public String saveAttendance(@ModelAttribute StudentAttendance attendance) {
        if (attendance.getAdminNo() != null) {
            attendance.setAdminNo(attendance.getAdminNo().trim().toUpperCase());
        }
        attendance.calculatePercentageAndStatus();
        attendanceService.saveAttendance(attendance);
        return "redirect:/teacher/dashboard";
    }

    @PostMapping("/attendance/update/{id}")
    public String updateAttendance(@PathVariable Long id, @ModelAttribute StudentAttendance attendance) {
        attendance.setId(id);
        if (attendance.getAdminNo() != null) {
            attendance.setAdminNo(attendance.getAdminNo().trim().toUpperCase());
        }
        attendance.calculatePercentageAndStatus();
        attendanceService.saveAttendance(attendance);
        return "redirect:/teacher/dashboard";
    }

    @GetMapping("/attendance/delete/{id}")
    public String deleteAttendance(@PathVariable Long id) {
        attendanceService.deleteAttendance(id);
        return "redirect:/teacher/dashboard";
    }

    /* ======================================================
       🧾 MARKS MANAGEMENT
       ====================================================== */
    @PostMapping("/marks/add")
    public String saveMarks(@ModelAttribute StudentMarks marks) {
        if (marks.getAdminNo() != null) {
            marks.setAdminNo(marks.getAdminNo().trim().toUpperCase());
        }
        marksService.saveMarks(marks);
        return "redirect:/teacher/dashboard";
    }

    @PostMapping("/marks/update/{id}")
    public String updateMarks(@PathVariable Long id, @ModelAttribute StudentMarks marks) {
        marks.setId(id);
        if (marks.getAdminNo() != null) {
            marks.setAdminNo(marks.getAdminNo().trim().toUpperCase());
        }
        marksService.saveMarks(marks);
        return "redirect:/teacher/dashboard";
    }

    @GetMapping("/marks/delete/{id}")
    public String deleteMarks(@PathVariable Long id) {
        marksService.deleteMarks(id);
        return "redirect:/teacher/dashboard";
    }

    /* ======================================================
       🔍 SEARCH STUDENT
       ====================================================== */
    @GetMapping("/search")
    public String searchStudent(@RequestParam("keyword") String keyword, HttpSession session, Model model) {
        String username = (String) session.getAttribute("loggedInUser");
        String role = (String) session.getAttribute("role");

        if (username == null || !"teacher".equalsIgnoreCase(role)) {
            return "redirect:/";
        }

        List<Student> students = studentRepository.findByTeacherAdminNo(username);
        model.addAttribute("students", students);
        model.addAttribute("teacherAdminNo", username);

        Student searchResult = students.stream()
                .filter(s -> s.getAdminNo() != null && s.getFullName() != null &&
                        (s.getAdminNo().trim().equalsIgnoreCase(keyword.trim()) ||
                         s.getFullName().trim().equalsIgnoreCase(keyword.trim())))
                .findFirst()
                .orElse(null);

        if (searchResult != null) {
            model.addAttribute("searchResult", searchResult);
        } else {
            model.addAttribute("errorMessage", "No student found with the given name or Admin No.");
        }

        // ✅ Attendance and Marks
        List<String> adminNos = students.stream()
                .filter(s -> s.getAdminNo() != null)
                .map(s -> s.getAdminNo().trim().toUpperCase())
                .collect(Collectors.toList());

        List<StudentAttendance> attendanceList = attendanceService.getAttendanceByAdminNos(adminNos);
        List<StudentMarks> marksList = marksService.getMarksByAdminNos(adminNos);

        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("marksList", marksList);

        return "teacher";
    }

    /* ======================================================
       📄 STUDENT REPORT (PDF DOWNLOAD)
       ====================================================== */
    @GetMapping("/report/{adminNo}")
    public ResponseEntity<byte[]> downloadReport(@PathVariable String adminNo) {
        ByteArrayInputStream bis = studentReportService.generateStudentReport(adminNo);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=student_report_" + adminNo + ".pdf");
        return ResponseEntity.ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(bis.readAllBytes());
    }

}
