package com.javaweb.service;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;

public interface TransactionService {
    public void updateOrAddTransaction(TransactionDTO transactionDTO);
    public TransactionDTO deleteTransaction(Long id);
}
