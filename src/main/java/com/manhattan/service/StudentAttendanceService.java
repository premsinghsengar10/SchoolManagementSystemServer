package com.manhattan.service;

import com.manhattan.bean.StudentAttendance;
import com.manhattan.repo.StudentAttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentAttendanceService {

    @Autowired
    private StudentAttendanceRepository attendanceRepository;

    public List<StudentAttendance> getAllAttendance() {
        return attendanceRepository.findAll();
    }

    public List<StudentAttendance> getAttendanceByAdminNos(List<String> adminNos) {
        return attendanceRepository.findByAdminNoInIgnoreCase(adminNos);
    }

    public List<StudentAttendance> getAttendanceByAdminNo(String adminNo) {
        return attendanceRepository.findByAdminNoIgnoreCase(adminNo);
    }

    public StudentAttendance getAttendanceById(Long id) {
        return attendanceRepository.findById(id).orElse(null);
    }

    public void saveAttendance(StudentAttendance attendance) {
        attendance.calculatePercentageAndStatus();
        if (attendance.getAdminNo() != null) {
            attendance.setAdminNo(attendance.getAdminNo().trim().toUpperCase());
        }
        attendanceRepository.save(attendance);
    }

    public void deleteAttendance(Long id) {
        attendanceRepository.deleteById(id);
    }
}
