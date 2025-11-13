package com.javaweb.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "transaction")
public class TransactionEntity extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "code")
    private String code;

    @Column(name = "note")
    private String note;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "staffid")
    private UserEntity staff;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customerid", nullable = false)
    private CustomerEntity customer;



    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public CustomerEntity getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }

    public UserEntity getStaff() {
        return staff;
    }

    public void setStaff(UserEntity staff) {
        this.staff = staff;
    }
}