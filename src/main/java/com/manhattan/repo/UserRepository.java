package com.manhattan.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import com.manhattan.bean.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
