<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/09/2025
  Time: 10:23 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerAPI" value="/api/customer"/>
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

                <form:form modelAttribute="customerEdit" method="get" id="listForm">
                <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                    <div class="col-xs-12">
                            <%-- Đã thay form class="form-horizontal" role="form" bằng thẻ form:form --%>
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-xs-3">Tên khách hàng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="fullName" id="name"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Số điện thoại</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="phone" id="phone"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Email</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="email" id="email"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Tên công ty</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="companyName" id="companyName"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Nhu cầu</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="demand"
                                                id="demand"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Tình trạng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" type="text" path="status" id="status"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3"></label>
                                <div class="col-xs-9">
                                    <c:if test="${not empty customerEdit.id}">
                                        <button class="btn btn-primary" id="btnAddOrUpdateCustomer">
                                            Cập nhập khách hàng
                                        </button>

                                        <button class="btn btn-primary" type="reset" id="btnCancel">
                                            Hủy thao tác
                                        </button>

                                    </c:if>
                                    <c:if test="${empty customerEdit.id}">

                                        <button class="btn btn-primary" id="btnAddOrUpdateCustomer">
                                            Thêm khách hàng
                                        </button>

                                        <button class="btn btn-primary" type="reset" id="btnCancel">
                                            Hủy thao tác
                                        </button>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                        <form:hidden path="id" id="customerId"></form:hidden>

                    </div>
                </div>
            </div>
            </form:form>
        </div>
    </div>
    <c:forEach var="item" items="${transactionType}">
        <div class="col-xs-12">
            <div class="col-sm-12">
                <h3 class="header smaller lighter blue">${item.value}</h3>
                <button class="btn btn-lg btn-primary" onclick="transactionType('${item.key}', '${customerEdit.id}')">
                    <i class="orange ace-icon fa fa-location-arrow bigger-130"></i>Add
                </button>
            </div>

                <%--        <c:if test="${item.key == 'CSKH'}">--%>
            <div class="col-xs-12">
                <table id="simple-table" class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>Ngày tạo</th>
                        <th>Người tạo</th>
                        <th>Ngày sửa</th>
                        <th>Người sửa</th>
                        <th>Chi tiết giao dịch</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="transaction" items="${cskhTransactions}">
                        <c:if test="${transaction.code == item.key}">
                            <tr>
                                <td>${transaction.createdDate}</td>
                                <td>${transaction.createdBy}</td>
                                <td>${transaction.modifiedDate}</td>
                                <td>${transaction.modifiedBy}</td>
                                <td>${transaction.note}</td>
                                <td>

                                    <a href="#" class="btn btn-xs btn-info"
                                       onclick="updateTransaction('${transaction.id}', '${item.key}', '${customerEdit.id}', '${transaction.note}')">Sửa</a>
                                    <security:authorize access="hasRole('MANAGER')">
                                        <a href="#" class="btn btn-xs btn-danger"
                                           onclick="deleteTransaction('${transaction.id}')">Xóa</a>
                                    </security:authorize>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${empty cskhTransactions}">
                        <tr>
                            <td colspan="4" class="text-center">Không có dữ liệu giao dịch CSKH.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
                <%--        </c:if>--%>
        </div>
    </c:forEach>

    <div class="modal fade" id="transactionTypeModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Nhập giao dịch</h4>
                </div>

                <div class="modal-body">
                    <div class="form-group has-success">
                        <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">Chi
                            tiết giao dịch</label>
                        <div class="col-xs-12 col-sm-9">
                        <span class="block input-icon input-icon-right">
                            <input type="text" id="transactionDetail" class="width-100">
                        </span>
                        </div>
                    </div>
                    <input type="hidden" name="customerId" id="customerId" value="">
                    <input type="hidden" name="code" id="code" value="">
                    <input type="hidden" name="id" id="id" value="">
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnAddOrUpdateTransaction">Thêm giao dịch</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>

            </div>
        </div>
    </div>
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div>
</div></div>


