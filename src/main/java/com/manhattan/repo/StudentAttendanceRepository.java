package com.manhattan.repo;

import com.manhattan.bean.StudentAttendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface StudentAttendanceRepository extends JpaRepository<StudentAttendance, Long> {
    List<StudentAttendance> findByAdminNoIgnoreCase(String adminNo);
    List<StudentAttendance> findByAdminNoInIgnoreCase(List<String> adminNos);
}
