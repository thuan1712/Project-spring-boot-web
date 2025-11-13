package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.ResponseDTO;

import java.util.List;

public interface CustomerService {
    public List<CustomerSearchResponse> findAll(CustomerSearchRequest request);
    public void updateOrAddCustomer(CustomerDTO customerDTO);
    public CustomerDTO findById(Long id);
    public void deleteCustomer(List<Long> ids);
    public ResponseDTO listStaffs(Long CustomerId);
    public void updateCustomerAssignments(AssignmentCustomerDTO customerDTO);
//    public int countTotalItems(CustomerSearchRequest request);
}
