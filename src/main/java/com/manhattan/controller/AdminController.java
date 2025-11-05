package com.manhattan.controller;

import com.manhattan.bean.Student;
import com.manhattan.bean.Teacher;
import com.manhattan.service.StudentService;
import com.manhattan.service.TeacherService;
import com.manhattan.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private ClassService classService;

    // ===== DASHBOARD PAGE =====
    @GetMapping("/dashboard")
    public String dashboard(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        // 🔍 Search students by keyword (name or admin no)
        List<Student> students = studentService.searchStudents(keyword);

        // Fetch all teachers and classes
        List<Teacher> teachers = teacherService.getAllTeachers();

        // Add all data to the model
        model.addAttribute("students", students);
        model.addAttribute("teachers", teachers);
        model.addAttribute("keyword", keyword == null ? "" : keyword);

        // Dashboard stats
        model.addAttribute("studentCount", studentService.getAllStudents().size());
        model.addAttribute("teacherCount", teacherService.getAllTeachers().size());
        model.addAttribute("attendanceAverage", 0); // replace later

        return "admin"; // JSP file name
    }

    // ===== STUDENT CRUD =====
    @GetMapping("/students/add")
    public String showAddStudentForm(Model model) {
        model.addAttribute("student", new Student());
        return "add-student";
    }

    @PostMapping("/students/save")
    public String saveStudent(@ModelAttribute("student") Student student) {
        studentService.saveStudent(student);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/students/edit/{id}")
    public String showEditStudentForm(@PathVariable Long id, Model model) {
        Student student = studentService.getStudentById(id);
        model.addAttribute("student", student);
        return "edit-student";
    }

    @PostMapping("/students/update/{id}")
    public String updateStudent(@PathVariable Long id,@ModelAttribute("student") Student student) {
        studentService.updateStudent(id,student);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return "redirect:/admin/dashboard";
    }

    // ===== TEACHER CRUD =====
    @GetMapping("/teachers/add")
    public String showAddTeacherForm(Model model) {
        model.addAttribute("teacher", new Teacher());
        return "add-teacher";
    }

    @PostMapping("/teachers/save")
    public String saveTeacher(@ModelAttribute("teacher") Teacher teacher) {
        teacherService.saveTeacher(teacher);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/teachers/edit/{id}")
    public String showEditTeacherForm(@PathVariable Long id, Model model) {
        Teacher teacher = teacherService.getTeacherById(id);
        model.addAttribute("teacher", teacher);
        return "edit-teacher";
    }

    @PostMapping("/teachers/update/{id}")
    public String updateTeacher(@PathVariable Long id,@ModelAttribute("teacher") Teacher teacher) {
        teacherService.updateTeacher(id,teacher);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/teachers/delete/{id}")
    public String deleteTeacher(@PathVariable Long id) {
        teacherService.deleteTeacher(id);
        return "redirect:/admin/dashboard";
    }

    // ===== CLASS CRUD =====
//    @GetMapping("/classes/add")
//    public String showAddClassForm(Model model) {
//        model.addAttribute("schoolClass", new SchoolClass());
//        model.addAttribute("teachers", teacherService.getAllTeachers()); // assign teacher dropdown
//        return "addClass";
//    }
//
//    @PostMapping("/classes/save")
//    public String saveClass(@ModelAttribute("schoolClass") SchoolClass schoolClass) {
//        classService.saveClass(schoolClass);
//        return "redirect:/admin/dashboard";
//    }
//
//    @GetMapping("/classes/edit/{id}")
//    public String showEditClassForm(@PathVariable Long id, Model model) {
//        SchoolClass schoolClass = classService.getClassById(id);
//        model.addAttribute("schoolClass", schoolClass);
//        model.addAttribute("teachers", teacherService.getAllTeachers());
//        return "editClass";
//    }
//
//    @PostMapping("/classes/update")
//    public String updateClass(@ModelAttribute("schoolClass") SchoolClass schoolClass) {
//        classService.saveClass(schoolClass);
//        return "redirect:/admin/dashboard";
//    }
//
//    @GetMapping("/classes/delete/{id}")
//    public String deleteClass(@PathVariable Long id) {
//        classService.deleteClass(id);
//        return "redirect:/admin/dashboard";
//    }
}
