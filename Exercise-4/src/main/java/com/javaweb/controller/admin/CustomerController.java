package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.enums.TransactionType;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.CustomerService;
import com.javaweb.service.impl.UserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller(value="customerControllerOfAdmin")
public class CustomerController {
    @Autowired
    public UserService userService;
    @Autowired
    public CustomerService customerService;
    @Autowired
    private CustomerRepository customerRepository;

    @GetMapping(value = "/admin/customer-list")
    public ModelAndView customerList(@ModelAttribute CustomerSearchRequest customerSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        mav.addObject("modelSearch", customerSearchRequest);
        mav.addObject("staffsList", userService.getStaffs());
        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            customerSearchRequest.setStaffId(staffId);
            mav.addObject("customersList", customerService.findAll(customerSearchRequest));
        }else{
            mav.addObject("customersList", customerService.findAll(customerSearchRequest));
        }
        CustomerSearchResponse model = new CustomerSearchResponse();
        DisplayTagUtils.of(request,model);
        model.setTotalItems(customerService.findAll(customerSearchRequest).size());
        mav.addObject(SystemConstant.MODEL, model);

        return mav;
    }

    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView customerEdit(@ModelAttribute("customerEdit") CustomerDTO customerDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView customerEdit(@PathVariable("id") Long id,@ModelAttribute("customerEdit") CustomerDTO customerDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("transactionType", TransactionType.transactionType());
        mav.addObject("customerEdit", customerService.findById(id));
        CustomerEntity customerEntity = customerRepository.findById(id).get();
        List<TransactionEntity> transactions = customerEntity.getTransactions();
        List<TransactionEntity> transactionOfStaff = new ArrayList<>();
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            if(transactions!=null && !transactions.isEmpty()){

                for(TransactionEntity transaction : transactions){
                    if(transaction.getStaff() != null && transaction.getStaff().getId().equals(staffId)){
                        transactionOfStaff.add(transaction);
                    };
                }
            }
            mav.addObject("cskhTransactions", transactionOfStaff); // WHERE userId =
        } else { // Manager
            mav.addObject("cskhTransactions", transactions); // Find All
        }

        return mav;
    }


}
