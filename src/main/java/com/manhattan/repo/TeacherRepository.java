package com.manhattan.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import com.manhattan.bean.Teacher;

public interface TeacherRepository extends JpaRepository<Teacher, Long> {
}
