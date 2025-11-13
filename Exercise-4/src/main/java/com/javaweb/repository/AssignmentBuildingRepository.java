package com.javaweb.repository;

import com.javaweb.entity.AssignBuildingEntity;
import org.springframework.data.jpa.repository.JpaRepository;


import javax.transaction.Transactional;
import java.util.List;


public interface AssignmentBuildingRepository extends JpaRepository<AssignBuildingEntity,Long> {
    void deleteByBuildingEntityId(Long buildingEntityId);
    @Transactional
    void deleteByBuildingEntityIdIn(List<Long> ids);
}
