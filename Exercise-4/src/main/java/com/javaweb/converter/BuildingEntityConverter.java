package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentareaEntity;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.utils.NumberUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class BuildingEntityConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private BuildingRepository buildingRepository;

    public BuildingEntity toBuildingEntity(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);
        String buildType = String.join(",", buildingDTO.getTypeCode());
        buildingEntity.setType(buildType);
        String inputString = new String();
        inputString = buildingDTO.getRentArea();
        String[] numberStrings = inputString.split(",");
        List<Integer> numberValues = new ArrayList<>();
        for (String numberString : numberStrings) {
            String trimmedNumberString = numberString.trim();
            if(NumberUtils.isLong(trimmedNumberString)){
                numberValues.add(Integer.parseInt(trimmedNumberString));
            }else{
                numberValues = null;
                break;
            }
        }
        List<RentareaEntity> rentareaEntityList = new ArrayList<>();

        if (numberValues != null) {
            for(Integer numberValue : numberValues){
                RentareaEntity rentareaEntity = new RentareaEntity();
                rentareaEntity.setValue(numberValue);
                rentareaEntity.setBuilding(buildingEntity);
                rentareaEntityList.add(rentareaEntity);
            }
        }
        buildingEntity.setRentAreas(rentareaEntityList);
        if(buildingDTO.getId() != null && buildingDTO.getId() > 0){
            BuildingEntity buildingEntity1 = buildingRepository.findById(buildingDTO.getId()).get();
            buildingEntity.setUserEntities(buildingEntity1.getUserEntities());
        }

        return buildingEntity;
    }
}
