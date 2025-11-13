<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/09/2025
  Time: 10:23 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerListURL" value="/admin/customer-list"/>
<c:url var="customerAPI" value="/api/customer"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
</head>
<body>


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
                    <a href="#">Trang chủ</a>
                </li>
                <li class="active">Quản lý Khách Hàng</li>
            </ul><!-- /.breadcrumb -->


        </div>

        <div class="page-content">

            <div class="page-header">
                <h1>
                    Danh sách khách hàng
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div>
            <div id="success-alert-container"
                 style="position: fixed; top: 75px; right: 20px; z-index: 1050; width: 300px;">
                <div id="success-alert" class="alert alert-success" style="display: none;">
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="widget-box">
                        <div class="widget-header ui-sortable-handle">
                            <h5 class="widget-title">Tìm kiếm</h5>

                            <div class="widget-toolbar">
                                <a href="#" data-action="collapse">
                                    <i class="ace-icon fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>

                        <div class="widget-body" style="font-family: 'Times New Roman', Times, serif;">
                            <form:form id="listForm" action="${customerListURL}" method="get"
                                       modelAttribute="modelSearch">
                                <div class="widget-main" id="listForm">
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-4">
                                                    <label class="name">Tên khách hàng</label>
                                                        <%--                                                        <input type="text" class="form-control" name="name" value="${modelSearch.name}">--%>
                                                    <form:input class="form-control" path="fullName"/>
                                                </div>
                                                <div class="col-xs-4">
                                                    <label class="name">Di động</label>
                                                        <%--                                                        <input type="number" class="form-control" name="floorArea" value="">--%>
                                                    <form:input class="form-control" path="phone"/>
                                                </div>
                                                <div class="col-xs-4">
                                                    <label class="name">Email</label>
                                                        <%--                                                        <input type="number" class="form-control" name="floorArea" value="">--%>
                                                    <form:input class="form-control" path="email"/>
                                                </div>
                                            </div>
                                        </div>
                                        <security:authorize access="hasRole('MANAGER')">
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-sm-4">
                                                        <label class="name">Chọn nhân viên</label>
                                                        <form:select class="form-control" path="staffId">
                                                            <form:option value="">---Chọn Nhân Viên---</form:option>
                                                            <form:options items="${staffsList}"/>

                                                        </form:select>

                                                    </div>
                                                </div>
                                            </div>
                                        </security:authorize>

                                        <div class="col-xs-12">
                                            <div class="col-xs-6">
                                                <button type="button" class="btn btn-xs btn-danger"
                                                        id="btnSearchBuilding">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                         fill="currentColor" class="bi bi-search"
                                                         viewBox="0 0 16 16">
                                                        <path
                                                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0">
                                                        </path>
                                                    </svg>
                                                    Tìm kiếm
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                    <form:hidden path="page"/>
                                </div>
                            </form:form>

                        </div>
                        <security:authorize access="hasRole('MANAGER')">
                            <div class="pull-right">
                                <a href="/admin/customer-edit">
                                    <button class="btn-info" title="Thêm khách hàng">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor"
                                             class="bi bi-person-fill-add" viewBox="0 0 16 16">
                                            <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                            <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
                                        </svg>
                                    </button>
                                </a>


                                <button class="btn-danger" title="Xóa khách hàng" id="btnDeleteCustomer">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-person-fill-dash" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                        <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
                                    </svg>
                                </button>
                            </div>
                        </security:authorize>
                    </div>
                </div>

            </div><!-- /.page-content -->

            <!-- Bảng danh sách tòa nhà -->
            <%--            <div class="row">--%>
            <%--                <div class="col-xs-12">--%>
            <%--                    <table id="tableList" style="margin: 3em 0 1.5em;"--%>
            <%--                           class="table table-striped table-bordered table-hover">--%>
            <%--                        <thead>--%>
            <%--                        <tr>--%>
            <%--                            <th class="center">--%>
            <%--                                <label class="pos-rel">--%>
            <%--                                    <input type="checkbox" class="ace" name="checkList" value="" id="checkAll">--%>
            <%--                                    <span class="lbl"></span>--%>
            <%--                                </label>--%>
            <%--                            </th>--%>
            <%--                            <th>Tên khách hàng</th>--%>
            <%--                            <th>Di động</th>--%>
            <%--                            <th>Email</th>--%>
            <%--                            <th>Nhu cầu</th>--%>
            <%--                            <th>Người thêm</th>--%>
            <%--                            <th>Ngày thêm</th>--%>
            <%--                            <th>Tình trạng</th>--%>
            <%--                            <th>Thao tác</th>--%>
            <%--                        </tr>--%>
            <%--                        </thead>--%>

            <%--                        <tbody>--%>
            <%--                        <c:forEach var="item" items="${customersList}">--%>
            <%--                        <tr>--%>
            <%--                            <td>--%>
            <%--                                <label class="pos-rel">--%>
            <%--                                    <input type="checkbox" class="ace" name="checkList" value="${item.id}" data-name="${item.fullName}">--%>

            <%--                                    <span class="lbl"></span>--%>
            <%--                                </label>--%>
            <%--                            </td>--%>
            <%--                            <td>${item.fullName}</td>--%>
            <%--                            <td>${item.phone}</td>--%>
            <%--                            <td>${item.email}</td>--%>
            <%--                            <td>${item.demand}</td>--%>
            <%--                            <td>${item.modifiedBy}</td>--%>
            <%--                            <td>${item.createdDate}</td>--%>
            <%--                            <td>${item.status}</td>--%>

            <%--                            <td>--%>
            <%--                                <div class="hidden-sm hidden-xs btn-group">--%>
            <%--                                    <button class="btn btn-xs btn-success" title="Giao khách hàng"--%>
            <%--                                            onclick="assignmentCustomer(${item.id})">--%>
            <%--                                        <i class="ace-icon glyphicon glyphicon-list"></i>--%>
            <%--                                    </button>--%>

            <%--                                    <a class="btn btn-xs btn-info" title="Sửa thông tin khách hàng"--%>
            <%--                                       href="/admin/customer-edit-${item.id}">--%>
            <%--                                        <i class="ace-icon fa fa-pencil bigger-120"></i>--%>
            <%--                                    </a>--%>

            <%--                                    <button class="btn btn-xs btn-danger" title="Xóa khách hàng"--%>
            <%--                                            onclick="deleteCustomer(${item.id}, '${item.fullName}')">--%>
            <%--                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>--%>
            <%--                                    </button>--%>
            <%--                                </div>--%>
            <%--                            </td>--%>
            <%--                        </tr>--%>

            <%--                        </c:forEach>--%>


            <%--                    </table>--%>
            <%--                </div><!-- /.span -->--%>
            <%--            </div>--%>

            <%--<div class="row">--%>
            <%--    <div class="col-xs-12">--%>
            <%--        <div class="table-responsive">--%>
            <%--            <display:table name="modelSearch.listResult" cellspacing="0" cellpadding="0"--%>
            <%--                           requestURI="${customerListURL}" partialList="true" sort="external"--%>
            <%--                           size="${modelSearch.totalItems}" pagesize="${modelSearch.maxPageItems}"--%>
            <%--                           export="false" id="item"--%>
            <%--                           class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"--%>
            <%--                           style="margin: 3em 0 1.5em;">--%>

            <%--                <display:column title="<fieldset class='form-group'><input type='checkbox' id='checkAll' class='check-box-element'></fieldset>"--%>
            <%--                                class="center select-cell" headerClass="center select-cell">--%>
            <%--                    <fieldset>--%>
            <%--                        &lt;%&ndash; item là biến lặp, đại diện cho CustomerSearchResponse &ndash;%&gt;--%>
            <%--                        <input type="checkbox" name="checkList" value="${item.id}"--%>
            <%--                               data-name="${item.fullName}" id="checkbox_${item.id}" class="check-box-element"/>--%>
            <%--                    </fieldset>--%>
            <%--                </display:column>--%>

            <%--                <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>--%>
            <%--                <display:column headerClass="text-left" property="phone" title="Di động"/>--%>
            <%--                <display:column headerClass="text-left" property="email" title="Email"/>--%>
            <%--                <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>--%>
            <%--                <display:column headerClass="text-left" property="assigneeName" title="Người thêm"/>--%>
            <%--                <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>--%>
            <%--                <display:column headerClass="text-left" property="status" title="Tình trạng"/>--%>

            <%--                <display:column headerClass="col-actions" title="Thao tác">--%>
            <%--                    <div class="hidden-sm hidden-xs btn-group">--%>
            <%--                        <button class="btn btn-xs btn-success" title="Giao khách hàng"--%>
            <%--                                onclick="assignmentBuilding(${item.id})">--%>
            <%--                            <i class="ace-icon glyphicon glyphicon-list"></i>--%>
            <%--                        </button>--%>

            <%--                        <a class="btn btn-xs btn-info" title="Sửa thông tin khách hàng"--%>
            <%--                           href="/admin/customer-edit-${item.id}">--%>
            <%--                            <i class="ace-icon fa fa-pencil bigger-120"></i>--%>
            <%--                        </a>--%>

            <%--                        <button class="btn btn-xs btn-danger" title="Xóa khách hàng"--%>
            <%--                                onclick="deleteBuilding(${item.id}, '${item.fullName}')">--%>
            <%--                            <i class="ace-icon fa fa-trash-o bigger-120"></i>--%>
            <%--                        </button>--%>
            <%--                    </div>--%>
            <%--                </display:column>--%>
            <%--            </display:table>--%>
            <%--        </div>--%>
            <%--    </div>--%>
            <%--</div>--%>


            <div class="hr-18 dotted-double"></div>
            <div class="row">
                <div class="col-xs-12">
                    <%-- Thay thế thẻ <table> bằng thẻ <display:table> --%>
                    <display:table name="customersList" cellspacing="0" cellpadding="0"
                                   requestURI="${customerListUrl}" partialList="true" sort="external"
                                   size="${model.totalItems}" defaultsort="1" defaultorder="ascending"
                                   id="tableList" pagesize="${model.maxPageItems}"
                                   class="table table-striped table-bordered table-hover dataTable no-footer"
                                   style="margin: 3em 0 1.5em;">

                        <security:authorize access="hasRole('MANAGER')">
                        <display:column title="<fieldset class='form-group'>
                <input type='checkbox' name='checkAll' class='check-box-element' id='checkAll'>
                </fieldset>" headerClass="center select-cell">
                            <fieldset>
                                <input type="checkbox"
                                       name="checkList"
                                       value="${tableList.id}"
                                       id="checkbox_${tableList.id}"
                                       class="check-box-element"
                                       data-name="${tableList.fullName}"/>
                            </fieldset>
                        </display:column>
                        </security:authorize>


                        <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>
                        <display:column headerClass="text-left" property="phone" title="Di động"/>
                        <display:column headerClass="text-left" property="email" title="Email"/>
                        <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>
                        <display:column headerClass="text-left" property="modifiedBy" title="Người thêm"/>
                        <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>
                        <display:column headerClass="text-left" property="status" title="Tình trạng"/>

                        <%-- Cột Thao tác --%>
                        <display:column headerClass="text-left" title="Thao tác">
                            <div class="hidden-sm hidden-xs btn-group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-success" title="Giao khách hàng"
                                            onclick="assignmentCustomer(${tableList.id})">
                                        <i class="ace-icon glyphicon glyphicon-list"></i>
                                    </button>
                                </security:authorize>

                                <a class="btn btn-xs btn-info" title="Sửa thông tin khách hàng"
                                   href="/admin/customer-edit-${tableList.id}">
                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                </a>
                                <security:authorize access="hasRole('MANAGER')">

                                    <button class="btn btn-xs btn-danger" title="Xóa khách hàng"
                                            onclick="deleteCustomer(${tableList.id}, '${tableList.fullName}')">
                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                    </button>
                                </security:authorize>
                            </div>
                        </display:column>
                    </display:table>
                </div>
            </div>

        </div>
    </div><!-- /.main-content -->


    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->
