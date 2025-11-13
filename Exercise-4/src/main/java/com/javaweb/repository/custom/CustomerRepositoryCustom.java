package com.javaweb.repository.custom;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.request.CustomerSearchRequest;

import java.util.List;

public interface CustomerRepositoryCustom {
    public List<CustomerEntity> findAll(CustomerSearchRequest customerSearchRequest);
    public int countTotalItems(CustomerSearchRequest request);
}
