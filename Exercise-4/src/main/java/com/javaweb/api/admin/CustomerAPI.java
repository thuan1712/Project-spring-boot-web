package com.javaweb.api.admin;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.CustomerService;
import com.javaweb.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api/customer")
public class CustomerAPI {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private TransactionRepository transactionRepository;
    @PostMapping
    public CustomerDTO addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO) {
        customerService.updateOrAddCustomer(customerDTO);
        if(customerDTO.getId()!=null){
            customerDTO.setAction("UPDATED");
        }else{
            customerDTO.setAction("CREATED");
        }
        return customerDTO;
    }




    @DeleteMapping("/Ids")
    public void deleteCustomer(@PathVariable List<Long> Ids) {
        customerService.deleteCustomer(Ids);
    }

    @PostMapping("/transaction")
    public TransactionDTO addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        Long staffId = SecurityUtils.getPrincipal().getId();
        transactionDTO.setStaffId(staffId);
        transactionService.updateOrAddTransaction(transactionDTO);
        if(transactionDTO.getId() != null){
            transactionDTO.setAction("UPDATED");
        }else{
            transactionDTO.setAction("CREATED");
        }
        return transactionDTO;
    }
    @DeleteMapping("/transaction/{id}")
    public TransactionDTO deleteTransaction(@PathVariable long id) {
        return transactionService.deleteTransaction(id);
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){
        ResponseDTO result = customerService.listStaffs(id);
        return result;
    }

    @PutMapping("/assignments")
    public void updateCustomerAssignments(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO) {
        customerService.updateCustomerAssignments(assignmentCustomerDTO);

    }

}
