package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentareaEntity;
import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
public class BuildingSearchResponseConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity buildingEntity) {
        BuildingSearchResponse buildingSearchResponse = modelMapper.map(buildingEntity, BuildingSearchResponse.class);
        String rentAreaValuesString = buildingEntity.getRentAreas().stream()
                .map(rentareaEntity -> String.valueOf(rentareaEntity.getValue())) // Chuyển Integer thành String
                .collect(Collectors.joining(","));
        buildingSearchResponse.setRentArea(rentAreaValuesString);
        Map<String,String> districts = districtCode.type();
        String districtValue = new String();
        if(buildingEntity.getDistrict() != null && buildingEntity.getDistrict() != ""){
             districtValue = districts.get(buildingEntity.getDistrict());
        }
        String address = Stream.of(
                        buildingEntity.getStreet(),
                        buildingEntity.getWard(),
                        districtValue
                )
                .filter(s -> s != null && !s.trim().isEmpty()) // Bước lọc
                .collect(Collectors.joining(", ")); // Bước nối
        buildingSearchResponse.setAddress(address);
        return buildingSearchResponse;
    }
}
