package com.manhattan.bean;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "student_attendance")
public class StudentAttendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String adminNo;
    private int noOfDaysAttended;
    private int totalNoOfWorkingDays;
    private double percentage;
    private String month;
    private String status;

    public void calculatePercentageAndStatus() {
        if (totalNoOfWorkingDays > 0) {
            this.percentage = ((double) noOfDaysAttended / totalNoOfWorkingDays) * 100;
        } else {
            this.percentage = 0.0;
        }

        this.status = (percentage < 75) ? "Low Attendance" : "Good Attendance";
    }
}
