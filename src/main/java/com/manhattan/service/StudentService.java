package com.manhattan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.manhattan.bean.Student;
import com.manhattan.repo.StudentRepository;

import java.util.ArrayList;
import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid student Id: " + id));
    }

    public void saveStudent(Student student) {
        studentRepository.save(student);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    // ✅ Search Logic
    public List<Student> searchStudents(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return studentRepository.findAll();
        }

        List<Student> byName = studentRepository.findByFullNameContainingIgnoreCase(keyword);
        List<Student> byAdmin = studentRepository.findByAdminNoContainingIgnoreCase(keyword);

        // Merge lists manually (avoid duplicates)
        List<Student> result = new ArrayList<>(byName);
        for (Student s : byAdmin) {
            if (!result.contains(s)) {
                result.add(s);
            }
        }

        return result;
    }
}
