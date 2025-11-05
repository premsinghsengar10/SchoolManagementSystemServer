package com.manhattan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.manhattan.bean.ClassDetails;
import com.manhattan.repo.ClassRepository;

import java.util.List;

@Service
public class ClassService {

    @Autowired
    private ClassRepository classRepository;

    public List<ClassDetails> getAllClasses() {
        return classRepository.findAll();
    }

    public ClassDetails getClassById(Long id) {
        return classRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid class Id: " + id));
    }

    public void saveClass(ClassDetails classDetails) {
        classRepository.save(classDetails);
    }

    public void deleteClass(Long id) {
        classRepository.deleteById(id);
    }
}
