package com.javaweb.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "assignmentcustomer")
public class AssignmentCustomerEntity extends BaseEntity {

    private static final long serialVersionUID = 1L;

    // LƯU Ý: id, createddate, modifieddate, createdby, modifiedby được kế thừa từ BaseEntity

    // Mối quan hệ Many-to-One với UserEntity (Staff)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "staffid", nullable = false)
    private UserEntity staff;

    // Mối quan hệ Many-to-One với CustomerEntity
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customerid", nullable = false)
    private CustomerEntity customer;


    // --- Getters and Setters ---

    public UserEntity getStaff() {
        return staff;
    }

    public void setStaff(UserEntity staff) {
        this.staff = staff;
    }

    public CustomerEntity getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }
}