<script>

    function transactionType(code, customerId) {
        $('#btnAddOrUpdateTransaction').text('Thêm giao dịch');
        $('#id').val('');
        $('#transactionDetail').val('');
        $('#customerId').val(customerId);
        $('#code').val(code);
        $('#transactionTypeModal').modal();
    }

    function updateTransaction(id, code, customerId, note) {
        $('#btnAddOrUpdateTransaction').text('Sửa giao dịch');
        $('#id').val(id);
        $('#customerId').val(customerId);
        $('#code').val(code);
        $('#transactionDetail').val(note);
        $('#transactionTypeModal').modal();
    }

    $('#btnAddOrUpdateTransaction').click(function (e) {
        e.preventDefault();
        var data = {};
        data['id'] = $('#id').val();
        data['customerId'] = $('#customerId').val();
        data['code'] = $('#code').val();
        data['transactionDetail'] = $('#transactionDetail').val();
        //customerId + codeTransaction + transactionDetail
        addOrUpdateTransaction(data);
    });

    function addOrUpdateTransaction(data) {
        var customerId = data.customerId;
        $.ajax({
            type: "POST",
            url: "/api/customer/transaction",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                console.log("Success");
                console.log(response);
                var id = response.id;
                var actionType = response.action;
                var urlTemplate = "<c:url value='/admin/customer-edit-{id}?message=addorupdate_success&action='/>";

                // 2. JavaScript thay thế placeholder bằng customerId thực tế
                var redirectUrl = urlTemplate.replace('{id}', customerId) + actionType;
                window.location.href = redirectUrl;
            },
            error: function (response) {
                console.log("failed");
                // 3. URL Template Lỗi tĩnh
                var errorUrlTemplate = "<c:url value='/admin/customer-edit-{id}?message=error'/>";

                // 4. JavaScript thay thế placeholder bằng customerId
                var errorUrl = errorUrlTemplate.replace('{id}', customerId);

                window.location.href = errorUrl;
                console.log(response);
            }
        });
    }

    $('#btnAddOrUpdateCustomer').click(function () {
        event.preventDefault();
        var formData = $('#listForm').serializeArray();
        var data = {};

        $.each(formData, function (i, v) {
            data["" + v.name + ""] = v.value;
        });
        if (Object.keys(data).length > 0) {
            addOrUpdateCustomer(data);
        } else {
            window.location.href = "<c:url value="/admin/customer-edit?typeCode=require"/>";
        }

    })

    function addOrUpdateCustomer(data) {
        $.ajax({
            type: "POST",
            url: "${customerAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                console.log("Success");
                console.log(response);

                var actionType = response.action;
                var redirectUrl = "<c:url value='/admin/customer-list?message=addorupdate_success&action='/>" + actionType;
                window.location.href = redirectUrl;
            },
            error: function (response) {
                console.log("failed");
                window.location.href = "<c:url value='/admin/customer-list?message=error'/>"
                console.log(response);
            }
        });
    }

    function deleteTransaction(id) {
        var confirmDelete = confirm("Bạn có chắc chắn muốn xóa giao dịch này không " + "?");

        if (confirmDelete) {

            $.ajax({
                type: "DELETE",
                // Gửi các ID dưới dạng chuỗi ngăn cách bằng dấu phẩy
                url: "/api/customer/transaction/" + id,
                contentType: "application/json",
                dataType: "json",
                success: function (respond) {
                    alert("Xóa giao dịch thành công!");
                    var customerId = respond.customerId;
                    var successUrl = "<c:url value='/admin/customer-edit-{id}?message=delete_success'/>";
                    window.location.href = successUrl.replace("{id}", customerId);
                },
                error: function (respond) {
                    alert("Xóa giao dịch không thành công!");
                    console.log(respond);
                    window.location.href = "<c:url value='/admin/customer-edit-{id}?message=error'/>";
                }
            });
        }
    }

    $('#btnCancel').click(function () {
        window.location.href = "/admin/customer-list";
    })
</script>

</body>
</html>

