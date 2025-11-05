package com.manhattan.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manhattan.bean.TeacherAttendence;


public interface TeacherAttendanceRepository extends JpaRepository<TeacherAttendence, Long> { }
