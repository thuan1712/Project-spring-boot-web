package com.javaweb.repository.custom.impl;


import com.javaweb.entity.CustomerEntity;

import com.javaweb.model.request.CustomerSearchRequest;

import com.javaweb.repository.custom.CustomerRepositoryCustom;

import com.javaweb.utils.NumberUtils;

import com.javaweb.utils.StringUtils;

import org.springframework.stereotype.Repository;


import javax.persistence.EntityManager;

import javax.persistence.PersistenceContext;

import javax.persistence.Query;

import java.lang.reflect.Field;

import java.util.Collections;

import java.util.List;


@Repository

public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext

    private EntityManager entityManager;


    public static void joinTable(CustomerSearchRequest request, StringBuilder sql) {

        Long staffId = request.getStaffId();

        if (staffId != null) {

            sql.append(" JOIN assignmentcustomer a ON a.customerid = b.id ");

// sql.append(" JOIN user u ON a.staffid = u.id ");

        }


    }


    public static void queryNomal(CustomerSearchRequest request, StringBuilder where) {

        try {

            Field[] fields = CustomerSearchRequest.class.getDeclaredFields();

            for (Field item : fields) {

                item.setAccessible(true);

                String fieldName = item.getName();

                if (!fieldName.equals("staffId")) {

                    Object value = item.get(request);

                    if (value != null && StringUtils.check(value.toString())) {

                        if (NumberUtils.isLong(value.toString()) && !fieldName.equals("phone")) {

                            where.append(" AND b." + fieldName + " = " + value);

                        } else {

                            where.append(" AND b." + fieldName + " LIKE '%" + value + "%' ");

                        }

                    }

                }

            }

        } catch (Exception ex) {

            ex.printStackTrace();

        }

    }


    public static void querySpecial(CustomerSearchRequest request, StringBuilder where) {

        Long staffId = request.getStaffId();

        if (staffId != null) {

            where.append(" AND a.staffid = " + staffId);

        }

    }


    @Override

    public List<CustomerEntity> findAll(CustomerSearchRequest request) {

        StringBuilder sql = new StringBuilder("SELECT b.* FROM customer b");

        joinTable(request, sql);

        StringBuilder where = new StringBuilder(" where 1=1 ");

        queryNomal(request, where);

        querySpecial(request, where);

        sql.append(where);

        sql.append(" GROUP BY b.id;");

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);

        return query.getResultList();


    }

    @Override
    public int countTotalItems(CustomerSearchRequest request) {
        return 0;
    }

}