package com.javaweb.repository.custom.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.utils.NumberUtils;
import com.javaweb.utils.StringUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(BuildingSearchRequest request, StringBuilder sql) {
        Long staffId = request.getStaffId();
        if (staffId != null) {
            sql.append(" JOIN assignmentbuilding a ON a.buildingid = b.id ");
        }

        Long rentAreaTo = request.getAreaTo();
        Long rentAreaFrom = request.getAreaFrom();
        if (rentAreaFrom != null || rentAreaTo != null) {
            sql.append(" JOIN rentarea r ON r.buildingid = b.id ");
        }


    }

    public static void queryNomal(BuildingSearchRequest request, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchRequest.class.getDeclaredFields();
            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode") && !fieldName.startsWith("area")
                        && !fieldName.startsWith("rentPrice")) {
                    Object value = item.get(request);
                    if (value != null && StringUtils.check(value.toString())) {
                        if (NumberUtils.isLong(value.toString())) {
                            where.append(" AND b." + fieldName + " = " + value);
                        } else {
                            where.append(" AND b." + fieldName + " LIKE '%" + value + "%' ");
                        }
                    }
                }else if(fieldName.equals("typeCode")){
                    List<String> typeCodeList = request.getTypeCode();
                    for(String typeCode : typeCodeList){
                        where.append(" AND b.type" + " LIKE '%" + typeCode + "%' ");
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void querySpecial(BuildingSearchRequest request, StringBuilder where) {
        Long staffId = request.getStaffId();
        if (staffId != null) {
            where.append(" AND a.staffid = " + staffId);
        }

        Long rentAreaTo = request.getAreaTo();
        Long rentAreaFrom = request.getAreaFrom();
        if (rentAreaFrom != null || rentAreaTo != null) {
            where.append(" AND EXISTS (SELECT * FROM rentarea r WHERE b.id = r.buildingid ");
            if (rentAreaFrom != null) {
                where.append(" AND r.value >= " + rentAreaFrom);
            }
            if (rentAreaTo != null) {
                where.append(" AND r.value <= " + rentAreaTo);
            }
            where.append(")");
        }

        Long rentPriceTo = request.getRentPriceTo();
        Long rentPriceFrom = request.getRentPriceFrom();
        if (rentPriceTo != null || rentPriceFrom != null) {
            if (rentPriceFrom != null) {
                where.append(" AND b.rentprice >= " + rentPriceFrom);
            }
            if (rentPriceTo != null) {
                where.append(" AND b.rentprice <= " + rentPriceTo);
            }
        }

    }
    @Override
    public List<BuildingEntity> findAll(BuildingSearchRequest request) {
        StringBuilder sql = new StringBuilder("SELECT b.* FROM building b");
        joinTable(request, sql);
        StringBuilder where = new StringBuilder(" where 1=1 ");
        queryNomal(request, where);
        querySpecial(request, where);
        sql.append(where);
        sql.append(" GROUP BY b.id;");
        Query query = entityManager.createNativeQuery(sql.toString(),BuildingEntity.class);
        return query.getResultList();
    }
}