</div>


<div class="modal fade" id="assginmentCustomerModal" role="dialog"
     style="font-family: 'Times New Roman', Times, serif;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-bordered table-hover" id="staffList">
                    <thead>
                    <tr>
                        <th class="text-center">Chọn</th>
                        <th>Tên Nhân Viên</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <input type="hidden" id="customerId" name="Customer" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnassginmentCustomer">Giao khách hàng</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>
    function assignmentCustomer(customerId) {
        $('#customerId').val(customerId);
        loadStaff(customerId);
        // Mở modal
        $('#assginmentCustomerModal').modal('show');
    }

    function loadStaff(customerId) {
        $.ajax({
            type: "GET",
            url: `${customerAPI}/` + customerId + '/staffs',
            // data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "JSON",
            success: function (response) {
                var row = '';
                $.each(response.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="text-center"><input type="checkbox" value=' + item.staffId + ' id="checkbox_' + item.staffId + '" class="check-box-element"' + item.checked + '/></td>';
                    row += '<td class="text-center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);
                console.info("Success");
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
            }
        });
    }

    $('#btnassginmentCustomer').click(function (e) {
        e.preventDefault();
        var data = {};
        data['customerId'] = $('#customerId').val();
        var staffs = $('#staffList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['staffs'] = staffs;
        // if (data['staffs'] != '') {
        //     assingment(data);
        // }
        assingment(data);
        console.log("OK");
    });

    function assingment(data) {
        $.ajax({
            url: `${customerAPI}/assignments`,
            type: "PUT",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                window.location.href = "<c:url value='/admin/customer-list?message=update_success'/>";

                console.info("Succcess");
            },
            error: function (response) {
                console.info("Giao Không Thành Công!")
                window.location.href = "<c:url value='/admin/customer-list?message=error'/>";
                console.log(response);
            }
        });
    }

    // ĐOẠN CODE THAY THẾ BẮT ĐẦU

    // Hàm mới để hiển thị thanh thông báo thành công (Toast-like)
    function showAlert(message) {
        // Cập nhật nội dung và hiển thị Alert
        $('#success-alert').html('<button type="button" class="close" data-dismiss="alert"><i class="ace-icon fa fa-times"></i></button><strong>Thành công!</strong> ' + message);

        // Hiện thanh thông báo
        $('#success-alert').fadeIn();

        // Thiết lập tự động biến mất sau 3 giây
        setTimeout(function () {
            $('#success-alert').fadeOut();
        }, 3000);
    }

    // Logic kiểm tra message sau khi tải trang
    <c:if test="${not empty param.message}">
    <c:if test="${param.message == 'addorupdate_success'}">
    $(document).ready(function () {
        // Lấy tham số action
        var actionType = "${param.action}";
        var message = "";

        // Phân biệt thông báo dựa trên action
        if (actionType === "CREATED") {
            message = "Thêm khách hàng mới thành công.";
        } else if (actionType === "UPDATED") {
            message = "Cập nhật khách hàng thành công.";
        } else {
            message = "Thao tác khách hàng thành công."; // Mặc định
        }

        showAlert(message);
    });
    </c:if>

    <c:if test="${param.message == 'update_success'}">
    $(document).ready(function () {
        // Kích hoạt hàm hiển thị alert khi giao thành công
        showAlert("Giao khách hàng thành công.");
    });
    </c:if>

    <c:if test="${param.message == 'delete_success'}">
    $(document).ready(function () {
        // Kích hoạt hàm hiển thị alert khi xóa thành công
        showAlert("Xóa khách hàng thành công.");
    });
    </c:if>
    </c:if>


    // Gắn sự kiện cho nút Tìm kiếm
    $('#btnSearchBuilding').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    })

    // 1. Hàm xóa cho từng dòng (có thêm tham số tên)
    function deleteCustomer(id, name) {
        var buildingIds = [id];
        var buildingNames = [name];
        deleteCustomers(buildingIds, buildingNames);
    }

    // 2. Xử lý sự kiện khi click nút Xóa Tòa Nhà (nút lớn)
    $('#btnDeleteCustomer').click(function (e) {
        e.preventDefault();

        // Lấy danh sách các checkbox đã được chọn
        var selectedCheckboxes = $('#tableList').find('tbody input[type = checkbox][name = checkList]:checked');

        var customerIds = selectedCheckboxes.map(function () {
            return $(this).val();
        }).get();

        var customerNames = selectedCheckboxes.map(function () {
            // Lấy tên tòa nhà từ thuộc tính data-name
            return $(this).data('name');
        }).get();

        if (customerIds.length === 0) {
            alert("Vui lòng chọn ít nhất một khách hàng để xóa.");
            return;
        }

        deleteCustomers(customerIds, customerNames);
    });

    // 3. Hàm thực hiện xóa (thêm xác nhận với tên tòa nhà)
    function deleteCustomers(ids, names) {
        // Tạo chuỗi tên tòa nhà để hiển thị trong cửa sổ xác nhận
        var namesString = names.join(', ');

        // Hiển thị hộp thoại xác nhận
        var confirmDelete = confirm("Bạn có chắc chắn muốn xóa những khách hàng sau: \n" + namesString + "?");

        if (confirmDelete) {

            $.ajax({
                type: "DELETE",
                // Gửi các ID dưới dạng chuỗi ngăn cách bằng dấu phẩy
                url: "${customerAPI}/" + ids.join(','),
                contentType: "application/json",
                success: function (respond) {
                    alert("Xóa khách hàng thành công!");
                    window.location.href = "<c:url value='/admin/customer-list?message=delete_success'/>";
                },
                error: function (respond) {
                    alert("Xóa khách hàng không thành công!");
                    console.log(respond);
                    window.location.href = "<c:url value='/admin/customer-list?message=error'/>";
                }
            });
        }
    }

    $(document).ready(function () {
        $('#checkAll').click(function () {
            // Lấy trạng thái checked của checkbox tiêu đề
            var isChecked = this.checked;

            // Cập nhật trạng thái checked cho TẤT CẢ checkbox có name="checkList" (trong thân bảng)
            $('input[name="checkList"]').prop('checked', isChecked);
        });
    });
</script>

</body>
</html>

