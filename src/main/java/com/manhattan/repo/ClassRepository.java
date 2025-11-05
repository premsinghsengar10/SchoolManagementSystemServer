package com.manhattan.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import com.manhattan.bean.ClassDetails;

public interface ClassRepository extends JpaRepository<ClassDetails, Long> {
}
