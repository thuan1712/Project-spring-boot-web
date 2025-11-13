package com.javaweb.service.impl;

import com.javaweb.converter.CustomerSearchResponseConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import com.javaweb.repository.custom.impl.CustomerRepositoryImpl;
import com.javaweb.service.CustomerService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private CustomerRepositoryCustom customerRepositoryCustom;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    public CustomerSearchResponseConverter customerSearchResponseConverter;
    @Override
    public List<CustomerSearchResponse> findAll(CustomerSearchRequest request) {
        List<CustomerEntity> listCustomer = customerRepositoryCustom.findAll(request);
        List<CustomerSearchResponse> customerSearchResponseList = new ArrayList<>();
        for (CustomerEntity customerEntity : listCustomer) {
            CustomerSearchResponse response = new CustomerSearchResponse();
            response = customerSearchResponseConverter.toCustomerSearchResponse(customerEntity);
            customerSearchResponseList.add(response);
        }
        return customerSearchResponseList;
    }

//    @Override
//    public int countTotalItems(CustomerSearchRequest request) {
//        return customerRepositoryCustom.countTotalItems(request);
//    }

    // 2. Phương thức lấy danh sách (đã được phân trang)
//    @Override
//    public List<CustomerSearchResponse> findAll(CustomerSearchRequest request) {
//        // RepositoryImpl đã áp dụng LIMIT/OFFSET dựa trên request.getPage() và request.getMaxPageItems()
//        List<CustomerEntity> listCustomer = customerRepositoryCustom.findAll(request);
//
//        // ... logic chuyển đổi sang CustomerSearchResponse giữ nguyên ...
//        List<CustomerSearchResponse> customerSearchResponseList = new ArrayList<>();
//        for (CustomerEntity customerEntity : listCustomer) {
//            CustomerSearchResponse response = new CustomerSearchResponse();
//            // Giả định customerSearchResponseConverter đã được Autowired
//            response = customerSearchResponseConverter.toCustomerSearchResponse(customerEntity);
//            customerSearchResponseList.add(response);
//        }
//        return customerSearchResponseList;
//    }

    @Override
    public void updateOrAddCustomer(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = modelMapper.map(customerDTO, CustomerEntity.class);
        customerRepository.save(customerEntity);
    }

    @Override
    public CustomerDTO findById(Long id) {
        CustomerDTO customerDTO = modelMapper.map(customerRepository.findById(id).get(), CustomerDTO.class);
        return customerDTO;
    }

    @Override
    @Transactional
    public void deleteCustomer(List<Long> ids) {
        customerRepository.deleteByIdIn(ids);
    }

    @Override
    public ResponseDTO listStaffs(Long CustomerId) {
        CustomerEntity customerEntity = customerRepository.findById(CustomerId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1,"STAFF");
        List<UserEntity> staffAssigment = customerEntity.getStaffUsers();
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
    public void updateCustomerAssignments(AssignmentCustomerDTO assignmentCustomerDTO) {
        Long customerId = assignmentCustomerDTO.getCustomerId();
        List<Long> staffIds = assignmentCustomerDTO.getStaffs();
        if(customerId != null){
            CustomerEntity customerEntity = customerRepository.findById(customerId).get();
            List<UserEntity> staffAssignments = new ArrayList<>();
            if(staffIds != null && !staffIds.isEmpty()){
                staffAssignments = userRepository.findByIdIn(staffIds);
            }
            customerEntity.setStaffUsers(staffAssignments);
            customerRepository.save(customerEntity);
        }
    }

}
