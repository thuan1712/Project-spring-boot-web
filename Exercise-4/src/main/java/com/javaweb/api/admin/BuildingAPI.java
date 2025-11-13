package com.javaweb.api.admin;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "buildingAPIOfAdmin")
@RequestMapping("/api/building")
public class BuildingAPI {
    @Autowired
    private BuildingService buildingService;
    @PostMapping
    public BuildingDTO addOrUpdateBuilding(@RequestBody BuildingDTO buildingDTO) {
        buildingService.addOrUpdateBuilding(buildingDTO);
        if(buildingDTO.getId()!=null){
            buildingDTO.setAction("UPDATED");
        }else{
            buildingDTO.setAction("CREATED");
        }
        return buildingDTO;
    }

    @DeleteMapping("/{Ids}")
    public void deleteBuilding(@PathVariable List<Long> Ids){
        buildingService.deleteBuildingById(Ids);
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){
        ResponseDTO result = buildingService.listStaffs(id);
        return result;
    }

    @PutMapping("/assignments")
    public void updateBuildingAssignments(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO) {
        buildingService.updateBuildingAssignments(assignmentBuildingDTO);
    }
}
