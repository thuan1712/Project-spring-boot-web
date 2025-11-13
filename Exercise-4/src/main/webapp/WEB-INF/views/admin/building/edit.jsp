<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/09/2025
  Time: 10:23 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingAPI" value="/api/building"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="main-content" id="main-container">


    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try {
                        ace.settings.check('breadcrumbs', 'fixed')
                    } catch (e) {
                    }
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Home</a>
                    </li>
                    <li class="active">Dashboard</li>
                </ul><!-- /.breadcrumb -->


            </div>

            <div class="page-content">

                <div class="page-header">
                    <h1>
                        Dashboard
                        <small>
                            <i class="ace-icon fa fa-angle-double-right"></i>
                            overview &amp; stats
                        </small>
                    </h1>
                </div><!-- /.page-header -->

                <form:form modelAttribute="buildingEdit" method="get" id="listForm">
                <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                    <div class="col-xs-12">
                            <%-- Đã thay form class="form-horizontal" role="form" bằng thẻ form:form --%>
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-xs-3">Tên tòa nhà</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="name" id="name"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Quận</label>
                                <div class="col-xs-2">
                                    <label class="name"></label>
                                    <form:select class="form-control" path="district" id="district">
                                        <form:option value="">---Chọn quận---</form:option>
                                        <form:options items="${districts}"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phường</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="ward" id="ward"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Đường</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="street" id="street"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Kết cấu</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="structure" id="structure"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Số tầng hầm</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="number" path="numberOfBasement"
                                                id="numberOfBasement"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Diện tích sàn</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="number" path="floorArea" id="floorArea"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Hướng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="direction" id="direction"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Hạng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="level" id="level"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Diện tích thuê</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="rentArea" id="rentArea"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Giá thuê (VNĐ/m2)</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="number" path="rentPrice" id="rentPrice"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Mô tả giá</label>
                                <div class="col-xs-9">
                                        <%-- Sử dụng textarea thay vì input cho mô tả dài (Lob) --%>
                                    <form:textarea class="form-control" path="rentPriceDescription"
                                                   id="rentPriceDescription" rows="3"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phí dịch vụ</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="serviceFee" id="serviceFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phí ô tô</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="carFee" id="carFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phí mô tô</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="motoFee" id="motorbikeFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phí ngoài giờ (Overtime)</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="overTimeFee" id="overtimeFee"/>
                                </div>
                            </div>
                                <%-- Thiếu trường waterFee trong form gốc, thêm vào nếu cần --%>
                            <div class="form-group">
                                <label class="col-xs-3">Phí nước</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="waterFee" id="waterFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Tiền điện</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="electricityFee"
                                                id="electricityFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Đặt cọc</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="deposit" id="deposit"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Thanh toán</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="payment" id="payment"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Thời hạn thuê</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="rentTime" id="rentTime"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Thời gian trang trí</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="decorationTime"
                                                id="decorationTime"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Phí môi giới</label>
                                <div class="col-xs-9">
                                        <%-- BigDecimal có thể map với type="number" với step="0.01" --%>
                                    <form:input class="form-control" type="number" step="0.01" path="brokerageFee"
                                                id="brokerageFee"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Ghi chú</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="note" id="note"/>
                                </div>
                            </div>
                                <%-- Các trường linkOfBuilding, map, image không có trong Entity, giữ nguyên là input thường nếu cần,
                                     hoặc xóa nếu không dùng. Tôi tạm thời loại bỏ. --%>
                                <%--
                                <div class="form-group">
                                    <label class="col-xs-3">Link tòa nhà</label>
                                    <div class="col-xs-9">
                                        <input class="form-control" type="text" id="linkOfBuilding" name="linkOfBuilding" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Bản đồ</label>
                                    <div class="col-xs-9">
                                        <input class="form-control" type="text" id="map" name="map" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Hình ảnh</label>
                                    <div class="col-xs-9">
                                        <input class="form-control" type="text" id="image" name="image">
                                    </div>
                                </div>
                                --%>

                                <%-- Các trường của BaseEntity được kế thừa --%>


                            <div class="form-group">
                                <label class="col-xs-3">Tên quản lý</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="managerName" id="managerName"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">SĐT quản lý</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="managerPhone"
                                                id="managerPhoneNumber"/>
                                        <%-- Đã chỉnh name của input từ managerPhoneNumber thành managerPhone để khớp với Entity --%>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Loại tòa nhà</label>
                                <div class="col-xs-9">
                                    <form:checkboxes items="${buildingTypes}" path="typeCode"></form:checkboxes>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3"></label>
                                <div class="col-xs-9">
                                    <c:if test="${not empty buildingEdit.id}">
                                        <button class="btn btn-primary" id="btnAddOrUpdateBuilding">
                                            Cập nhập tòa nhà
                                        </button>

                                        <button class="btn btn-primary" type="reset" id="btnCancel">
                                            Hủy thao tác
                                        </button>

                                    </c:if>
                                    <c:if test="${empty buildingEdit.id}">

                                        <button class="btn btn-primary" id="btnAddOrUpdateBuilding">
                                            Thêm tòa nhà
                                        </button>

                                        <button class="btn btn-primary" type="reset" id="btnCancel">
                                            Hủy thao tác
                                        </button>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                        <form:hidden path="id" id="buildingId"></form:hidden>

                    </div>
                </div>
            </div>
            </form:form> </div>
    </div>
</div>
</div></div>

<script>
    $('#btnAddOrUpdateBuilding').click(function () {
        event.preventDefault();
        var formData = $('#listForm').serializeArray();
        var typeCodes = [];
        var data = {};
        $.each(formData, function (i, v) {
            if (v.name != 'typeCode') {
                data["" + v.name + ""] = v.value;
            } else {
                typeCodes.push(v.value);
            }
        });
        data['typeCode'] = typeCodes;
        if (typeCodes.length > 0) {
            addOrUpdateBuilding(data);
        } else {
            window.location.href = "<c:url value="/admin/building-edit?typeCode=require"/>";
        }

    })

    function addOrUpdateBuilding(data) {
        $.ajax({
            type: "POST",
            url: "${buildingAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                console.log("Success");
                console.log(response);
                var actionType = response.action;
                var redirectUrl = "<c:url value='/admin/building-list?message=addorupdate_success&action='/>" + actionType;
                window.location.href = redirectUrl;
            },
            error: function (response) {
                console.log("failed");
                window.location.href="<c:url value='/admin/building-edit?message=error'/>"
                console.log(response);
            }
        });
    }

    $('#btnCancel').click(function () {
        window.location.href = "/admin/building-list";
    })
</script>

</body>
</html>

