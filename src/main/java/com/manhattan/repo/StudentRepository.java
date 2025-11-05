package com.manhattan.repo;

import com.manhattan.bean.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentRepository extends JpaRepository<Student, Long> {

    List<Student> findByTeacherAdminNo(String teacherAdminNo);

    Student findByAdminNo(String adminNo);  // For parent login

    // 🔍 New Search Methods
    Student findByAdminNoIgnoreCase(String adminNo);
    List<Student> findByFullNameContainingIgnoreCase(String fullName);
    List<Student> findByAdminNoContainingIgnoreCase(String adminNo);
}
