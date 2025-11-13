package com.javaweb.service.impl;

import com.javaweb.converter.BuildingDTOConverter;
import com.javaweb.converter.BuildingEntityConverter;
import com.javaweb.converter.BuildingSearchResponseConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.AssignmentBuildingRepository;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.service.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class BuildingServiceImpl implements BuildingService {
    @Autowired
    private AssignmentBuildingRepository assignmentBuildingRepository;
    @Autowired
    private BuildingRepositoryCustom buildingRepositoryCustom;
    @Autowired
    private BuildingRepository buildingRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BuildingEntityConverter buildingEntityConverter;
    @Autowired
    private BuildingDTOConverter buildingDTOConverter;
    @Autowired
    private BuildingSearchResponseConverter buildingSearchResponseConverter;
    @Override
    public ResponseDTO listStaffs(Long BuildingId) {
        BuildingEntity buildingEntity = buildingRepository.findById(BuildingId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1,"STAFF");
        List<UserEntity> staffAssigment = buildingEntity.getUserEntities();
        List<StaffResponseDTO> staffResponseDTOs = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();
        for (UserEntity staff : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            if (staffAssigment.contains(staff)) {
                staffResponseDTO.setChecked("checked");
            }else{
                staffResponseDTO.setChecked("");
            }
            staffResponseDTO.setStaffId(staff.getId());
            staffResponseDTO.setFullName(staff.getFullName());
            staffResponseDTOs.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOs);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public void addOrUpdateBuilding(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = buildingEntityConverter.toBuildingEntity(buildingDTO);
        buildingRepository.save(buildingEntity);
    }

    @Override
    public BuildingDTO getBuildingDTOById(Long BuildingId) {
        BuildingEntity buildingEntity = buildingRepository.findById(BuildingId).get();
        BuildingDTO buildingDTO = buildingDTOConverter.toBuildingDTO(buildingEntity);
        return buildingDTO;
    }

    @Override
    @Transactional
    public void deleteBuildingById(List<Long> BuildingIds) {
        buildingRepository.deleteByIdIn(BuildingIds);
    }

    @Override
    public void updateBuildingAssignments(AssignmentBuildingDTO assignmentBuildingDTO) {
        BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuildingDTO.getBuildingId()).get();
        if(!assignmentBuildingDTO.getStaffs().isEmpty()){

//            buildingEntity.getUserEntities().clear();
//            buildingEntity.getUserEntities().addAll(userRepository.findByIdIn(assignmentBuildingDTO.getStaffs()));
            buildingEntity.setUserEntities(userRepository.findByIdIn(assignmentBuildingDTO.getStaffs()));
        }else{
            buildingEntity.getUserEntities().clear();
        }

        buildingRepository.save(buildingEntity);
    }

    @Override
    public List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequests) {
        List<BuildingEntity> buildingEntities = buildingRepositoryCustom.findAll(buildingSearchRequests);
        List<BuildingSearchResponse> buildingSearchResponses = new ArrayList<>();
        for (BuildingEntity buildingEntity : buildingEntities) {
            BuildingSearchResponse responseDTO = buildingSearchResponseConverter.toBuildingSearchResponse(buildingEntity);
            buildingSearchResponses.add(responseDTO);
        }
        return buildingSearchResponses;
    }
}
