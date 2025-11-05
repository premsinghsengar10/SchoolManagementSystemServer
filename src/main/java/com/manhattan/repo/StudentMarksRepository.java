package com.manhattan.repo;

import com.manhattan.bean.StudentMarks;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface StudentMarksRepository extends JpaRepository<StudentMarks, Long> {
    List<StudentMarks> findByAdminNoIgnoreCase(String adminNo);
    List<StudentMarks> findByAdminNoInIgnoreCase(List<String> adminNos);
}