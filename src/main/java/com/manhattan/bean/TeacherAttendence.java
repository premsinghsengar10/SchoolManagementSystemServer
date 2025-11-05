package com.manhattan.bean;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "teacher_attendance")
public class TeacherAttendence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String teacherAdminNo;
    private int daysPresent;
    private int totalWorkingDays;
    private double percentage;
    private String month;
    private String status;

    public void calculateAttendance() {
        if (totalWorkingDays > 0) {
            this.percentage = ((double) daysPresent / totalWorkingDays) * 100;
        } else {
            this.percentage = 0.0;
        }

        this.status = (percentage < 75) ? "Fail" : "Pass";
    }
}
