package com.javaweb.service;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;

import java.util.List;

public interface BuildingService {
    ResponseDTO listStaffs(Long BuildingId);
    void addOrUpdateBuilding(BuildingDTO buildingDTO);
    BuildingDTO getBuildingDTOById(Long BuildingId);
    void deleteBuildingById(List<Long> BuildingIds);
    void updateBuildingAssignments(AssignmentBuildingDTO assignmentBuildingDTO);
    List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequests);
}
