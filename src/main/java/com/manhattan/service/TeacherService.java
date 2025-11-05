package com.manhattan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.manhattan.bean.Teacher;
import com.manhattan.repo.TeacherRepository;

import java.util.List;

@Service
public class TeacherService {

    @Autowired
    private TeacherRepository teacherRepository;

    public List<Teacher> getAllTeachers() {
        return teacherRepository.findAll();
    }

    public Teacher getTeacherById(Long id) {
        return teacherRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid teacher Id: " + id));
    }

    public void saveTeacher(Teacher teacher) {
        teacherRepository.save(teacher);
    }
    
    public void updateTeacher(Long id, Teacher updatedTeacher) {
        Teacher existingTeacher = teacherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Teacher not found with id: " + id));

        // Update fields
        existingTeacher.setFullName(updatedTeacher.getFullName());
        existingTeacher.setDob(updatedTeacher.getDob());
        existingTeacher.setPhoneNo(updatedTeacher.getPhoneNo());
        existingTeacher.setTeacherAdminNo(updatedTeacher.getTeacherAdminNo());

        teacherRepository.save(existingTeacher);
    }


    public void deleteTeacher(Long id) {
        teacherRepository.deleteById(id);
    }
}
