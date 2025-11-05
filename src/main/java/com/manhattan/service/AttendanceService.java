package com.manhattan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.manhattan.bean.TeacherAttendence;
import com.manhattan.repo.TeacherAttendanceRepository;

import java.util.List;

@Service
public class AttendanceService {

    @Autowired
    private TeacherAttendanceRepository teacherAttendanceRepository;

    public List<TeacherAttendence> getAllAttendance() {
        return teacherAttendanceRepository.findAll();
    }

    public TeacherAttendence getAttendanceById(Long id) {
        return teacherAttendanceRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid attendance Id: " + id));
    }

    public void saveAttendance(TeacherAttendence attendance) {
        attendance.calculateAttendance(); // calculate before saving
        teacherAttendanceRepository.save(attendance);
    }

    public void deleteAttendance(Long id) {
        teacherAttendanceRepository.deleteById(id);
    }
}
