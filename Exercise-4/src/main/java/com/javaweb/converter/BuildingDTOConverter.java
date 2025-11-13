package com.javaweb.converter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentareaEntity;
import com.javaweb.model.dto.BuildingDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingDTOConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingDTO toBuildingDTO(BuildingEntity buildingEntity) {
        BuildingDTO buildingDTO = modelMapper.map(buildingEntity, BuildingDTO.class);
        String typeString = buildingEntity.getType();

        if (typeString != null && !typeString.trim().isEmpty()) {

            String[] arrayOfString = typeString.split(",");

            List<String> resultList = Arrays.stream(arrayOfString)
                    .filter(s -> !s.trim().isEmpty())
                    .collect(Collectors.toList());

            buildingDTO.setTypeCode(resultList);
        } else {
            // Thiết lập là một danh sách rỗng nếu dữ liệu là null hoặc rỗng
            buildingDTO.setTypeCode(Collections.emptyList());
        }
        String rentAreaValuesString = new String();

        if(buildingEntity.getRentAreas() != null && !buildingEntity.getRentAreas().isEmpty()) {
             rentAreaValuesString = buildingEntity.getRentAreas().stream()
                    .map(rentareaEntity -> String.valueOf(rentareaEntity.getValue())) // Chuyển Integer thành String
                    .collect(Collectors.joining(","));
        }
        buildingDTO.setRentArea(rentAreaValuesString);
        return buildingDTO;
    }
}
