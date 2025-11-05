package com.manhattan.bean;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "students")
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String adminNo;         
    private String fullName;
    private String dob;
    private String standard;
    private String phoneNo;
    private String fatherName;
    private String motherName;
    private String address;
    private String teacherAdminNo;  
}
