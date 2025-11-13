package com.javaweb.service.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private UserRepository userRepository ;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private TransactionRepository transactionRepository;
    @Override
    public void updateOrAddTransaction(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity;

        if (transactionDTO.getId() != null) {
            Optional<TransactionEntity> existingEntity = transactionRepository.findById(transactionDTO.getId());
            if (existingEntity.isPresent()) {
                transactionEntity = existingEntity.get();
            } else {
                transactionEntity = new TransactionEntity();
            }
        } else {
            transactionEntity = new TransactionEntity();
            UserEntity userEntity = userRepository.findById(transactionDTO.getStaffId()).orElse(null);
            if (userEntity != null) {
                transactionEntity.setStaff(userEntity);
            }
        }
        transactionEntity.setCode(transactionDTO.getCode());
        transactionEntity.setNote(transactionDTO.getTransactionDetail());
        CustomerEntity customerEntity = customerRepository.findById(transactionDTO.getCustomerId()).orElse(null);
        if (customerEntity != null) {
            transactionEntity.setCustomer(customerEntity);
        }
        transactionRepository.save(transactionEntity);
    }

    @Override
    public TransactionDTO deleteTransaction(Long id) {
        TransactionDTO transactionDTO = new TransactionDTO();
        transactionDTO.setId(id);
        transactionDTO.setCustomerId(transactionRepository.getOne(id).getCustomer().getId());
        if(transactionRepository.existsById(id)) {
            transactionRepository.deleteById(id);
        }
        return transactionDTO;
    }
}
