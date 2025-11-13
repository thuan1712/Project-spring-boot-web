package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;

import java.util.Date;

public class CustomerSearchResponse extends AbstractDTO {

    // Kế thừa id, createdDate, modifiedDate, createdBy, modifiedBy từ AbstractDTO

    private String fullName;      // Tên khách hàng
    private String phone;         // Di động
    private String email;         // Email
    private String demand;        // Nhu cầu
    private String assigneeName;  // Người thêm (hoặc Người giao, tùy ngữ cảnh. Ở đây dùng Người thêm/Người quản lý)
    private String status;    // Tình trạng (Mô tả trạng thái của khách hàng)

    // Lưu ý: Ngày thêm (Ngày tạo) đã được kế thừa là 'createdDate' (kiểu Date)

    // --- Getters and Setters ---

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDemand() {
        return demand;
    }

    public void setDemand(String demand) {
        this.demand = demand;
    }

    public String getAssigneeName() {
        // Tên của nhân viên/người tạo/người quản lý
        return assigneeName;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}