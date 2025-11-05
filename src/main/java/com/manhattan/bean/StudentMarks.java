package com.manhattan.bean;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "student_marks")
public class StudentMarks {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String adminNo;
    private String standard;
    private int year;
    private String pfSelect; // exam type (e.g., "Midterm", "Final")
    private int english;
    private int maths;
    private int science;
}
