package com.manhattan.service;

import com.manhattan.bean.StudentMarks;
import com.manhattan.repo.StudentMarksRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentMarksService {

    @Autowired
    private StudentMarksRepository marksRepository;

    public List<StudentMarks> getAllMarks() {
        return marksRepository.findAll();
    }

    public List<StudentMarks> getMarksByAdminNos(List<String> adminNos) {
        return marksRepository.findByAdminNoInIgnoreCase(adminNos);
    }

    public List<StudentMarks> getMarksByAdminNo(String adminNo) {
        return marksRepository.findByAdminNoIgnoreCase(adminNo);
    }

    public StudentMarks getMarksById(Long id) {
        return marksRepository.findById(id).orElse(null);
    }

    public void saveMarks(StudentMarks marks) {
        if (marks.getAdminNo() != null) {
            marks.setAdminNo(marks.getAdminNo().trim().toUpperCase());
        }
        marksRepository.save(marks);
    }

    public void deleteMarks(Long id) {
        marksRepository.deleteById(id);
    }
}
